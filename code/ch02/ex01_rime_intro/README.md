ex01_rime_intro
=====

Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_rime_intro && cd ex01_rime_intro && rm -R apps && mkdir lib && cd lib && rebar3 new lib rime_intro && cd ..
	
EUnit
-----
	$ rebar3 eunit -v
	$ rebar3 eunit -v -m tests_05_maching_word_characters_tests
	$ rebar3 eunit -v -m tests_06_maching_non_word_characters_tests
	$ rebar3 eunit -v -m tests_07_word_boundary_tests
	$ rebar3 eunit -v -m tests_08_alert_tests
	$ rebar3 eunit -v -m tests_09_backspace_character_tests
	

Build
-----
	$ rebar3 compile	