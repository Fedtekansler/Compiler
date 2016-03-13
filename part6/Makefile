# compiler output goes into this subdirectory of the source directory
OUTDIR=out

# NB: 'export TDP_INSTRUMENT=true' enables back tracking in case
# of uncaught exceptions, but only if defined also during compilation
SMLOPTS=-Ccontrol.poly-eq-warn=false -m '$$smlnj-tdp/back-trace.cm'

# set up SML for interactive use

interact:
	rlwrap sml $(SMLOPTS) sources.cm

# generate the runtime system

runtime.o: runtime.c Makefile
	gcc -c -g -o runtime.o runtime.c

showstack.o: showstack.c Makefile
	gcc -c -o showstack.o showstack.c

# create a standalone executable via tigerc.x86-linux, used by tigerc

standalone:
	./forcetigerc generated
	ml-build sources.cm Main.exportedFn tigerc

# use this for parsing .frag trees only

sa2:
	./forcetigerc generated
	ml-build sources.cm Main2.exportedFn tigerc2

# create a standalone executable using the 'rescue' lexer/parser

rescue:
	./forcetigerc rescue
	ml-build sources.cm Main.exportedFn tigerc

# create the standalone executable using the "current" lexer/parser

tigerc.x86-linux:
	ml-build sources.cm Main.exportedFn tigerc

tigerc2.x86-linux:
	ml-build sources.cm Main2.exportedFn tigerc2

# abbreviations

ia: interact

sa: standalone

rs: rescue

ts: test

ct: clean test

ct2: clean test2

testrun2: clean sa2
	./test_run2

# compile tests

test: tigerc.x86-linux
	./compiletests
	./test_cmp
	./test_run

test2: tigerc.x86-linux tigerc2.x86-linux
	./compiletests2
	./test_cmp2
	./test_run2

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
	rm -f tigerc2.x86-linux

