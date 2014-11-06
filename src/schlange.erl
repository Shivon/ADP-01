%%%-------------------------------------------------------------------
%%% @author Louisa & Marjan
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 31. Okt 2014 08:53
%%%-------------------------------------------------------------------
-module(schlange).
-author("Louisa").

%% API
-export([createQ/0, front/1, isEmptyQ/1]).



%% createQ: leere Menge -> queue
%% Initialisiert eine Queue (Erzeugung) und liefert diese zurück
createQ() ->
  {stack:createS(), stack:createS()}.


%% front: queue -> elem(Selektor)
%% Gibt das vorderste Element zu der übergebeen Queue zurück (falls vorhanden)
front({In,Out}) ->
  X = stack:isEmptyS(Out),
  if X ->                   %% wenn outstack leer ist
    restack({In, Out});     %%  dann stapel um
  true ->                   %% ist outstack voll
    stack:top(Out)          %% dann gebe das oberste Element zurück
  end.

restack({In, Out}) ->
  X = stack:isEmptyS(In),
  if X ->                   %% wenn instack leer ist
    stack:top(Out);         %%   dann gib oberstes Element vom outstack
  true ->                   %% wenn instack Elemente hat
    Top = stack:top(In),          %%  dann nehme das oberste Element
    Out1 = stack:push(Out, Top),  %%  und tu es in den outstack
    In1 = stack:pop(In),          %%  lösche das oberste Element aus dem instack
    restack({In1, Out1})          %%  gebe den modifizierten in- und outstack weiter
  end.

%% enqueue: queue × elem → queue
%% Fügt der übergebenen Queue das übergebene Element ganz hinten
%% hinzu und gibt die modifizierte Queue zurück


%% dequeue: queue → queue (Mutator)
%% Entfernt das vorderste Element der übergebenen Queue (falls
%% vorhanden) und gibt die modifizierte Queue zurück


%% isEmptyQ: queue → bool
%% Gibt true zurück, wenn die übergebene Queue leer ist, sonst false
isEmptyQ({StackIn, StackOut}) -> stack:isEmptyS(StackIn), stack:isEmptyS(StackOut).