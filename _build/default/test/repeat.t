Repeat zero copies
  $ dune exec ../bin/main.exe -- ../examples/repeat_zero.pic repeat_zero.svg
  $ cat repeat_zero.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="900" height="700" viewBox="0 0 900 700"><rect x="0" y="0" width="900" height="700" fill="#ffffff" /> </svg>

Repeat one copy
  $ dune exec ../bin/main.exe -- ../examples/repeat_one.pic repeat_one.svg
  $ cat repeat_one.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400"><rect x="0" y="0" width="400" height="400" fill="#ffffff" /> <g transform="translate(0 0)"><circle cx="100" cy="100" r="10" fill="#c1121f" /></g></svg>

Repeat several copies
  $ dune exec ../bin/main.exe -- ../examples/repeat_several.pic repeat_several.svg
  $ cat repeat_several.svg 
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400"><rect x="0" y="0" width="400" height="400" fill="#ffffff" /> <g transform="translate(-0 -0)"><circle cx="100" cy="100" r="10" fill="#c1121f" /></g><g transform="translate(-50 -25)"><circle cx="100" cy="100" r="10" fill="#c1121f" /></g><g transform="translate(-100 -50)"><circle cx="100" cy="100" r="10" fill="#c1121f" /></g></svg>

Repeat nested copies
  $ dune exec ../bin/main.exe -- ../examples/repeat_nested.pic repeat_nested.svg
  $ cat repeat_nested.svg 
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400"><rect x="0" y="0" width="400" height="400" fill="#ffffff" /> <g transform="translate(0 0)"><g transform="translate(0 0)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g><g transform="translate(0 50)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g><g transform="translate(0 100)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g></g><g transform="translate(100 0)"><g transform="translate(0 0)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g><g transform="translate(0 50)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g><g transform="translate(0 100)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g></g></svg>

Repeat translated grid
  $ dune exec ../bin/main.exe -- ../examples/repeat_grid.pic repeat_grid.svg
  $ cat repeat_grid.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="500" height="500" viewBox="0 0 500 500"><rect x="0" y="0" width="500" height="500" fill="#ffffff" /> <g transform="translate(0 0)"><g transform="translate(0 0)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 80)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 160)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 240)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 320)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 400)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g></g><g transform="translate(80 0)"><g transform="translate(0 0)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 80)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 160)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 240)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 320)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 400)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g></g><g transform="translate(160 0)"><g transform="translate(0 0)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 80)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 160)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 240)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 320)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 400)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g></g><g transform="translate(240 0)"><g transform="translate(0 0)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 80)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 160)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 240)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 320)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 400)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g></g><g transform="translate(320 0)"><g transform="translate(0 0)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 80)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 160)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 240)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 320)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g><g transform="translate(0 400)"><circle cx="40" cy="40" r="15" fill="#2a9d8f" /></g></g></svg>

Repeat radial rotation
  $ dune exec ../bin/main.exe -- ../examples/repeat_radial.pic repeat_radial.svg
  $ cat repeat_radial.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="500" height="500" viewBox="0 0 500 500"><rect x="0" y="0" width="500" height="500" fill="#ffffff" /> <g transform="translate(250 250)"><g transform="rotate(0)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(30)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(60)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(90)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(120)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(150)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(180)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(210)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(240)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(270)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(300)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g><g transform="rotate(330)"><circle cx="150" cy="0" r="15" fill="#c1121f" /></g></g></svg>

Repeat rotation
  $ dune exec ../bin/main.exe -- ../examples/repeat_rotation.pic repeat_rotation.svg
  $ cat repeat_rotation.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400"><rect x="0" y="0" width="400" height="400" fill="#ffffff" /> <g transform="translate(200 200)"><g transform="rotate(0)"><rect x="-25" y="-112.5" width="50" height="25" fill="#277da1" /></g><g transform="rotate(45)"><rect x="-25" y="-112.5" width="50" height="25" fill="#277da1" /></g><g transform="rotate(90)"><rect x="-25" y="-112.5" width="50" height="25" fill="#277da1" /></g></g></svg>

Bad repeat count
  $ dune exec ../bin/main.exe -- ../examples/repeat_malformed_count.pic no.svg
  Error: Invalid repeat count on line 2
  [1]

Bad negative repeat count
  $ dune exec ../bin/main.exe -- ../examples/repeat_negative_count.pic no.svg
  Error: Repeat count cannot be negative on line 2
  [1]
