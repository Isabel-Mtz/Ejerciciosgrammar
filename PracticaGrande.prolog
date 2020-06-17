%INTEGRANTES:
%Luna González Rocío 16590485 y Martinez Garcia Isabel 16590490
%ip("192.168.1.1").
%true.
%ip("256.168.1.1"). 
%false.
%maskR("255.255.255.0").
%true.
%maskR("255.255.255.1").
%false.
%ip("192.168.1.266").
%false.
%maskR("0.255.255.0").
%false.

latom_lstring([],[]).
latom_lstring([F|C],R) :- latom_lstring(C,S), atom_string(F,SF), append([SF],S,R).
			
preparar_string(Term, LS) :-
		atom(Term),
		atom_string(Term,Str),
		preparar_string(Str,LS).

preparar_string(Str,LS) :-
		string(Str),
		string_chars(Str,LAC),
		latom_lstring(LAC, LS).
r5(D) :- D == "0"; D == "1"; D == "2"; D == "3"; D == "4"; D == "5"; D == "8".
digitoip(N) :-
		N == "0"; N == "1"; N == "2";
		N == "3"; N == "4"; N == "5";
		N == "6"; N == "7"; N == "8"; N == "9".

ip(IP) :- split_string(IP, ".", ".", D), dividir_ip(D).

dividir_ip([F|[]]) :- validaIP(F).
dividir_ip([F|C]) :- validaIP(F), dividir_ip(C).

validaIP(D1) :- string_length(D1,3),preparar_string(D1,S), caso1(S);
                string_length(D1,2),preparar_string(D1,S), caso2(S);
                string_length(D1,1),preparar_string(D1,S), caso2(S).
				

caso2([F|[]]) :- digitoip(F).
caso2([F|C]) :- digitoip(F), caso2(C).
caso1([F|C]) :- F == "2", octeto2([F|C]); F == "1", caso2([F|C]).

octeto2([F|[]]) :- r5(F).
octeto2([F|C]) :- r5(F), octeto2(C).

				
maskR(M) :- split_string(M, ".", ",", L), cortar_mask(L).
emask([F|[]]) :- cortar_mask(F).
emask([F|C]) :- cortar_mask(F), emask(C).


cortar_mask([F|[]]) :- 
                    string_length(F,3), caso1s(F); 
					string_length(F,1),caso2s(F).
cortar_mask([F|C]) :- 
                    string_length(F,3), caso1s(F), cortar_mask(C); 
					string_length(F,1),caso2s(F), emask(C).

caso1s(N) :-
		N ==  "128"; N == "192"; N == "224";
		N == "240"; N == "248"; N == "252";
		N == "254"; N == "255".

caso2s(N) :- N == "0".