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
-export([createQ/0, front/1, enqueue/2, dequeue/1, isEmptyQ/1]).



%% createQ: leere Menge -> queue
%% Initialisiert eine Queue (Erzeugung) und liefert diese zurück
createQ() ->
  {stack:createS(), stack:createS()}.


%% front: queue -> elem(Selektor)
%% Gibt das vorderste Element zu der übergebenen Queue zurück (falls vorhanden)
front({In,Out}) ->
  X = stack:isEmptyS(Out),
  if X ->                   %% wenn outstack leer ist
    restackTop({In, Out});  %%  dann stapel um
  true ->                   %% ist outstack voll
    stack:top(Out)          %% dann gebe das oberste Element zurück
  end.

restackTop({In, Out}) ->
  X = stack:isEmptyS(In),
  if X ->                   %% wenn instack leer ist
    stack:top(Out);         %%   dann gib oberstes Element vom outstack
  true ->                   %% wenn instack Elemente hat
    Top = stack:top(In),          %%  dann nehme das oberste Element
    Out1 = stack:push(Out, Top),  %%  und tu es in den outstack
    In1 = stack:pop(In),          %%  lösche das oberste Element aus dem instack
    restackTop({In1, Out1})          %%  gebe den modifizierten in- und outstack weiter
  end.


%% enqueue: queue × elem → queue
%% Fügt der übergebenen Queue das übergebene Element ganz hinten
%% hinzu und gibt die modifizierte Queue zurück
enqueue({StackIn, StackOut}, Elem) ->
  X = stack:isEmptyS(StackOut),
  if
    X -> StackInNew = stack:push(StackIn, Elem), {StackInNew, StackOut};
    true -> restackEnqueue({StackOut, StackIn}, Elem)
  end.

restackEnqueue({StackOut, StackIn}, Elem) ->
  X = stack:isEmptyS(StackIn),
if
    X ->
      Top = stack:top(StackOut),                    %% dann nehme das oberste Element
      StackIn1 = stack:push(StackIn, Top),          %% und tu es in den Instack
      StackOut1 = stack:pop(StackOut),              %% lösche das oberste Element aus dem Outstack
      restackEnqueue({StackOut1, StackIn1}, Elem);  %% gebe den modifizierten in- und outstack weiter
    true -> StackInNew = stack:push(StackIn, Elem), {StackInNew, StackOut}
  end.


%% dequeue: queue → queue (Mutator)
%% Entfernt das vorderste Element der übergebenen Queue (falls
%% vorhanden) und gibt die modifizierte Queue zurück
dequeue({StackIn, StackOut}) ->
  X = stack:isEmptyS(StackOut),
  if
    X -> QueueNew = restackPop({StackIn, StackOut}), QueueNew; %% wenn outstack leer ist, dann stapel um
    true -> StackOutNew2 = stack:pop(StackOut), {StackIn, StackOutNew2}           %% ist outstack voll, wird oberstes Element gelöscht
  end.

restackPop({StackIn, StackOut}) ->
  X = stack:isEmptyS(StackIn),
  if
    X -> StackOutNew = stack:pop(StackOut), {StackIn, StackOutNew};                %% wenn instack leer ist, dann lösche oberstes Element vom outstack
    true ->                                  %% wenn instack Elemente hat
      Top = stack:top(StackIn),              %% dann nehme das oberste Element
      StackOut1 = stack:push(StackOut, Top), %% und tu es in den outstack
      StackIn1 = stack:pop(StackIn),         %% lösche das oberste Element aus dem instack
      restackPop({StackIn1, StackOut1})      %% gebe den modifizierten in- und outstack weiter
  end.


%% isEmptyQ: queue → bool
%% Gibt true zurück, wenn die übergebene Queue leer ist, sonst false
isEmptyQ({StackIn, StackOut}) -> stack:isEmptyS(StackIn), stack:isEmptyS(StackOut).