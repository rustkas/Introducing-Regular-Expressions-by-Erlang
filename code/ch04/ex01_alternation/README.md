ex01_alternation
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_alternation && cd ex01_alternation && rm -R apps && mkdir lib && cd lib && rebar3 new lib alternation && cd ..

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m alteration_01_tests
	$ rebar3 eunit -m subpatterns_01_tests
	$ rebar3 eunit -m subpatterns_01_tests
	$ rebar3 eunit -m capturing_groups_01_tests
	$ rebar3 eunit -m non_capturing_groups_01_tests
	
	