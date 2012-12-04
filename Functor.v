Require Import Basics.

Class Functor (F : Type -> Type) : Type := {
  fmap : forall {A B}, (A -> B) -> (F A -> F B)
  ; law : forall (A B C:Type) (f:A->B) (g:B->C) x, fmap (compose g f) x = compose (fmap g) (fmap f) x
}.