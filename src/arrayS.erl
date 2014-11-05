%%%-------------------------------------------------------------------
%%% @author KamikazeOnRoad
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. Nov 2014 19:22
%%%-------------------------------------------------------------------
-module(arrayS).
-author("KamikazeOnRoad").

%% API
-export([initA/0]).


%% initA: ∅ → array
%% Initialisiert ein Array (Erzeugung) und liefert dieses zurück
initA() ->
  {liste:create()}.

%% setA: array × pos × elem → array
%% Fügt dem übergebenen Array an der übergebenen Position das
%% übergebene Element hinzu und gibt das modifizierte Array zurück


%% getA: array × pos → elem
%% Gibt das Element vom übergebenen Array an der übergebenen Position
%% zurück (falls vorhanden, sonst 0...siehe weitere Vorgaben)


%% lengthA: array → pos
%% Gibt die länge des übergebenen
