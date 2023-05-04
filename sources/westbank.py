#!/usr/bin/env python3

import html

from skoolkit.graphics import Frame, Udg
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

    def _draw_cashboxes(self, cashboxes):
        if len(cashboxes) <= 12:
            cashboxes += [0] * (12 - len(cashboxes))
            addr = 0x4021
            for box in cashboxes[:6]:
                if box:
                    self._copy_routine(addr, 0xFF98, 0x02, 0x10)
                else:
                    self._copy_routine(addr, 0xFF78, 0x02, 0x10)
                addr += 0x02
            addr = 0x4033
            for box in cashboxes[6:]:
                if box:
                    self._copy_routine(addr, 0xFF98, 0x02, 0x10)
                else:
                    self._copy_routine(addr, 0xFF78, 0x02, 0x10)
                addr += 0x02

    def _draw_character(self, character, door):
        frame = 0x6800 + character * 0x200 + character * 0x10
        if 0x6800 <= frame <= 0xB870:
            self._copy_routine(0x4077 + 0x0B * door, frame, 0x06, 0x58)

    def _set_time_of_day(self, time):
        if time == 'dusk':
            self.snapshot[0xD6B9:0xD6D0] = self.snapshot[0xC987:0xC99E]
        elif time == 'night':
            self.snapshot[0xD6B9:0xD6D0] = self.snapshot[0xC99F:0xC9B6]
        else:
            # Technically not needed, this is the default.
            # But it saves throwing an exception for bad input.
            self.snapshot[0xD6B9:0xD6D0] = self.snapshot[0xC96F:0xC986]

    def _draw_door(self, door, frame):
        if frame == 1:
            self._copy_routine(0x4077 + 0x0B * door, 0xBA80, 0x07, 0x58)
        elif frame == 2:
            self._copy_routine(0x4079 + 0x0B * door, 0xBCE8, 0x05, 0x58)
        elif frame == 3:
            self._copy_routine(0x407B + 0x0B * door, 0xBEA0, 0x03, 0x58)
        else:
            self._copy_routine(0x407D + 0x0B * door, 0xBFA8, 0x01, 0x58)
        # Paint the door.
        attr = 0x5877 + door * 0x0B
        for _ in range(0x0B):
            paint = 0xD6A9 + frame * 0x08
            self.snapshot[attr:attr + 0x07] = self.snapshot[paint:paint + 0x07]
            attr += 0x20

    def _highlight_doors(self, door):
        if 0x00 < door < 0x0D:
            for i in range(door, door + 0x03):
                i = i if i <= 0x0C else i - 0x0C
                addr = 0x02 * (i - 0x01) + (0x5801 if i < 0x07 else 0x5807)
                self.snapshot[addr:addr + 0x02] = [0x3A] * 0x02

    def _draw_score(self, score):
        screen_loc = 0x50C8
        base_addr = 0xC230
        for digit in str(score).rjust(6, '0'):
            digit_value = int(digit)
            addr = base_addr + digit_value * 0x10 if digit_value > 0 else 0xC2D0
            self._copy_routine(screen_loc, addr, 0x01, 0x10)
            screen_loc += 0x01

    def _draw_lives(self, lives):
        addr = 0x50B6
        for l in range(min(lives, 5)):
            self._copy_routine(addr + 0x02 * l, 0xFFB8, 0x02, 0x18)

    def get_play_area_udgs(self, x, y, w, h, df_addr=16384, af_addr=22528):
        width = min(w, 0x20 - x)
        height = min(h, 0x18 - y)
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
