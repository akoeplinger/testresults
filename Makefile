REACT_VERSION = 0.14.3
JQUERY_VERSION = 2.1.4
ifdef DEBUG
	REACT_URL     = https://fb.me/react-$(REACT_VERSION).js
	REACT_DOM_URL = https://fb.me/react-dom-$(REACT_VERSION).js
	JQUERY_URL    = http://code.jquery.com/jquery-$(JQUERY_VERSION).js
else
	REACT_URL     = https://fb.me/react-$(REACT_VERSION).min.js
	REACT_DOM_URL = https://fb.me/react-dom-$(REACT_VERSION).min.js
	JQUERY_URL    = http://code.jquery.com/jquery-$(JQUERY_VERSION).js
endif

all: install/index.html install/style.css \
	 install/js/test-results.js install/js/test-download.js \
	 install/js/helper.js install/js/helper-react.js \
	 install/js/react-dom.js install/js/react.js install/js/jquery.js

tsd:
	tsd init
	tsd install react-global jquery --save

install/index.html install/style.css: static/index.html static/style.css
	rsync -urhi --exclude=.DS_Store static/ install/

install/js/react.js:
	mkdir -p install
	curl -L $(REACT_URL) > $@

install/js/react-dom.js:
	mkdir -p install
	curl -L $(REACT_DOM_URL) > $@

install/js/jquery.js:
	mkdir -p install
	curl -L $(JQUERY_URL) > $@

install/js/test-results.js install/js/test-download.js install/js/helper.js install/js/helper-react.js: ts/test-results.tsx ts/test-download.ts ts/helper.ts ts/helper-react.tsx
	mkdir -p install/js
	tsc -p ts

clean:
	rm -rf install/*
