/* TEST CASE :-   table_to_sop( [ "A" ,"B" , "C"] , [[1,1,1,0],[1,1,0,0],[0,1,1,1],[1,1,1,1]], Z ).   */

table_to_sop(Variables ,L_of_L  ,Final_list):- 
					check_it_sop(L_of_L , Variables, [],Final_list),
    				rev(Final_list, Rev), print_sop( Rev , Output), 
    				write("Tree Representation:  "),print(Output).  
table_to_pos(Variables ,L_of_L  ,Final_list):- 
					check_it_pos(L_of_L , Variables, [],Final_list), 
    				rev(Final_list, Rev), print_pos( Rev , Output), 
    				write("Tree Representation:  "),print(Output).  


check_it_final(  Equal , Equal).  /* Makes Final_list = equated to Reversed list-of-list*/
							/*--> RT is list-of-list*/
check_it_sop([] , _ , RT , Final_list):-  rev(RT,Rev_RT), check_it_final(Rev_RT,Final_list).  /* RT is list-of-list ,, list-of-list is reversed*/

check_it_sop([H|T3] , Variables2 ,RT ,Final_list):-  		/* eg: list [1,1,0,1] is checked for its first element */
					[Head|Tail] = H,
					( Head = 1
					-> term3_sop(Tail,Variables2 ,[],RT1 ), append([RT1] , RT , Z)
					;Head= 0
					->append([], RT ,Z)
					; print("invalid input..please check"),false
					),
					check_it_sop(T3, Variables2, Z, Final_list). 


check_it_pos([] , _ , RT , Final_list):-  rev(RT,Rev_RT), check_it_final(Rev_RT,Final_list).  /* RT is list-of-list ,, list-of-list is reversed*/
check_it_pos([H|T3] , Variables2 ,RT ,Final_list):-  		/* eg: list [1,1,0,1] is checked for its first element */
					[Head|Tail] = H,
					( Head = 0
					-> term3_pos(Tail,Variables2 ,[],RT1 ), append([RT1] , RT , Z)
					;Head= 1
					->append([], RT ,Z)
					; print("invalid input..please check"),false
					),
					check_it_pos(T3, Variables2, Z, Final_list). 


term3_sop([],[], LOut ,RT):-rev(LOut,RT). 
term3_sop([H2|T2], [Hv|Tv] , LOut ,RT):- 
								(H2 = 1
								-> append( [Hv] , LOut , LOut2)
								; H2 = 0 
								->string_concat(! , Hv , Z), append( [Z], LOut, LOut2 )
						        ; print("invalid input...please check"), false
						         ),
								term3_sop( T2 , Tv , LOut2 ,RT).

term3_pos([],[], LOut ,RT):-rev(LOut,RT). 
term3_pos([H2|T2], [Hv|Tv] , LOut ,RT):- 
								(H2 = 0
								-> append( [Hv] , LOut , LOut2)
								; H2 = 1 
								->string_concat(! , Hv , Z), append( [Z], LOut, LOut2 )
						        ; print("invalid input...please check"), false
						         ),
								term3_pos( T2 , Tv , LOut2 ,RT).


/*	reversing the list */	
accRev([H|T] , A ,R):- accRev(T , [H|A] ,R ).
accRev( [] ,A, A).
rev(L , R):- accRev(L, [], R).

/*to print in  SOP form*/
print_sop( List , Output):- ( List = []
							->check_it_final( List , Output)
							;[_|T] = List -> ( T = []-> convert_to_AND( List , Output) ; step1_sop( List , [] , Output) )
							).

step1_sop([] , L, W):- convert_to_OR(L,W).
step1_sop([H|T] , L ,W):- convert_to_AND(H,Ele),
				append([Ele],L,Z),
				step1_sop(T, Z , W).
/*to print in POS form*/
print_pos( List , Output):- ( List = []
							->check_it_final( List , Output)
							;[_|T] = List -> ( T = []-> convert_to_OR( List , Output) ; step1_pos( List , [] , Output) )
							).

step1_pos([] , L, W):- convert_to_AND(L,W).
step1_pos([H|T] , L ,W):- convert_to_OR(H,Ele),
				append([Ele],L,Z),
				step1_pos(T, Z , W).

convert_to_AND(Z,and(Z)).
convert_to_OR(L , or(L)).












