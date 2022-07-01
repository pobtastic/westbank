West Bank
=========

A disassembly of the [Spectrum](https://en.wikipedia.org/wiki/ZX_Spectrum) version of [Bank Panic](https://en.wikipedia.org/wiki/Bank_Panic) called "West Bank", created using [SkoolKit](https://skoolkit.ca).


SkoolKit
--------

[SkoolKit](http://skoolkit.ca/) is the peerless Python toolkit for disassembling ZX Spectrum software written by [Richard Dymond](https://github.com/skoolkid).

Usage
-----

```
git clone git@github.com:pobtastic/disassemblies.git
cd disassemblies/westbank
sna2skool.py -H -c westbank.ctl WestBank.z80 > westbank.skool
skool2html.py -H westbank.skool
```

Disclaimer
----------

No game code is included in this repository, you will need to own the original game in order to disassemble the game code.

1985 [Dinamic Software (Spain)](https://en.wikipedia.org/wiki/Dinamic_Software)
1985 [Gremlin Graphics Software Ltd (UK)](https://en.wikipedia.org/wiki/Gremlin_Interactive)
