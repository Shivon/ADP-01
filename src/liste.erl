%%%-------------------------------------------------------------------
%%% @author Louisa & Marjan
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 27. Okt 2014 21:22
%%%-------------------------------------------------------------------
-module(liste).
-author("Louisa").

%% API
-export([create/0, isEmpty/1, laenge/1, insert/3, reverse/1, delete/2, find/2, retrieve/2, concat/2]).


%% create: leere Menge -> list
%% Initialisiert eine Liste (Erzeugung) und liefert diese zurück
create() ->
  {}.



%% isEmpty: list -> bool
%% Prüft, ob die Liste leer ist
isEmpty(List) ->
  Laenge = laenge(List),
  if (Laenge == 0) -> true;
     true -> false
  end.



%% laenge: list -> int
%% Gibt die Länge der übergebene Liste zurück
laenge(List) ->
  laenge_(List,0).

laenge_({},Accu)  ->             %% Abbruchbedingung, wenn die Liste leer ist wir Accumulator zurückgegeben
  Accu;
laenge_({_First,Rest}, Accu) ->  %% Rekusiv duch List gehen und dabei Accumulator immer um eins erhöhen
  laenge_(Rest, Accu +1 ).



%% insert: list x pos x elem -> list
%% Fügt der übergebenen Lise an der übergebenen Position das
%%   übergebene Element hinzu und gibt die modifizierte Liste zurück
insert(List, Pos, Elem) ->
   insert_(List, Pos, Elem, {}).


insert_(List, 1, Elem, NewList) ->               %%
  NewList1 = {Elem, NewList},
  insert_(List, 0, Elem, NewList1);

insert_({}, _Pos, _Elem, NewList) ->             %%
  reverse(NewList);

insert_({First, Rest}, Pos, Elem, NewList) ->    %% Die Pos ist noch nicht erreicht
    NewList1 = {First, NewList},                 %% in die Neue Liste wird das Erste Element hinzugefügt
    insert_( Rest, Pos-1, Elem, NewList1).       %% Die Funktion wird rekursiv mit dem Rest aufgerufen und
                                                 %%    die Position um eins verringert

reverse(List) ->
  reverse_(List, {}).
reverse_({}, NewList) ->
  NewList;
reverse_({First, Rest}, NewList) ->
  NewList1 = {First,NewList},
  reverse_(Rest, NewList1).



%% delete: list x pos -> list
%% Entfernt das übergebene Element an der übergebene Position (falls vorhanden)
%%   in der übergebenen Liste und gibt die modifizierte Liste zurück
delete(List, Pos) ->
  delete_(List, Pos, {}).

delete_({_First,Rest}, 1, NewList) ->
  delete_(Rest, 0,  NewList);

delete_({}, _Pos,  NewList) ->             %%
  reverse(NewList);

delete_({First,Rest}, Pos, NewList) ->
  NewList1 = {First, NewList},                 %% in die Neue Liste wird das Erste Element hinzugefügt
  delete_( Rest, Pos-1, NewList1).



%% find: list x elem -> pos
%% Sucht nach einem übergebenen Element in der übergebene Liste
%%     und gibt die Position dessen zurück (falls gefunden)
find(List, Elem) ->
  find_(List, Elem, 1).

find_({First, _Rest}, Elem, Pos) when First == Elem ->
  Pos;

find_({First, Rest}, Elem, Pos)  when First /= Elem ->
  find_(Rest, Elem, Pos+1);

find_({}, _Elem, _Pos) ->  %% gesuchtes Element existiert nicht -> nil (not in list) wird zurückgegeben.
  nil.



%% retrieve: list x pos -> elem
%% Gibt das Element an der übergebenen Position in der übergebenen Liste zurück (falls vorhanden)
retrieve({First, _Rest}, 1) ->       %% Position erreicht, liefere Element an der Stelle
  First;
retrieve({_First, Rest}, Pos) ->     %% Richtige Position noch nicht erreicht, dann suche weiter
  retrieve(Rest, Pos-1);
retrieve({}, _Pos) ->                %% Position existiert nicht, liefer leere Liste zurück
  {}.



%% concat: list x list -> list
%% Konkatiniert die übergebenen Liten und gibt das Ergebnis zurück
concat(List1, List2) ->
  concat_(List1, List2, {}).

concat_({}, {}, NewList) ->                   %% sind beide leer, wird die neu erstellte Liste zurückgegeben.
  reverse(NewList);

concat_({}, {First, Rest}, NewList) ->        %% erste Liste ist leer (entweder von Anfang an, oder alle Elemente sind schon
  NewList1 = {First,NewList},                 %%    komplett in die neue Liste hinzugefügt worden), dann werden die
  concat_({}, Rest, NewList1);                %%    Elemente der zweite Liste in die neue Liste hinzugefügt.

concat_({First, Rest}, List2, NewList) ->     %% von der ersten Liste werden die Elemente in die neue Liste hinzugefügt.
  NewList1 = {First,NewList},
  concat_(Rest, List2, NewList1).