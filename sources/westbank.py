# Copyright 2021 Paul Maddern
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, either version 3 of the License, or (at your option) any later
# version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program. If not, see <http://www.gnu.org/licenses/>.

from skoolkit.graphics import Frame, Udg as BaseUdg
from skoolkit.skoolhtml import HtmlWriter
from skoolkit.skoolmacro import parse_image_macro, MacroParsingError


class Udg(BaseUdg):
    def __init__(self, attr, data, mask=None, x=None, y=None):
        BaseUdg.__init__(self, attr, data, mask)
        self.x = x
        self.y = y


class WestBankHtmlWriter(HtmlWriter):

    def play_area(self, cwd, fname, x, y, w=1, h=1, scale=2, show_chars=0, show_x=0):
        frame = Frame(lambda: self.get_playfield(x, y, w, h, show_chars, show_x), scale)
        return self.handle_image(frame, fname, cwd, path_id='PlayAreaImagePath')

    def get_playfield(x, y, w, h, show_chars, show_x):
        return
