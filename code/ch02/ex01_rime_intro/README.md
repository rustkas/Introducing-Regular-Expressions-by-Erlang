ex01_rime_intro
=====

Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_rime_intro && cd ex01_rime_intro && rm -R apps && mkdir lib && cd lib && rebar3 new lib rime_intro && cd ..
	
EUnit
-----
	$ rebar3 eunit -v
	$ rebar3 eunit -v -m posix_01_alpha_tests
	$ rebar3 eunit -v -m posix_02_alnum_tests
	$ rebar3 eunit -v -m posix_03_lower_tests
	$ rebar3 eunit -v -m posix_04_upper_tests

	

Build
-----
	$ rebar3 compile	