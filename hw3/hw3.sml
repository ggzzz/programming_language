(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

val only_capitals = List.filter (fn x => Char.isUpper(String.sub (x, 0)))

val longest_string1 = foldl (fn (x, init) => if String.size(x)>String.size(init) then x else init) "" 

val longest_string2 = foldl (fn (x, init) => if String.size(x)>=String.size(init) then x else init) ""

fun longest_string_helper f xs = foldl (fn (x, init) => if f (String.size(x),String.size(init)) then x else init) "" xs
val longest_string3 = longest_string_helper (fn (x,y) => x > y)
val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

val longest_capitalized = longest_string1 o only_capitals

val rev_string = String.implode o rev o String.explode

fun first_answer f xs = case xs of 
			    [] => raise NoAnswer
			  | x::xs' => case f x of
					  NONE => first_answer f xs'
					| SOME e => e 

fun all_answers f xs = let fun aux x xs = case xs of 
					      NONE => NONE
					    | SOME e => SOME (x @ e)
		       in case xs of
			      [] => SOME [] 
			    | x::xs' => case f x of
					    NONE => NONE
					  | SOME e => aux e (all_answers f xs')
		       end 

val count_wildcards = g (fn () => 1) (fn x => 0)
val count_wild_and_variable_lengths = g (fn () => 1) String.size					    
fun count_some_var (s, p) = g (fn () => 0) (fn x => if x = s then 1 else 0) p

fun check_pat p = let fun to_list p = 
			  case p of
			      Variable x => [x]
			    | TupleP ps => foldl (fn (x, init) => init @ (to_list x)) [] ps
			    | _ => []
		      fun is_repeated ss =
			  case ss of
			      [] => false
			    | s::ss' => List.exists (fn x => x = s) ss' orelse is_repeated ss'
		  in not (is_repeated (to_list p)) end

fun match (v, p) = case p of
		       Wildcard => SOME []
		     | Variable s => SOME [(s, v)]
		     | UnitP => (case v of
				     Unit => SOME []
				   | _ => NONE) 
		     | ConstP int => (case v of 
					  Const i => if i = int then SOME [] else NONE
					| _ => NONE)
		     | TupleP ps => (case v of
					 Tuple vs => if List.length(vs) = List.length(ps)
						     then all_answers (fn x => x) (List.map match (ListPair.zip (vs, ps)))
						     else NONE
				       | _ => NONE) 
		     | ConstructorP(s1, p') => (case v of 
						    Constructor(s2, v') => if s1=s2 
									   then match (v', p')
									   else NONE
						  | _ => NONE) 

fun first_match v ps = SOME (first_answer (fn p => match (v, p)) ps)
			  handle NoAnswer => NONE		    
(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)
