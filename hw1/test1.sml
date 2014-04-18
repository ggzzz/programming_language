use "hw1.sml";
val t1_0=is_older((2000,1,1),(2001,1,1))=true
val t1_1=is_older((2000,1,1),(2000,2,1))=true
val t1_2=is_older((2000,1,1),(2000,1,2))=true
val t1_3=is_older((2000,1,1),(2000,1,1))=false


val t2_0=number_in_month([],1)=0
val t2_1=number_in_month([(2000,1,1),(2000,2,1)],1)=1
val t2_2=number_in_month([(2000,2,1),(2000,3,1)],1)=0

val t3_0=number_in_months([],[])=0
val t3_1=number_in_months([(2000,1,1)],[])=0
val t3_2=number_in_months([(2000,1,1),(2001,1,1),(2000,2,1)],[1,2,3])=3

val t4_0=dates_in_month([],1)=[]
val t4_1=dates_in_month([(2000,1,1),(2001,1,1),(2002,1,1)],1)=[(2000,1,1),(2001,1,1),(2002,1,1)]

val t5_0=dates_in_months([],[])=[]
val t5_1=dates_in_months([(2000,1,1),(2000,2,1),(2001,1,1)],[1,2,3])=[(2000,1,1),(2001,1,1),(2000,2,1)]

val t6_0=get_nth(["a","b","c"], 3)="c"

val t7_0=date_to_string((2000,1,1))="January 1, 2000"

val t8_0=number_before_reaching_sum(7,[8,6,7])=0
val t8_1=number_before_reaching_sum(7,[2,3,4])=2
val t8_2=number_before_reaching_sum(7,[2,5,2])=1

val t9_0=what_month(31)=1
val t9_1=what_month(365)=12
val t9_2=what_month(60)=3

val t10_1=month_range(28,32)=[1,1,1,1,2]
val t10_2=month_range(363,365)=[12,12,12]

val t11_0=oldest([(2000,1,1),(2001,1,1),(2002,1,1)])=SOME (2000,1,1)
val t11_1=oldest([])=NONE

val t12_0=number_in_months_challenge([],[])=0
val t12_1=number_in_months_challenge([(2000,1,1)],[])=0
val t12_2=number_in_months_challenge([(2000,1,1),(2001,1,1),(2000,2,1)],[1,2,3,3,2,2,1])=3
val t12_3=dates_in_months_challenge([],[])=[]
val t12_4=dates_in_months_challenge([(2000,1,1),(2000,2,1),(2001,1,1)],[1,2,3,1,2,3,3,1])=[(2000,2,1),(2000,1,1),(2001,1,1)]

val t13_0=reasonable_date((2011,2,29))=false
val t13_1=reasonable_date((2000,2,29))=true
val t13_2=reasonable_date((2004,2,29))=true
val t13_3=reasonable_date((2001,3,31))=true
val t13_4=reasonable_date((~100,7,7))=false


