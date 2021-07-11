ex01_rime_intro
=====

Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_rime_intro && cd ex01_rime_intro && rm -R apps && mkdir lib && cd lib && rebar3 new lib rime_intro && cd ..
	
EUnit
-----
	$ rebar3 eunit -v
	$ rebar3 eunit -v -m read_file_01_tests

Build
-----
	$ rebar3 compile	