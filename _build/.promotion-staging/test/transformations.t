Good translate

  $ dune exec ../bin/main.exe ../examples/transform_translate.pic transform_translate.svg
  $ cat transform_translate.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="translate(50 20)"><circle cx="100" cy="100" r="20" fill="#fff1b0" /></g></svg>

Good rotate

  $ dune exec ../bin/main.exe ../examples/transform_rotate.pic transform_rotate.svg
  $ cat transform_rotate.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="rotate(45)"><rect x="50" y="50" width="40" height="20" fill="#277da1" /></g></svg>

Good scale

  $ dune exec ../bin/main.exe ../examples/transform_scale.pic transform_scale.svg
  $ cat transform_scale.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="scale(1.5)"><circle cx="100" cy="100" r="20" fill="#2a9d8f" /></g></svg>

negative translation and rotation

  $ dune exec ../bin/main.exe ../examples/transform_negative.pic transform_negative.svg
  $ cat transform_negative.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="translate(150 100)"><g transform="rotate(-45)"><rect x="0" y="0" width="40" height="20" fill="#7b2cbf" /></g></g></svg>

sibling blocks and source order

  $ dune exec ../bin/main.exe ../examples/transform_siblings.pic transform_siblings.svg
  $ cat transform_siblings.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="translate(20 0)"><circle cx="20" cy="20" r="10" fill="#c1121f" /></g><g transform="rotate(45)"><rect x="50" y="50" width="20" height="20" fill="#277da1" /></g><line x1="10" y1="10" x2="100" y2="100" stroke="#111111" stroke-width="2" /></svg>

three levels of nesting

  $ dune exec ../bin/main.exe ../examples/transform_nested.pic transform_nested.svg
  $ cat transform_nested.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="translate(50 20)"><circle cx="10" cy="10" r="5" fill="#c1121f" /><g transform="rotate(45)"><rect x="0" y="0" width="20" height="20" fill="#277da1" /><g transform="scale(2)"><line x1="0" y1="0" x2="10" y2="10" stroke="#2a9d8f" stroke-width="2" /></g></g></g><circle cx="300" cy="100" r="10" fill="#d9a441" /></svg>

transform full end to end

  $ dune exec ../bin/main.exe ../examples/transform_full.pic transform_full.svg
  $ cat transform_full.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="400" viewBox="0 0 400 400"><rect x="0" y="0" width="400" height="400" fill="#ffffff" /> <g transform="translate(200 200)"><circle cx="0" cy="0" r="20" fill="#c1121f" /><g transform="rotate(45)"><rect x="-50" y="-50" width="40" height="40" fill="#277da1" /><g transform="scale(0.5)"><line x1="-40" y1="0" x2="40" y2="0" stroke="#111111" stroke-width="4" /></g></g></g><circle cx="350" cy="350" r="10" fill="#2a9d8f" /></svg>

maflormed header

  $ dune exec ../bin/main.exe ../examples/malformed_transform.pic malformed.svg
  Error: Invalid transform on line 2
  [1]

unexpected end

  $ dune exec ../bin/main.exe ../examples/unexpected_end.pic unexpected.svg
  Error: Invalid end on line 3
  [1]

missing end

  $ dune exec ../bin/main.exe ../examples/missing_end.pic missing.svg
  Error: Transform block on line 2 is missing end
  [1]

empty transform
  $ dune exec ../bin/main.exe -- ../examples/transform_empty.pic transform_empty.svg
  $ cat transform_empty.svg
  <svg xmlns="http://www.w3.org/2000/svg" width="400" height="200" viewBox="0 0 400 200"><rect x="0" y="0" width="400" height="200" fill="#ffffff" /> <g transform="translate(50 20)"></g><circle cx="100" cy="100" r="20" fill="#111111" /></svg>
