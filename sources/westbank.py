#!/usr/bin/env python3

import html

from skoolkit.graphics import Frame, Udg as BaseUdg
from skoolkit.skoolhtml import HtmlWriter
from skoolkit.skoolmacro import parse_image_macro, MacroParsingError


class WestBankHtmlWriter(HtmlWriter):
    def init(self):
        self.characters = self.get_dictionary('Characters')

    def get_play_area_udgs(self, x, y, w, h, df_addr=16384, af_addr=22528):
        width = min((w, 32 - x))
        height = min((h, 24 - y))
        udgs = []
        for r in range(y, y + height):
            attr_addr = af_addr + 32 * r + x
            addr = df_addr + 2048 * (r // 8) + 32 * (r % 8) + x
            udgs.append([Udg(self.snapshot[attr_addr + i], self.snapshot[addr + i:addr + i + 2048:256]) for i in range(width)])
        return udgs

    def _play_area_udgs(self, x, y, w, h):
        self.push_snapshot()
        udgs = self.get_play_area_udgs(x, y, w, h)
        self.pop_snapshot()
        return udgs

    def play_area(self, cwd, fname, x=0, y=0, w=32, h=24, scale=2):
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
