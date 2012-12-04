Require Import Show Eq Functor Monad.

Variable Rand : Set.
Definition Gen (A:Type) := nat -> Rand -> A.

(*Variable elements : forall {A : Set}, list A -> Gen A.*)

Instance GenMonad : Monad Gen := {
  return_ A x := (fun _ _ => x)
  ; bind A m B f := (fun size rand =>
      f (m size rand) size rand)
}.
Proof.
 reflexivity.

 reflexivity.

 reflexivity.
Defined.

Instance GenFunctor : Functor Gen := {
  fmap A B f m := bind m (fun x => return_ (f x))
}.
Proof.
 reflexivity.
Defined.

Definition gen_nat : Gen nat :=
  fun size rand => size. (*TODO*)

Variable generate : forall {A : Set}, Gen A -> nat -> A.


