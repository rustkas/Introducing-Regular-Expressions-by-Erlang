ex01_maching_unicode
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_maching_unicode && cd ex01_maching_unicode && rm -R apps && mkdir lib && cd lib && rebar3 new lib maching_unicode && cd ..

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m maching_unicode_tests
	$ escript e:/rebar3/rebar3 eunit -m maching_unicode_tests