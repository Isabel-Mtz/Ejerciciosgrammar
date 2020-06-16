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
latom_lstring([], []).
latom_lstring([F|C],R) :- 
            latom_lstring(C,S), 
			atom_string(F,SF), 
			append([SF],S,R).
			
preparar_string(Term, LS) :-
		atom(Term),
		atom_string(Term,Str),
		preparar_string(Str,LS).

preparar_string(Str,LS) :-
		string(Str),
		string_chars(Str,LAC),
		latom_lstring(LAC, LS).

mascara(N) :-
		N ==  "128"; N == "192"; N == "224";
		N == "240"; N == "248"; N == "252";
		N == "254"; N == "255".

mascara1(N) :- N == "0".
digitoip(N) :-
		N == "0"; N == "1"; N == "2";
		N == "3"; N == "4"; N == "5";
		N == "6"; N == "7"; N == "8"; N == "9".

cortar_mask([F|[]]) :- mascara1(F).
cortar_mask([F|C]) :- mascara1(F), cortar_mask(C).

cortar_mask([F|[]]) :-
		mascara(F);
		 mascara1(F).
		 
cortar_mask([F|C]) :-
		 mascara(F), cortar_mask(C);
		 mascara1(F), cortar_mask(C).
		
direccioIp([B|[]]) :- digitoip(B).
direccioIp([B|C]) :- digitoip(B),direccioIp(C).

dividir_ip([F|[]]) :- preparar_string(F,LS), direccioIp(LS).

dividir_ip([F|A]) :- preparar_string(F,LS),direccioIp(LS), dividir_ip(A).

ip(IP) :- split_string(IP, ".", ".", D), dividir_ip(D).
maskR(M) :- split_string(M, ".", ",", L), cortar_mask(L).