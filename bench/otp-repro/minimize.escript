#!/usr/bin/env escript
%% Shrinks a module's abstract forms while compile:forms/2 keeps crashing in
%% beam_types:norm_number/1. Usage: minimize.escript FORMS_FILE OUT_ERL
main([In, Out]) ->
    {ok, Bin} = file:read_file(In),
    Forms0 = binary_to_term(Bin),
    true = crashes(Forms0),
    Forms = shrink(Forms0),
    io:format("~p functions left~n", [length([F || {function, _, _, _, _} = F <- Forms])]),
    ok = file:write_file(Out, [erl_pp:form(F, [{encoding, utf8}]) || F <- Forms]).

crashes(Forms) ->
    try compile:forms(Forms, [return, binary]) of
        {error, Errors, _} -> lists:any(fun norm_number_crash/1, Errors);
        _ -> false
    catch _:_ -> false
    end.

norm_number_crash({_File, Es}) ->
    lists:any(fun({_, _, Reason}) ->
                      string:find(io_lib:format("~p", [Reason]), "norm_number") =/= nomatch
              end, Es).

%% drop functions, then clauses, while the crash remains
shrink(Forms) ->
    Shrunk = shrink_clauses(shrink_functions(Forms)),
    if Shrunk =:= Forms -> Forms; true -> shrink(Shrunk) end.

shrink_functions(Forms) ->
    Funs = [{N, A} || {function, _, N, A, _} <- Forms],
    lists:foldl(fun({N, A}, Acc) ->
                        Candidate = [F || F <- Acc, not is_fun(F, N, A)],
                        Without = drop_export(Candidate, N, A),
                        case crashes(Without) of true -> Without; false -> Acc end
                end, Forms, Funs).

shrink_clauses(Forms) ->
    Keys = [{N, A} || {function, _, N, A, Cs} <- Forms, length(Cs) > 1],
    lists:foldl(fun shrink_clauses_of/2, Forms, Keys).

shrink_clauses_of({N, A}, Forms) ->
    [{function, _, N, A, Cs}] = [F || F <- Forms, is_fun(F, N, A)],
    lists:foldl(fun(C, Acc) ->
                        [{function, L, _, _, Cs1}] = [F || F <- Acc, is_fun(F, N, A)],
                        case Cs1 of
                            [_, _ | _] ->
                                New = {function, L, N, A, lists:delete(C, Cs1)},
                                Candidate = [case is_fun(F, N, A) of true -> New; false -> F end || F <- Acc],
                                case crashes(Candidate) of true -> Candidate; false -> Acc end;
                            _ -> Acc
                        end
                end, Forms, Cs).

is_fun({function, _, N, A, _}, N, A) -> true;
is_fun(_, _, _) -> false.

drop_export(Forms, N, A) ->
    [case F of
         {attribute, L, export, Es} -> {attribute, L, export, Es -- [{N, A}]};
         {attribute, L, compile, Opts} when is_list(Opts) ->
             {attribute, L, compile, [O || O <- Opts, not mentions(O, N, A)]};
         _ -> F
     end || F <- Forms].

mentions({inline, Fs}, N, A) -> lists:member({N, A}, Fs);
mentions(_, _, _) -> false.
