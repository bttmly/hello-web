test: ; ./test/node_modules/.bin/coffee ./test/index.coffee

install: ;
	cd test && npm install
	cd node/express && npm install

.PHONY: test
