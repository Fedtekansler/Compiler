OUTDIR=out
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

# create the standalone executable using the "current" lexer

tigerc.x86-linux:
	ml-build sources.cm Main.exportedFn tigerc

# abbreviations

ia: interact

sa: standalone

rs: rescue

# compile tests

test: tigerc.x86-linux
	./compiletests

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

