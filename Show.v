Require Import String.
Open Scope string_scope.

(* 型クラスShowの定義 *)
Class Show (A: Set) := {
  show : A -> string
}.

(* string型をShowクラスのインスタンスとする *)
Instance ShowString : Show string := {
  show s := s
}.

(* bool型をShowクラスのインスタンスとする *)
Instance ShowBool : Show bool := {
  show b := match b with | true => "true" | false => "false" end
}.

Require Import ZArith.

Fixpoint string_of_positive p :=
    match p with
    | xI p' => "I" ++ string_of_positive p'
    | xO p' => "O" ++ string_of_positive p'
    | xH => "H"
    end.

Instance ShowPositive : Show positive := {
  show p := string_of_positive p
}.

Instance ShowZ : Show Z := {
  show n :=
    match n with
    | Z0 => "0"
    | Zpos pos => show pos
    | Zneg pos => "-" ++ show pos
    end
}.

Instance ShowNat : Show nat := {
  show n := show (Z_of_nat n) (*TODO*)
}.


(* 文字列はShowクラスのインスタンス *)
Definition foo := show "hello".

(* ブール型はShowクラスのインスタンス *)
Definition bar := show true.

(* 混ぜても使える *)
Definition hoge := show "hello" ++ show false.
