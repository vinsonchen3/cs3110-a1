  $ dune exec ../bin/main.exe ../examples/canvas.pic canvas.svg
  $ cat canvas.svg
  $ dune exec ../bin/main.exe ../examples/canvas_none.pic canvas_none.svg
  $ cat canvas_none.svg
  $ dune exec ../bin/main.exe ../examples/canvas_malformed.pic canvas_malformed.svg
  $ dune exec ../bin/main.exe ../examples/shapes.pic shapes.svg
  $ cat shapes.svg
  $ dune exec bin/main.exe -- examples/malformed_circle.pic examples/malformed_circle.svg 
  $ dune exec bin/main.exe -- examples/malformed_rectangle.pic examples/malformed_rectangle.svg
