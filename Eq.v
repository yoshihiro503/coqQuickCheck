Class Eq (A : Type) := {
  eq_dec : forall (x y : A), {x = y}+{x <> y}
}.

Infix "=?" := eq_dec (at level 60).

Require Import Arith.
Instance EqNat : Eq nat := {
  eq_dec := eq_nat_dec
}.