open Coq

type config = {
    max_test : int;
    max_fail : int;
    size : int -> int;
    every : Format.formatter -> int*string list -> unit;
  }

let main =
  Coq.results

