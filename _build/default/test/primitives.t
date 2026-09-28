  $ dune exec ../bin/main.exe ../examples/shapes.pic shapes.svg
  $ cat shapes.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="500" height="300" viewBox="0 0 500 300"><rect x="0" y="0" width="500" height="300" fill="#091226" /> <circle cx="180" cy="150" r="90" fill="#d9a441" /><circle cx="250" cy="150" r="90" fill="#c1121f" /><rect x="100" y="100" width="180" height="80" fill="#e76f91" /><rect x="220" y="120" width="180" height="100" fill="#008080" /></svg>

  $ dune exec ../bin/main.exe -- ../examples/malformed_circle.pic malformed_circle.svg 
  Error: Invalid circle on line 2
  [1]

  $ dune exec ../bin/main.exe -- ../examples/malformed_rectangle.pic malformed_rectangle.svg
  Error: Rectangle width must be positive on line 2
  [1]

  $ dune exec ../bin/main.exe -- ../examples/malformed_line_width_nonint.pic no.svg 
  Error: Invalid line width on line 2
  [1]

  $ dune exec ../bin/main.exe -- ../examples/malformed_line_width_nonpos.pic no.svg
  Error: line width must be positive on line 2
  [1]
  $ dune exec ../bin/main.exe -- ../examples/malformed_text_size.pic no.svg
  Error: text size must be positive on line 2
  [1]

  $ dune exec ../bin/main.exe -- ../examples/malformed_text_empty.pic no.svg
  Error: Text contents cannot be empty on line 2
  [1]

  $ dune exec ../bin/main.exe -- ../examples/primitives.pic primitives.svg
  $ cat primitives.svg