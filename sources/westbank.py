#!/usr/bin/env python3

import html

from skoolkit.graphics import Frame, Udg as BaseUdg
from skoolkit.skoolhtml import HtmlWriter
from skoolkit.skoolmacro import parse_image_macro, MacroParsingError


class WestBankHtmlWriter(HtmlWriter):
    def init(self):
        self.characters = self.get_dictionary('Characters')

    def _clear_screen_buffer(self):
        self.snapshot[0x4000:0x5B00] = [0x00] * 0x1B00

    def _copy_routine(self, dest, source, length, lines):
        for line in range(lines):
            self.snapshot[dest:dest + length] = self.snapshot[source:source + length]
            dest = self._get_line_below(dest)
            source += length

    def _get_line_below(self, mem_location):
        h, l = mem_location >> 0x08, mem_location & 0xFF
        h += 1
        if h & 0x07 == 0:
            h = (h - 0x08) & 0xFF
            l = (l + 0x20) & 0xFF
            if l < 0x20:
                h = (h + 0x08) & 0xFF
        return h * 0x100 + l

    def _draw_playfield(self):
        # Copy the attributes first.
        self.snapshot[0x5800:0x5B00] = self.snapshot[0xED00:0xF000]
        # Slot numbers (left).
        self._copy_routine(0x4001, 0xDFA0, 0x0C, 0x08)
        # Slot numbers (right).
        self._copy_routine(0x4013, 0xE000, 0x0C, 0x08)
        # Centerpiece (till).
        self._copy_routine(0x400E, 0xE060, 0x04, 0x18)
        # Doors top.
        self._copy_routine(0x4060, 0xE0C0, 0x20, 0x08)
        # Wall left.
        self._copy_routine(0x4080, 0xE1C0, 0x02, 0x58)
        # Wall middle 1.
        self._copy_routine(0x4089, 0xE270, 0x04, 0x58)
        # Wall middle 2.
        self._copy_routine(0x4094, 0xE270, 0x04, 0x58)
        # Door frame side.
        self._copy_routine(0x409F, 0xE3D0, 0x01, 0x58)
        # Doors bottom.
        self._copy_routine(0x48E0, 0xE428, 0x20, 0x08)
        # Tellers.
        self._copy_routine(0x5020, 0xE528, 0x20, 0x20)
        # Score text.
        self._copy_routine(0x50C1, 0xE928, 0x06, 0x10)
        # Lives text.
        self._copy_routine(0x50B0, 0xE988, 0x06, 0x16)

    def get_play_area_udgs(self, x, y, w, h, df_addr=16384, af_addr=22528):
        width = min((w, 0x20 - x))
        height = min((h, 0x18 - y))
        udgs = []
        for r in range(y, y + height):
            attr_addr = af_addr + 0x20 * r + x
            addr = df_addr + 0x800 * (r // 0x08) + 0x20 * (r % 0x08) + x
            udgs.append([Udg(self.snapshot[attr_addr + i], self.snapshot[addr + i:addr + i + 0x800:0x100]) for i in range(width)])
        return udgs

    def _play_area_udgs(self, x, y, w, h):
        self.push_snapshot()
        self._clear_screen_buffer()
        self._draw_playfield()
        udgs = self.get_play_area_udgs(x, y, w, h)
        self.pop_snapshot()
        return udgs

    def play_area(self, cwd, fname, x=0x00, y=0x00, w=0x20, h=0x18, scale=2):
        frame = Frame(lambda: self._play_area_udgs(x, y, w, h), scale)
        return self.handle_image(frame, fname, cwd, path_id='PlayAreaImagePath')


class Udg(BaseUdg):
    def __init__(self, attr, data, mask=None, attr_addr=None, ref_addr=None, ref=None, udg_page=None, x=None, y=None, fg_udg=None):
        BaseUdg.__init__(self, attr, data, mask)
        self.attr_addr = attr_addr
        self.ref_addr = ref_addr
        self.ref = ref
        self.udg_page = udg_page
        self.udg_addr = None if udg_page is None else ref + 256 * udg_page
        self.x = x
        self.y = y
        self.fg_udg = fg_udg
