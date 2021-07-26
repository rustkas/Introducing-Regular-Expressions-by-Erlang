ex01_lookarounds
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_lookarounds && cd ex01_lookarounds && rm -R apps && mkdir lib && cd lib && rebar3 new lib lookarounds && cd ..

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m lookarounds_tests