ex01_tel_number
=====

pplication

Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_tel_number && cd ex01_tel_number && rm -R apps && mkdir lib && cd lib && rebar3 new lib tel_number && cd ..
	
EUnit
-----
	$ rebar3 eunit -v -m tel_number_tests


Build
-----
	$ rebar3 compile	