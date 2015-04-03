test-ci: ; ./test/node_modules/.bin/coffee ./test/child-runner.coffee

install: ; 
	cd test && npm install
	cd node/express && npm install

.PHONY: test
