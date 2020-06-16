%INTEGRANTES:
%Luna González Rocío 16590485 y Martinez Garcia Isabel 16590490
% Desarrolle un predicado que permita validar un NIP de una banco
latom_lstring([],[]).
latom_lstring([F|C],R) :- latom_lstring(C,S),atom_string(F,SF), append([SF],S,R).

preparar_string(Term,LS) :-
        atom(Term),
		atom_string(Term,Str),
		preparar_string(Str,LS).
		
preparar_string(Str,LS) :-
        string(Str),
		string_chars(Str,LAC),
		latom_lstring(LAC,LS).
		
digito(D) :- D == "0"; D == "1"; D == "2"; D == "3"; D == "4"; D == "5"; D == "6"; D == "7"; D == "8"; D == "9".
digitos([P|[]]) :- digito(P).
digitos([P|C]) :- digito(P), digitos(C).

nip(S) :- string_length(S,R), R == 4, preparar_string(S,P), digitos(P).

% Desarrolle un predicado que permita validar un octeto de una ip		

r5(D) :- D == "0"; D == "1"; D == "2"; D == "3"; D == "4"; D == "5".
octeto(S) :- 
        string_length(S,R), R == 3, preparar_string(S,P), inicio(P);
		string_length(S,R), R == 2, preparar_string(S,P), octeto1(P);
		string_length(S,R), R == 1, preparar_string(S,P), octeto2(P).
		

octeto2([P|[]]) :- r5(P).
octeto2([P|C]) :- r5(P), octeto2(C).

octeto1([P|[]]) :- digito(P).
octeto1([P|C]) :- digito(P), octeto1(C).

inicio([F|C]) :- F == "2", octeto2([F|C]); F == "1", octeto1([F|C]).
		





