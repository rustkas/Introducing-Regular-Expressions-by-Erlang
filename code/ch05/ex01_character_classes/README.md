ex01_character_classes
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_character_classes && cd ex01_character_classes && rm -R apps && mkdir lib && cd lib && rebar3 new lib character_classes && cd ..

## Format
	$ rebar3 format
	
## EUnit
-----
	$ rebar3 eunit
	$ rebar3 eunit -m classes_01_tests
	$ rebar3 eunit -m classes_02_negated_character_tests
	$ rebar3 eunit -m classes_03_posix_character_classes_tests
	
	