#!/usr/bin/env python3

import sys
import os
import argparse

SKOOLKIT_HOME = os.environ.get('SKOOLKIT_HOME')
if not SKOOLKIT_HOME:
    sys.stderr.write('SKOOLKIT_HOME is not set; aborting\n')
    sys.exit(1)
if not os.path.isdir(SKOOLKIT_HOME):
    sys.stderr.write('SKOOLKIT_HOME={}; directory not found\n'.format(SKOOLKIT_HOME))
    sys.exit(1)
sys.path.insert(0, SKOOLKIT_HOME)

WESTBANK_HOME = os.environ.get('WESTBANK_HOME')
if not WESTBANK_HOME:
    sys.stderr.write('WESTBANK_HOME is not set; aborting\n')
    sys.exit(1)
if not os.path.isdir(WESTBANK_HOME):
    sys.stderr.write('WESTBANK_HOME={}; directory not found\n'.format(WESTBANK_HOME))
    sys.exit(1)
sys.path.insert(0, '{}/sources'.format(WESTBANK_HOME))

from skoolkit.image import ImageWriter
from skoolkit.refparser import RefParser
from skoolkit.skoolhtml import Frame
from skoolkit.snapshot import get_snapshot
from westbank import WestBankHtmlWriter


class WestBank(WestBankHtmlWriter):
    def __init__(self, snapshot):
        self.snapshot = snapshot
        self.defaults = RefParser()
        self.ref_parser = RefParser()
        self.ref_parser.parse('{}/sources/westbank.ref'.format(WESTBANK_HOME))
        self.init()


def _do_pokes(specs, snapshot):
    for spec in specs:
        addr, val = spec.split(',', 1)
        step = 1
        if '-' in addr:
            addr1, addr2 = addr.split('-', 1)
            addr1 = int(addr1)
            if '-' in addr2:
                addr2, step = [int(i) for i in addr2.split('-', 1)]
            else:
                addr2 = int(addr2)
        else:
            addr1 = int(addr)
            addr2 = addr1
        addr2 += 1
        value = int(val)
        for a in range(addr1, addr2, step):
            snapshot[a] = value


def run(imgfname, options):
    snapshot = get_snapshot('{}/WestBank.z80'.format(WESTBANK_HOME))
    _do_pokes(options.pokes, snapshot)
    game = WestBank(snapshot)
    game._clear_screen_buffer()
    game._draw_playfield()
    game._set_time_of_day(options.time)
    game._draw_cashboxes(list(map(int, options.cashboxes.split(','))))
    game._highlight_doors(options.highlight)
    game._draw_score(options.score)
    game._draw_lives(options.lives)
    for spec in options.place_char:
        n = spec.split(',')
        if len(n) == 2:
            character, door = list(map(int, n))
            if 1 <= door <= 3:
                game._draw_character(character, door)
    for spec in options.place_door:
        n = spec.split(',')
        if len(n) == 2:
            door, frame = list(map(int, n))
            if 1 <= door <= 3 and 1 <= frame <= 4:
                game._draw_door(door, frame)
    udg_array = game.get_play_area_udgs(0, 0, 0x20, 0x18)
    if options.geometry:
        wh, xy = options.geometry.split('+', 1)
        width, height = [int(n) for n in wh.split('x')]
        x, y = [int(n) for n in xy.split('+')]
        udg_array = [row[x:x + width] for row in udg_array[y:y + height]]
    frame = Frame(udg_array, options.scale)
    image_writer = ImageWriter()
    with open(imgfname, "wb") as f:
        image_writer.write_image([frame], f)


###############################################################################
# Begin
###############################################################################
parser = argparse.ArgumentParser(
    usage='westbankimage.py [options] FILE.png',
    description="Create an image of the background in West Bank.",
    formatter_class=argparse.RawTextHelpFormatter,
    add_help=False
)
parser.add_argument('imgfname', help=argparse.SUPPRESS, nargs='?')
group = parser.add_argument_group('Options')
group.add_argument('-b', dest='cashboxes', metavar='0,1',
                   help="Set the state of the cashboxes, maximum of 12.")
group.add_argument('-c', dest='place_char', metavar='C,D', action='append', default=[],
                   help="Place character frame C in door frame D (1, 2 or 3)\n"
                        "(this option may be used multiple times); if D is blank,\n"
                        "that frame is left unchanged\n"
                        "  00: Bandit 1 (draw)         01: Bandit 1 (shot)\n"
                        "  02: Bandit 1 (floor)        03: Green Jordan (depositing)\n"
                        "  04: Green Jordan (hands up) 05: Green Jordan (uncover)\n"
                        "  06: Green Jordan (shot)     07: Green Jordan (floor)\n"
                        "  08: Bandit 2 (draw)         09: Bandit 2 (shot)\n"
                        "  10: Daisy (depositing)      11: Daisy (hands up)\n"
                        "  12: Daisy (uncover)         13: Daisy (shot)\n"
                        "  14: Daisy (floor)           15: Bandit 3 (draw)\n"
                        "  16: Bandit 3 (stand off)    17: Bandit 3 (shot)\n"
                        "  18: Bandit 4 (stand off)    19: Bandit 4 (draw)\n"
                        "  20: Bandit 4 (shot)         21: Bandit 5 (stand off)\n"
                        "  22: Bandit 5 (draw)         23: Bandit 5 (shot)\n"
                        "  24: Bandit 6 (stand off)    25: Bandit 6 (draw)\n"
                        "  26: Bandit 6 (shot)         27: Bowie (7 hats)\n"
                        "  28: Bowie (6 hats)          29: Bowie (5 hats)\n"
                        "  30: Bowie (4 hats)          31: Bowie (3 hats)\n"
                        "  32: Bowie (2 hats)          33: Bowie (1 hat)\n"
                        "  34: Bowie (bomb)            35: Bowie (cash)\n"
                        "  36: Bandit 7 (stand off)    37: Bandit 7 (draw)\n"
                        "  38: Bandit 7 (shot)         39: Bandit 7 (floor)")
group.add_argument('-d', dest='place_door', metavar='D,F', action='append', default=[],
                   help="In door D (1, 2 or 3), place frame F (1, 2, 3 or 4)\n"
                        "(this option may be used multiple times); if D is blank,\n"
                        "that frame is left unchanged\n"
                        "  01: Door is shut            02: Door is only slightly open\n"
                        "  03: Door is nearly open     04: Door is fully open")
group.add_argument('-g', dest='geometry', metavar='WxH+X+Y',
                   help='Create an image with this geometry')
group.add_argument('-h', dest='highlight', type=int, default=1,
                   help='Set which door to highlight as active "from this number" (default: 1)')
group.add_argument('-l', dest='lives', type=int, default=2,
                   help='Set the number of lives to display (default: 2)')
group.add_argument('-p', dest='pokes', metavar='A[-B[-C]],V', action='append', default=[],
                   help="Do POKE N,V for N in {A, A+C, A+2C,...B} (this option may\n"
                        "be used multiple times)")
group.add_argument('-s', dest='scale', type=int, default=2,
                   help='Set the scale of the image (default: 2)')
group.add_argument('-t', dest='time', type=str, default="day",
                   help='Set the time of day (default: day)\n'
                   "  valid options: day, dusk, night.")
group.add_argument('-z', dest='score', type=int, default=500,
                   help='Set the score for the image (default: 500)')
namespace, unknown_args = parser.parse_known_args()
if unknown_args or not namespace.imgfname:
    parser.exit(2, parser.format_help())
run(namespace.imgfname, namespace)

