  $ dune exec ../bin/main.exe ../examples/shapes.pic shapes.svg
  $ cat shapes.svg
  $ dune exec ../bin/main.exe -- ../examples/malformed_circle.pic malformed_circle.svg 
  $ dune exec ../bin/main.exe -- ../examples/malformed_rectangle.pic malformed_rectangle.svg
  $ dune exec ../bin/main.exe -- ../examples/malformed_line_width_nonint.pic no.svg 
  $ dune exec ../bin/main.exe -- ../examples/malformed_line_width_nonpos.pic no.svg
  $ dune exec ../bin/main.exe -- ../examples/malformed_text_size.pic no.svg
  $ dune exec ../bin/main.exe -- ../examples/malformed_text_empty.pic no.svg
