Require Import Gen.

Extract Constant Rand => "unit".
Extract Constant generate => "(fun (gen:'a gen) (size:nat) -> gen size ())".
