BUILDDIR = build

OPTIONS  = -d build/html -t

OPTIONS += $(foreach theme,$(THEMES),-T $(theme))
OPTIONS += $(HTML_OPTS)

.PHONY: usage clean westbank
usage:
	@echo "Targets:"
	@echo "  usage      show this help"
	@echo "  westbank   build the West Bank disassembly"
	@echo ""
	@echo "Variables:"
	@echo "  THEMES     CSS theme(s) to use"
	@echo "  HTML_OPTS  options passed to skool2html.py"

.PHONY: clean
clean:
	-rm -rf $(BUILDDIR)/*

.PHONY: westbank
westbank:
	if [ ! -f WestBank.z80 ]; then tap2sna.py @westbank.t2s; fi
	sna2skool.py -H -c sources/westbank.ctl WestBank.z80 > sources/westbank.skool
	skool2html.py $(OPTIONS) -D -c Config/GameDir=westbank/dec -c Config/InitModule=sources:bases sources/westbank.skool sources/westbank.ref
	skool2html.py $(OPTIONS) -H -c Config/GameDir=westbank/hex -c Config/InitModule=sources:bases sources/westbank.skool sources/westbank.ref

all : westbank
.PHONY : all
