ex01_useful_examples
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_useful_examples && cd ex01_useful_examples && rm -R apps && mkdir lib && cd lib && rebar3 new lib useful_examples && cd ..
	
## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m useful_examples_tests
	$ rebar3 eunit -m matching_north_american_phone_number_tests