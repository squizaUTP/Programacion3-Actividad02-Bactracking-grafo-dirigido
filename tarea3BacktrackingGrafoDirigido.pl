% ===============================================
% Ejercicio 1: Puentes de Königsberg
% ===============================================

% --- HECHOS ---
puente(1, a, c).
puente(2, a, c).
puente(3, b, c).
puente(4, b, c).
puente(5, a, d).
puente(6, b, d).
puente(7, c, d).


conecta(IdPuente, ZonaA, ZonaB) :- puente(IdPuente, ZonaA, ZonaB).
conecta(IdPuente, ZonaA, ZonaB) :- puente(IdPuente, ZonaB, ZonaA).

% --- REGLA PRINCIPAL ---
paseo(Inicio) :-
    recorrer(Inicio, Inicio, [], Camino),
    writeln('Camino encontrado:'),
    writeln(Camino).

recorrer(Inicio, Inicio, PuentesUsados, PuentesUsados) :-
    length(PuentesUsados, 7).


recorrer(Actual, Inicio, PuentesUsados, CaminoFinal) :-
    conecta(IdPuente, Actual, Siguiente),
    \+ member(IdPuente, PuentesUsados), % Verifica que el puente no se haya usado previamente
    recorrer(Siguiente, Inicio, [IdPuente|PuentesUsados], CaminoFinal).


%Prueba
%?- paseo(a).

%-----------------------------------------------------------------------------


% ===============================================
% Ejercicio 2: Grafo dirigido de canadá
% ===============================================

% --- HECHOS ---
ruta(vancouver,edmonton,16).
ruta(vancouver,calgary,13).
ruta(edmonton,saskatoon,12).
ruta(calgary,regina,14).
ruta(calgary,edmonton,4).
ruta(saskatoon,calgary,9).
ruta(saskatoon,winnipeg,20).
ruta(regina,saskatoon,7).
ruta(regina,winnipeg,4).

% ---- Preguntas------

% 1 - Existe una conexión entre Saskatoon y Vancouver?
%?- ruta(saskatoon,vancouver,_).

%2 - Con qué nodos está conectado Regina y cual es el costo de cada conexión?
%?- ruta(regina, Destino, Costo).





% ------ Reglas --------
% Construir una regla para determinar si un nodo tiene aristas
tiene_aristas(Nodo) :- ruta(Nodo,_,_), !.
tiene_aristas(Nodo) :- ruta(_,Nodo,_), !.

%Prueba
%?- tiene_aristas(vancouver).

%Construir una regla para determinar cuál es el costo para ir de un nodo X a un Z pasando por Y

costo_pasando_por(X,Y,Z,CostoTotal):-
    ruta(X,Y,C1),
    ruta(Y,Z,C2),
    CostoTotal is C1 + C2.

%Prueba
%?- costo_pasando_por(vancouver,edmonton,saskatoon, Costo). 



%------ Pregunta mas interesante ---------
%Es posible viajar desde Edmonton a Calgary?

% Caso Base:conexión directa entre X e Y
camino(X, Y, [X, Y], Costo) :-
    ruta(X, Y, Costo).

% Caso Recursivo: No conexión directa, busca un nodo intermedio Z
camino(X, Y, [X|Resto], CostoTotal) :-
    ruta(X, Z, C1),
    camino(Z, Y, Resto, C2),
    CostoTotal is C1 + C2.

%Prueba
%?- camino(edmonton, calgary, Ruta, Costo).




%-----------------------------------------------------------------------------


% ===============================================
% Ejercicio 3: Rutas España
% ===============================================

%Hechos

carretera(coruna, vigo, 171).
carretera(coruna, valladolid, 455).
carretera(oviedo, bilbao, 304).
carretera(bilbao, valladolid, 280).
carretera(bilbao, madrid, 395).
carretera(bilbao, zaragoza, 324).
carretera(madrid, valladolid, 193).
carretera(madrid, zaragoza, 325).
carretera(madrid, badajoz, 403).
carretera(madrid, jaen, 335).
carretera(madrid, albacete, 251).
carretera(zaragoza, barcelona, 296).
carretera(barcelona, gerona, 100).
carretera(barcelona, valencia, 349).
carretera(albacete, valencia, 191).
carretera(albacete, murcia, 150).
carretera(valencia, murcia, 241).
carretera(jaen, sevilla, 242).
carretera(jaen, granada, 99).
carretera(sevilla, cadiz, 125).
carretera(sevilla, granada, 256).
carretera(granada, murcia, 278).
carretera(vigo, valladolid, 356).


% Permite viajar de X a Y, o de Y a X
conexion(X, Y, D) :- carretera(X, Y, D).
conexion(X, Y, D) :- carretera(Y, X, D).


% CASO BASE: Conexión directa con la ciudad destino Y
camino(X, Y, Visitados, [X, Y], Distancia) :-
    conexion(X, Y, Distancia),
    \+ member(Y, Visitados).

% CASO RECURSIVO: Avanza a una ciudad Z intermedia no visitada
camino(X, Y, Visitados, [X|Resto], DistanciaTotal) :-
    conexion(X, Z, D1),
    Z \= Y,
    \+ member(Z, Visitados),
    camino(Z, Y, [Z|Visitados], Resto, D2),
    DistanciaTotal is D1 + D2.


%Prueba
%?- camino(sevilla, barcelona, [sevilla], Ruta, Distancia).




    