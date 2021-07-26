ex01_quontifiers
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
	$ rebar3 eunit -m quontifiers_tests
	$ rebar3 eunit -m number_of_times_tests
	$ rebar3 eunit -m lazy_quontifies_tests
	$ rebar3 eunit -m possessive_quontifies_tests