(* Dan Grossman, Coursera PL, HW2 Provided Tests *)

(* These are just two tests for problem 2; you will want more.

   Naturally these tests and your tests will use bindings defined 
   in your solution, in particular the officiate function, 
   so they will not type-check if officiate is not defined.
 *)
use "hw2.sml";

val test1a1 = all_except_option ("abc", ["efo","wsjefo","abc","wjefoi","wjeofi"]) = SOME ["efo","wsjefo","wjefoi","wjeofi"]
val test1a2 = all_except_option ("abc", ["wjeo","fjwoe","wjeoi","wjeoj"]) = NONE 

val test1b1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")=["Fredrick","Freddie","F"]
val test1b2 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")=["Jeffrey","Geoff","Jeffrey"]

val test1c1 = get_substitutions2([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")=["Fredrick","Freddie","F"]
val test1c2 =get_substitutions2([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")=["Jeffrey","Geoff","Jeffrey"]

val test1d1 = similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],
{first="Fred", middle="W", last="Smith"}) = [{first="Fred", last="Smith", middle="W"},
{first="Fredrick", last="Smith", middle="W"},
{first="Freddie", last="Smith", middle="W"},
{first="F", last="Smith", middle="W"}]
val test1d2 = similar_names([], {first="Fred", middle="W", last="Smith"}) = [{first="Fred", middle="W", last="Smith"}]

val test2a1 = card_color (Clubs, Jack) = Black
val test2a2 = card_color (Hearts, Ace) = Red 

val test2b1 = card_value (Clubs, Jack) = 10
val test2b2 = card_value (Clubs, Ace) = 11
val test2b3 = card_value (Hearts, Num 5) = 5

val test2c1 = (remove_card([(Spades, Jack),(Hearts, King), (Clubs,Num 5)],(Clubs,Num 5), MyUndesirableCondition)
	       handle MyUndesirableCondition => [(Clubs, Jack)])
            = [(Spades, Jack),(Hearts, King)]
val test2c2 = (remove_card([(Spades, Jack),(Hearts, King), (Clubs,Num 5)], (Spades,Ace),MyUndesirableCondition)
	       handle MyUndesirableCondition => [(Clubs, Jack)]) 
	    = [(Clubs, Jack)]
val test2c3 = (remove_card([(Clubs,Num 5),(Spades, Jack),(Hearts, King), (Clubs,Num 5)],(Clubs,Num 5), MyUndesirableCondition)
	       handle MyUndesirableCondition => [(Clubs, Jack)])
            = [(Spades, Jack),(Hearts, King),(Clubs, Num 5)]

val test2d1 = all_same_color [(Clubs, Jack)] = true
val test2d2 = all_same_color [(Clubs, Jack), (Spades, Num 5), (Clubs, Ace)] = true
val test2d3 = all_same_color [(Clubs, Jack), (Hearts, King)] = false

val test2e1 = sum_cards [(Clubs, Jack), (Hearts, King), (Hearts, Num 5)] = 25

val test2f1 = score ([(Clubs, Jack), (Spades, King), (Hearts, Num 5)], 26) = 0 

fun provided_test1 () = (* correct behavior: raise IllegalMove *)
    let val cards = [(Clubs,Jack),(Spades,Num(8))]
	val moves = [Draw,Discard(Hearts,Jack)]
    in
	officiate(cards,moves,42)
    end

fun provided_test2 () = (* correct behavior: return 3 *)
    let val cards = [(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)]
	val moves = [Draw,Draw,Draw,Draw,Draw]
    in
 	officiate(cards,moves,42)
    end

val test2g1 = (provided_test1() handle IllegalMove => ~1) = ~1
val test2g2 = (provided_test2() handle IllegalMove => ~1) = 3

val test3a1 = score_challenge([(Spades, King), (Spades, Ace), (Hearts, Ace)], 42) = 5
val test3a2 = score_challenge([(Spades, King), (Spades, Ace), (Hearts, Ace)], 32) = 0
