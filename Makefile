.PHONY: default test selftest compile-scheme build run clean

default: test

test: selftest

selftest:
	bash bin/run.sh

compile-scheme:
	bash bin/get-scheme.sh

build: clean
	bash bin/build.sh

# Same as self-test but runs compiled code.
run:
	bash bin/run.sh --so

clean:
	bash bin/clean.sh
