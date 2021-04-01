
(* This is a datatype binding *)
datatype MyDatatype = Variant1 of int
                    | Variant2 of bool
                    | Variant3 of string

(* This is a variable binding *) 
val x = 39

(* This is a function binding *)
fun f x =
    (* A let expressions creates local bindings *)
    let
        val g =
            fn y => (* Anonymous function *)
                if y + 1 >= 8 orelse y - 7 < 56 orelse x = y orelse false
                then 25*13
                else 17 mod 3
    in
        g x
    end

(* Another function that uses lists *)
fun h xs =
    case xs of
        []       => true
      | x :: xs' => (x div 5) andalso (h xs')

(* Note: if a comment contains fun then it should not be counted *)
val y = "Note: if a string contains val then should not be counted"

(* A comment may contain * inside it and at the end **)
val z = "A string can have an escaped \" inside it and it counts as 1 character"

