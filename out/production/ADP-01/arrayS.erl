%%%-------------------------------------------------------------------
%%% @author Marjan
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. Nov 2014 19:22
%%%-------------------------------------------------------------------
-module(arrayS).
-author("Marjan").

%% API
-export([initA/0, setA/3, getA/2, lengthA/1]).
-import(liste, [create/0, laenge/1, delete/2, insert/3, retrieve/2]).


%% initA: ∅ → array
%% Initialisiert ein Array (Erzeugung) und liefert dieses zurück
initA() ->
  create().


%% setA: array × pos × elem → array
%% Fügt dem übergebenen Array an der übergebenen Position das
%% übergebene Element hinzu und gibt das modifizierte Array zurück
setA(Array, Pos, Elem) ->
  Length = lengthA(Array),
  if
    (Length > Pos) -> insert(delete(Array, Pos+1), Pos+1, Elem);
    (Length == Pos) -> insert(Array, Pos+1, Elem);
    (Length < Pos) -> Array1 = setA(Array, Length, 0), setA(Array1, Pos, Elem);
    true -> Array
  end.


%% getA: array × pos → elem
%% Gibt das Element vom übergebenen Array an der übergebenen Position
%% zurück (falls vorhanden, sonst 0...siehe weitere Vorgaben)
getA(Array, Pos) ->
  Length = lengthA(Array),
  if
    (Length > Pos) -> retrieve(Array, Pos+1);
    true -> 0
  end.


%% lengthA: array → pos
%% Gibt die länge des übergebenen Arrays zurück
lengthA(Array) -> laenge(Array).