ex01_matching_tags
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_matching_tags && cd ex01_matching_tags && rm -R apps && mkdir lib && cd lib && rebar3 new lib matching_tags && cd ..

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m matching_tags_tests