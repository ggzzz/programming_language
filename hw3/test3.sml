use "hw3.sml";

val t1a = only_capitals ["abc", "ABC","Abc"] = ["ABC", "Abc"]
val t1b = only_capitals [] = []

val t2a = longest_string1 [] = ""
val t2b = longest_string1 ["abc","a","bcdf"] = "bcdf"
val t2c = longest_string1 ["abc","bcd","a"] = "abc"

val t3a = longest_string2 [] = ""
val t3b = longest_string2 ["abc","a","bcdf"] = "bcdf"
val t3c = longest_string2 ["abc","bcd","a"] = "bcd"

val t4a = longest_string3 [] = ""
val t4b = longest_string3 ["abc","a","bcdf"] = "bcdf"
val t4c = longest_string3 ["abc","bcd","a"] = "abc"
val t4d = longest_string4 [] = ""
val t4e = longest_string4 ["abc","a","bcdf"] = "bcdf"
val t4f = longest_string4 ["abc","bcd","a"] = "bcd"

val t5a = longest_capitalized [] = ""
val t5b = longest_capitalized ["abc","bcdf","ABC","ABCD"] = "ABCD"
val t5c = longest_capitalized ["abc","bcd"] = ""

val t6a = rev_string "" = ""
val t6b = rev_string "abc" = "cba"
val t6c = rev_string "abcdef" = "fedcba"

val t7a = (first_answer (fn x => if x > 10 then SOME x else NONE) [1,2,3,4,5] 
	  handle NoAnswer => 0) = 0
val t7b = (first_answer (fn x => if x > 10 then SOME x else NONE) [1,2,11,15] 
	  handle NoAnswer => 0) = 11

val t8a = all_answers (fn x => if x < 10 then SOME [x*10,x*100] else NONE) [1,2,3,4,5] = SOME [10,100,20,200,30,300,40,400,50,500]
val t8b = all_answers (fn x => if x < 10 then SOME [x*10,x*100] else NONE) [1,2,11,15] = NONE

val t9aa = count_wildcards (TupleP [TupleP [Wildcard]]) = 1
val t9ab = count_wildcards (TupleP []) =0
val t9ac = count_wildcards Wildcard = 1

val t9ba = count_wild_and_variable_lengths (TupleP [Wildcard, Variable "abc"]) = 4

val t9ca = count_some_var ("abc", TupleP [TupleP [Variable "abc", Wildcard], Variable "abc"]) = 2 

val t10a = check_pat Wildcard = true
val t10b = check_pat (TupleP [TupleP [Variable "abc", Wildcard], Variable "abc"]) = false
val t10c = check_pat (TupleP [TupleP [Variable "abc", Wildcard], Variable "bcd"]) = true
val t10d = check_pat (TupleP [Variable "x", ConstructorP ("x", Variable "y")]) = true

val t11a = match (Tuple [Unit, Const 12], TupleP [Variable "x", Variable "y"]) = SOME [("x", Unit), ("y", Const 12)]
val t11b = match (Tuple [Constructor ("a", Unit)], TupleP [ConstructorP ("a", Wildcard)]) = SOME [] 

val t12a = first_match (Const 77) [ConstP 77, Wildcard] = SOME []
