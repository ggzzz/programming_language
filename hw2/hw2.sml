(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)
fun all_except_option (str, xs)=
    case xs of
	[] =>  NONE
      | str'::xs' => if same_string(str, str')
		     then SOME xs'
		     else case all_except_option (str, xs') of
			      NONE => NONE
			   | SOME e => SOME (str'::e)

fun get_substitutions1(xss, str)=
    case xss of
	[] => []
     | xs::xss' => case all_except_option (str, xs) of
		       NONE => [] @ get_substitutions1(xss', str)
		    | SOME e => e @ get_substitutions1(xss', str) 

fun get_substitutions2(xss, str)=
    let
	fun aux (acc, xss') = 
	    case xss' of
		[] => acc
	     | xs::xss'' => case all_except_option (str, xs) of
				NONE => aux(acc@[], xss'')
			     | SOME e => aux(acc@e, xss'')
    in
	aux ([], xss)
    end

fun similar_names (xss, full_name) =
    let val {first=first, middle=middle, last=last} = full_name
	fun aux xs =
	    case xs of 
		[] => []
	     | x::xs' => {first=x, middle=middle, last=last} :: aux xs'
    in 
	case full_name of
	    {first = f, middle = _, last = _} => full_name::(aux (get_substitutions1(xss, f))) 
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove
exception MyUndesirableCondition

(* put your solutions for problem 2 here *)

fun card_color card = 
    case card of
	(Spades, _) => Black
     | (Clubs, _) => Black
     | (Diamonds, _) =>  Red
     | (hearts, _) => Red 
	
fun card_value card = 
    case card of
	(_, Jack) => 10
     | (_, Queen) => 10
     | (_, King) => 10
     | (_, Ace) => 11
     | (_, Num n) => n

fun remove_card (cs, c, e) = 
    case cs of
	[] => raise e
     | c'::cs' => if c=c'
		  then cs'
		  else c'::remove_card(cs', c, e)

fun all_same_color cs =
    case cs of
	[] => true
     | _::[] => true 
     | card1::card2::cs' => card_color card1 = card_color card2
				       andalso all_same_color cs'

fun sum_cards cs =
    let fun aux (acc, cs)=
	    case cs of
		[] => acc
	      | c::cs' => aux(card_value (c) + acc , cs')
    in 
	aux (0, cs)
    end

fun score (cs, goal) =
    let
	val sum = sum_cards cs
        val pre_score = if sum > goal then 3*(sum-goal) else goal-sum
    in
	if all_same_color cs 
	then pre_score div 2
	else pre_score
    end

fun officiate (cs, ms, goal) = 
    let fun aux (hcs, cs, ms) = 
	    case ms of
		[] => hcs
	      | (Discard c)::ms' => aux(remove_card(hcs, c,IllegalMove), cs, ms')
	      | Draw::ms' => case cs of 
				 [] => hcs
			      |  c::cs' => let val s = (card_value c) + sum_cards hcs 
					       val ms'' = if s>goal then [] else ms'
					   in 
					       aux (c::hcs, cs', ms'')
					   end
    in
	score (aux ([], cs, ms), goal)
    end

fun score_challenge (cs, goal) =
    let 
	val sum = sum_cards cs
	val score = score (cs, goal)
	fun aux (new_sum, score, cs) = 
	    case cs of 
		[] => score
	        | (_, Ace)::cs' => let val sum' = new_sum-10
				       val pre_score = if sum'>goal then 3*(sum'-goal) else goal-sum'
				       val score' = if all_same_color cs
						    then pre_score div 2
						    else pre_score
				   in 
				       if score' < score
				       then aux (sum', score', cs')
				       else aux (sum', score, cs')
				   end
	        | _::cs' => aux(new_sum, score, cs')   
    in
	aux (sum, score, cs)
    end

fun officiate_challenge (cs, ms, goal) = 
    let fun aux (hcs, cs, ms) = 
	    case ms of
		[] => hcs
	      | (Discard c)::ms' => aux(remove_card(hcs, c,IllegalMove), cs, ms')
	      | Draw::ms' => case cs of 
				 [] => hcs
			      |  c::cs' => let val s = (card_value c) + sum_cards hcs 
					       val ms'' = if s>goal then [] else ms'
					   in 
					       aux (c::hcs, cs', ms'')
					   end
    in
	score_challenge (aux ([], cs, ms), goal)
    end

fun careful_player (cs, goal) =
    let fun discard (cs_d, hcs, ms) =
	    case cs_d of
		[] => []
		| c::cs' => if officiate(cs, ms@[Discard c]@[Draw], goal) = 0
			    then [c]
			    else discard (cs', hcs, ms)
	fun aux (ms, cs_a, hcs) =
	    let
		val discard_card = discard (cs_a, hcs, ms)
		val hand_value = sum_cards hcs
	    in
		case cs_a of
		    [] => ms
		  | c::cs' => 
		    if officiate(cs, ms, goal) = 0
		    then ms
		    else if goal > hand_value + 10
		    then aux (ms@[Draw], cs', c::hcs)
		    else if discard_card <> []
		    then ms@[Discard (case discard_card of c::[] => c)]@[Draw]
		    else if hand_value > goal-10 andalso hand_value < goal andalso hand_value+(card_value c) < goal
		         then aux (ms@[Draw], cs', c::hcs)
		         else case hcs of
				  [] => ms
				| c::hcs' => aux (ms@[Discard c], cs, hcs')
	    end	           
    in
	aux ([], cs, [])
    end
	
