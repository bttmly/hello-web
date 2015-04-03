test-ci: ; ./test/node_modules/.bin/coffee ./test/child-runner.coffee

install: ; 
	cd test && npm install
	cd node/express && npm install
	cd python/flask && sudo pip install virtualenv && virtualenv env && sh env/bin/activate
	cd python/flask && sudo pip install -r requirements.txt
	cd ruby/sinatra && bundle install

.PHONY: test
