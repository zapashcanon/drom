
# Generated by "drom project"
.PHONY: all build build-deps sphinx doc-common odoc view fmt fmt-check install dev-deps test
.PHONY: clean distclean

DEV_DEPS := merlin ocamlformat odoc ppx_expect ppx_inline_test

all: build

build:
	opam exec -- dune build @install
	cp -f _build/default/src/drom/main.exe drom

build-deps:
	if ! [ -e _opam ]; then \
	   opam switch create . --empty && \
	   opam install ocaml.4.10.0 ; \
	fi
	opam install ./*.opam --deps-only

doc-common:
	opam exec -- dune build @doc
	mkdir -p _drom/docs
	rsync -auv docs/. _drom/docs/.

sphinx: doc-common 
	if [ -e ./scripts/before-sphinx.sh ]; then \
		./scripts/before-sphinx.sh _drom/docs/sphinx; \
	else \
		echo No file ./scripts/before-sphinx.sh; \
	fi
	sphinx-build sphinx _drom/docs/sphinx

odoc: doc-common 
	mkdir -p _drom/docs/doc/.
	rsync -auv --delete _build/default/_doc/_html/. _drom/docs/doc

doc: doc-common odoc sphinx

view:
	xdg-open file://$$(pwd)/_drom/docs/index.html

fmt:
	opam exec -- dune build @fmt --auto-promote

fmt-check:
	opam exec -- dune build @fmt

install:
	opam exec -- dune install

opam:
	opam pin -k path .

uninstall:
	opam exec -- dune uninstall

dev-deps:
	opam install ./*.opam --deps-only --with-doc --with-test

test:
	opam exec -- dune build @runtest

clean:
	rm -rf _build

distclean: clean
	rm -rf _opam _drom


