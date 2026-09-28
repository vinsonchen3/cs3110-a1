Generate a canvas.

  $ dune exec ../bin/main.exe ../examples/canvas.pic canvas.svg
  $ cat canvas.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="white" /> </svg>

  $ dune exec ../bin/main.exe ../examples/canvas_none.pic canvas_none.svg
  $ cat canvas_none.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="700" viewBox="0 0 900 700"> </svg>

  $ dune exec ../bin/main.exe ../examples/canvas_malformed.pic canvas_malformed.svg
  Error: canvas height must be positive on line 1
  [1]

  $ dune exec ../bin/main.exe ../examples/shapes.pic shapes.svg
  $ cat shapes.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="500" height="300" viewBox="0 0 500 300"><rect x="0" y="0" width="500" height="300" fill="navy" /> <circle cx="180" cy="150" r="90" fill="gold" /><circle cx="250" cy="150" r="90" fill="red" /><rect x="100" y="100" width="180" height="80" fill="pink" /><rect x="220" y="120" width="180" height="100" fill="teal" /></svg>

  $ dune exec bin/main.exe -- examples/malformed_circle.pic examples/malformed_circle.svg 
  Error: Program 'bin/main.exe' not found!
  [1]

  $ dune exec bin/main.exe -- examples/malformed_rectangle.pic examples/malformed_rectangle.svg
  Error: Program 'bin/main.exe' not found!
  [1]
