Require Import Syntax Eq Gen QuickCheck.

Definition prop_foo :=
  forAll gen_nat (fun n => true).

Definition bool_of_sumbool {A B:Prop} (sb: {A}+{B}) :=
  if sb then true else false.

Definition prop_natLeftUnit :=
  forAll gen_nat (fun n => bool_of_sumbool (n+0 =? n)).

Definition prop_hoge :=
  forAll gen_nat (fun n => bool_of_sumbool (n+0 =? 0)).

Definition test :=
  check prop_hoge.

Require Import List Streams.
Fixpoint take {A:Type} n (xs : Stream A) :=
  match n with
  | O => nil
  | S p =>
    match xs with
    | Cons x xs' => x :: take p xs'
    end
  end.

Definition test10 :=
  take 10 test.

Definition results :=
  List.map check [prop_foo;
    prop_natLeftUnit;
    prop_hoge
  ].