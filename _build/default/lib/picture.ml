(** Typed representation of Picture This pictures. *)

type color =
  | Black
  | White
  | Gray
  | Red
  | Orange
  | Yellow
  | Green
  | Blue
  | Purple
  | Pink
  | Brown
  | Navy
  | Teal
  | Gold
  | Cream

type circle = {
  c_x : float;
  c_y : float;
  radius : float;
  fill : color;
}

type rectangle = {
  x : float;
  y : float;
  width : float;
  height : float;
  fill : color;
}

type line = {
  x1 : float;
  y1 : float;
  x2 : float;
  y2 : float;
  stroke : color;
  width : float;
}

type text = {
  x : float;
  y : float;
  size : float;
  fill : color;
  contents : string;
}

type element =
  | Circle of circle
  | Rectangle of rectangle
  | Line of line
  | Text of text

type picture = {
  width : float;
  height : float;
  background : color option;
  elements : element list;
}
