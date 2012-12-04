(* see http://www.eecs.northwestern.edu/~robby/courses/395-495-2009-fall/quick.pdf *)
Require Import Arith String Syntax.
Require Import Show Eq Functor Monad Gen.

(* Gen *)

(* -- Arbitrary ; Coarbitrary *)
Class Arbitrary (A : Set) := {
  arbitrary : Gen A
}.
(*
Instance ArbitraryBool : Arbitrary bool := {
  arbitrary := elements [true; false]
}.*)

(* -- Property *)
Record Result := {
  ok : option bool
  ; stamp : list string
  ; arguments : list string
}.

Definition set_ok x (r: Result) := {|
  ok := x
  ; stamp := stamp r
  ; arguments := arguments r
|}.
Definition add_stamp s r := {|
  ok := ok r
  ; stamp := s :: stamp r
  ; arguments := arguments r
|}.
Definition add_args s r := {|
  ok := ok r
  ; stamp := stamp r
  ; arguments := s :: arguments r
|}.

Definition Property := Gen Result.

Definition nothing : Result := {|
  ok := None
  ; stamp := []
  ; arguments := []
|}.

Definition result (res : Result) := return_ res.

Class Testable (A : Type) := {
  property : A -> Property
}.


Instance TestableBool : Testable bool := {
  property b := result (set_ok (Some b) nothing)
}.

Instance TestableProperty : Testable Property := {
  property prop := prop
}.
(*
Instance TestableSumbool {A B:Prop} : Testable ({A}+{B}) := {
  property b :=
    if b then result (set_ok (Some true) nothing)
    else result (set_ok (Some false) nothing)
}.*)



Definition evaluate {A : Type} {t : Testable A} (a : A) :=
  property a.

(*Definition forAll {A : Set} {B:A -> Set} {s : Show A} {t : forall x, Testable (B x)} (gen : Gen A) (body : forall (x:A), B x) :=
  let arg a res := {|
    ok := ok res
    ; stamp := stamp res
    ; arguments := show a :: arguments res
    |}
  in
  gen >>= fun a =>
  evaluate (body a) >>= fun res =>
  return_ (arg a res).*)
Definition forAll {A B: Set} {s : Show A} {t : Testable B} (gen : Gen A) (body : A -> B) :=
  let arg a res := {|
    ok := ok res
    ; stamp := stamp res
    ; arguments := show a :: arguments res
    |}
  in
  gen >>= fun a =>
  evaluate (body a) >>= fun res =>
  return_ (arg a res).

Definition impl {A : Set} {t : Testable A} (cond:bool) a :=
  if cond then property a
  else result nothing.

Infix "==>" := impl (at level 50).

Definition label {A : Set} {t : Testable A} s a :=
  fmap (add_stamp s) (evaluate a).

Definition classify {A : Set} {t : Testable A} (cond : bool) name :=
  if cond then label name
  else property.

Definition collect {A B: Set} {s : Show A} {t : Testable B} v :=
  label (show v).


(*Record config := {
  max_test : nat
  ; max_fail : nat
  ; size : nat -> nat
}.

Definition quick := {|
  max_test := 100
  ; max_fail := 1000
  ; size n := 3 + Div2.div2 n
|}.*)

Require Import Streams.

CoFixpoint from n := Cons n (from (S n)).

Definition tests (gen : Gen Result) :=
  Streams.map (generate gen) (from 0).


Definition check {A:Type} {t: Testable A} (a : A) :=
  tests (evaluate a).

