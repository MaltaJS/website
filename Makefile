elm:
	gulp elm
	gulp elm-bundle
	node_modules/.bin/elm-static-html -c elm-static-html.json
templates:
	gulp html:app
	gulp html:static
styles:
	gulp styles
	cp node_modules/bootstrap/dist/css/bootstrap.min.css www/assets/css/
clean:
	gulp clean
copy:
	gulp copy
	# can't use gulp properly, I'm sorry
	cp -r source/images www/assets
all:
	make clean && make elm && make templates && make styles && make copy

