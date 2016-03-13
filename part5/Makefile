# compiler output goes into this subdirectory of the source directory
OUTDIR=out

# NB: 'export TDP_INSTRUMENT=true' enables back tracking in case
# of uncaught exceptions, but only if defined also during compilation
SMLOPTS=-Ccontrol.poly-eq-warn=false -m '$$smlnj-tdp/back-trace.cm'

# set up SML for interactive use

interact:
	rlwrap sml $(SMLOPTS) sources.cm

# create a standalone executable via tigerc.x86-linux, used by tigerc

standalone:
	./forcetigerc generated
	ml-build sources.cm Main.exportedFn tigerc

# create a standalone executable using the 'rescue' lexer/parser

rescue:
	./forcetigerc rescue
	ml-build sources.cm Main.exportedFn tigerc

# create the standalone executable using the "current" lexer/parser

tigerc.x86-linux:
	ml-build sources.cm Main.exportedFn tigerc

# abbreviations

ia: interact

sa: standalone

rs: rescue

ts: test

ct: clean test

# compile tests

test: tigerc.x86-linux
	@mkdir out 2>/dev/null || true
	@./compiletests

# prepare for emacs multi-file search based on a 'TAGS' file

TAGS:
	etags *.sml

# reminder about how to get help

smlopts:
	sml -help | less

smlvars:
	sml -E | less

# remove generated files, enforce full recompile/regenerate action

clean:
	rm -rf .cm
	rm -rf $(OUTDIR)
	rm -f tiger.lex.* tiger.grm.*
	rm -f tigerc.x86-linux

