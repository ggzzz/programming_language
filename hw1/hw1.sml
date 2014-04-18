fun is_older(date1: int*int*int, date2: int*int*int)=
    let val y1 = #1 date1
	val m1 = #2 date1
	val d1 = #3 date1
	val y2 = #1 date2
	val m2 = #2 date2
	val d2 = #3 date2
    in
	y1 < y2 
	orelse (y1=y2 andalso m1 < m2)
	orelse (y1=y2 andalso m1=m2 andalso d1 < d2)
    end

fun number_in_month(ds:(int*int*int) list, m:int)=
    if null ds
    then 0
    else if #2 (hd ds) = m
    then 1 + number_in_month(tl ds, m)
    else number_in_month(tl ds, m)

fun number_in_months(ds:(int*int*int) list, ms:int list)=
    if null ms
    then 0
    else number_in_month(ds, hd ms) + number_in_months(ds, tl ms)

fun dates_in_month(ds:(int*int*int) list, m:int)=
    if null ds
    then []
    else if #2 (hd ds) = m
    then (hd ds) :: dates_in_month(tl ds, m)
    else dates_in_month(tl ds, m)

fun dates_in_months(ds:(int*int*int) list, ms:int list)=
    if null ms
    then []
    else dates_in_month(ds, hd ms) @ dates_in_months(ds, tl ms)

fun get_nth(ss:string list, n:int)=
    if n=1
    then hd ss
    else get_nth(tl ss, n-1)

fun date_to_string(d:int*int*int)=
    let
	val months=["January", "February", "March", "April","May", "June", "July", "August", "September", "October", "November", "December"]
	val month = get_nth(months, #2 d)
    in
	month ^ " " ^ Int.toString(#3 d) ^ ", " ^ Int.toString(#1 d)
    end

fun number_before_reaching_sum(sum:int, ns:int list)=
    if sum <= 0
    then ~1
    else 1+number_before_reaching_sum(sum-(hd ns), tl ns)

fun what_month(n:int)=
    let
	val month_day=[31,28,31,30,31,30,31,31,30,31,30,31]
    in 
	number_before_reaching_sum(n, month_day)+1
    end

fun month_range(day1:int, day2:int)=
    if day1 > day2
    then []
    else (what_month day1) :: month_range(day1+1, day2)

fun oldest(ds:(int*int*int) list)=
    if null ds
    then NONE
    else let fun oldest_nonempty(ds:(int*int*int) list)=
		 if null (tl ds)
		 then hd ds
		 else let val tl_ds = oldest_nonempty(tl ds)
		      in if is_older(hd ds, tl_ds)
			 then hd ds 
			 else tl_ds
		      end
	in SOME(oldest_nonempty ds) end

fun number_in_months_challenge(ds:(int*int*int) list, ms:int list)=
    let 
	fun is_num_in_list(n:int, ns:int list)=
	    if null ns
	    then false
	    else if n = hd ns
	    then true
	    else is_num_in_list(n, tl ns)
	fun remove_duplicates(ns:int list,new_ms:int list)=
	    if null ns
	    then new_ms
	    else if is_num_in_list(hd ns,new_ms)
	    then remove_duplicates(tl ns,new_ms)
	    else remove_duplicates(tl ns, (hd ns)::new_ms)
	val new_ms = remove_duplicates(ms,[])
    in 
	number_in_months(ds,new_ms)
    end

fun dates_in_months_challenge(ds:(int*int*int) list, ms:int list)=
    let 
	fun is_num_in_list(n:int, ns:int list)=
	    if null ns
	    then false
	    else if n = hd ns
	    then true
	    else is_num_in_list(n, tl ns)
	fun remove_duplicates(ns:int list,new_ms:int list)=
	    if null ns
	    then new_ms
	    else if is_num_in_list(hd ns,new_ms)
	    then remove_duplicates(tl ns,new_ms)
	    else remove_duplicates(tl ns, (hd ns)::new_ms)
	val new_ms = remove_duplicates(ms,[])
    in 
	dates_in_months(ds,new_ms)
    end    

fun reasonable_date(d:int*int*int)=
    let
	fun is_leap(year:int)=
	    year mod 400 = 0 orelse year mod 4 = 0 andalso year mod 100 <> 0  
	val month_day=[31,28,31,30,31,30,31,31,30,31,30,31]
	val year = #1 d
	val month = #2 d
	val day = #3 d
	fun get_day_via_month(n:int, ns:int list)=
	    if n=1
	    then hd ns
	    else get_day_via_month(n-1, tl ns)
    in
	(year > 0) andalso
	(if is_leap(year)
	 then 
	     if month=2
	     then day>=1 andalso day<=29
	     else (month>0 andalso month <=12) andalso (day>=1 andalso day<=get_day_via_month(month, month_day))
	 else
	     (month>0 andalso month<=12) andalso (day>=1 andalso day<=get_day_via_month(month, month_day)))
    end
