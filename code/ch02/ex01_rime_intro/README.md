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
    $ rebar3 eunit -v -m posix_05_digit_tests
	$ rebar3 eunit -v -m posix_06_graph_tests
	$ rebar3 eunit -v -m posix_07_print_tests
	$ rebar3 eunit -v -m posix_08_punct_tests
	$ rebar3 eunit -v -m posix_09_space_tests
	$ rebar3 eunit -v -m posix_10_cntrl_tests
    $ rebar3 eunit -v -m posix_11_xdigit_tests
	$ rebar3 eunit -v -m posix_12_ascii_tests
	
	$ rebar3 eunit -v -m tests_09_whitespace_01_tests
	$ rebar3 eunit -v -m tests_09_whitespace_02_tests
	$ rebar3 eunit -v -m tests_09_whitespace_03_tests
	
	$ rebar3 eunit -v -m tests_10_form_feed_tests
	$ rebar3 eunit -v -m tests_11_horizontal_whitespace_tests
	$ rebar3 eunit -v -m tests_12_not_horizontal_whitespace_tests
	$ rebar3 eunit -v -m tests_13_new_line_tests
	$ rebar3 eunit -v -m tests_14_carridge_return_tests
	$ rebar3 eunit -v -m tests_15_horizontal_tab_tests
	$ rebar3 eunit -v -m tests_16_vertical_tab_tests
	$ rebar3 eunit -v -m tests_17_not_vertical_whitespace_tests
	

Build
-----
	$ rebar3 compile	