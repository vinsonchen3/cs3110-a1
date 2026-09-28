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

type element =
  | Circle of circle
  | Rectangle of rectangle

type picture = {
  width : float;
  height : float;
  background : color option;
}
