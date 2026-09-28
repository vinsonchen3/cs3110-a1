Generate a canvas.

  $ dune exec ../bin/main.exe ../examples/canvas.pic canvas.svg
  $ cat canvas.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="white" /></svg>

  $ dune exec ../bin/main.exe ../examples/canvas_none.pic canvas_none.svg
  $ cat canvas_none.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="700" viewBox="0 0 900 700"></svg>

  $ dune exec ../bin/main.exe ../examples/canvas_malformed.pic canvas_malformed.svg
  Error: ../examples/malformed.pic: No such file or directory
  [1]
