todo.js: todo.hs View.hs Model.hs
	hastec -Wall -fno-warn-unused-do-bind todo.hs

# to install wr:  npm install -g wr
watch:
	wr --exec make *.hs 