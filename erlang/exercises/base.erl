-module(base).
-export([start/0, is_palindrome/1]).%, is_an_anagram/2, factors/1, is_proper/1]).

start() ->
    io:format("ceo = ~p\n", [is_palindrome("ceo")]),
    io:format("mom = ~p\n", [is_palindrome("mom")]),
    io:format("moom = ~p\n", [is_palindrome("moom")]),
    io:format("abc true = ~p\n", [is_an_anagram("abc", ["abc", "bac", "bca", "cab", "cba"])]),
    io:format("abc false = ~p\n", [is_an_anagram("abc", ["cacca"])]).

is_palindrome("") ->
    true;

is_palindrome([_]) ->
    true;

is_palindrome(Str) ->
    (lists:nth(1, Str) == lists:last(Str))
    and
    is_palindrome(lists:sublist(Str, 2, (string:length(Str)-2))).

is_an_anagram(_, []) -> true;
is_an_anagram(Str, [H|T]) ->
    (lists:sort(Str) == lists:sort(H)) and is_an_anagram(Str, T).

factors(0) ->
    [];

factors(N) ->
    true.
