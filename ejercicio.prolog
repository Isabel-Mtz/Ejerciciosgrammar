%INTEGRANTES:
%Luna González Rocío 16590485 y Martinez Garcia Isabel 16590490
%Ejercicio String prolog
%Es simple realicen el analizador léxico que realice en los ultimos dos videos

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
digito(N) :- 
      N == "0"; N == "1"; N == "2"; N == "3"; N == "4";
	  N == "5"; N == "6"; N == "7"; N == "8"; N == "9".
	  
%digitos([F|[]]) :- digito(F).
%digitos([F|C]) :- digito(F),digitos(C).

digitos([F|[]])
      :- digito(F).
digitos([F|C]) 
      :- digito(F), digitos(C).
	  
%signo(R) :- R == "+".
%signo(R) :- R == "-".	
  
signo("+").
signo("-").
operador("*").
operador("/").
operador(O) :- signo(O).

%numerosigno(N) :- list(N), digitos(N).
%numerosigno([F|C]) :- signo(F), digitos(C).

%trasladar la lista para pasar a digitos
numerosigno([F|C]) :- signo(F), digitos(C).
numerosigno([F|C]) :- digitos([F|C]).

%crear una lista en L
% numerosigno(F|C) :- L = [F|C], digitos(L).

secuencianum([F|[]]) :- preparar_string(F,LS), numerosigno(LS).
secuencianum([F|C]) :- preparar_string(F,LS), numerosigno(LS), secuencianum(C).
operacion([F|C]) :- operador(F), secuencianum(C).

 
abre_parentesis(["("|_]).
cierra_parentesis([_|C]) :- append(_,[")"],C).
expre([F|C]) 
            :- 
            abre_parentesis([F|_]),
			cierra_parentesis([_|C]), 
			append(Op,[_],C), 
			operacion(Op).




 






           
