ex01_rime_intro
=====

Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_rime_intro && cd ex01_rime_intro && rm -R apps && mkdir lib && cd lib && rebar3 new lib rime_intro && cd ..
	
EUnit
-----
	$ rebar3 eunit -v
	
	# Rime intro
	$ rebar3 eunit -v -m tests_01_read_file_tests
	
	# Simple pattern matching
	$ rebar3 eunit -v -m tests_01_word_boundary_tests
	$ rebar3 eunit -v -m tests_02_alert_tests
	$ rebar3 eunit -v -m tests_03_backspace_character_tests
	$ rebar3 eunit -v -m tests_04_non_word_boundary_tests
	$ rebar3 eunit -v -m tests_05_octal_value_tests
	$ rebar3 eunit -v -m tests_06_form_feed_01_tests
	$ rebar3 eunit -v -m tests_06_form_feed_02_tests
	$ rebar3 eunit -v -m tests_07_carriage_return_01_tests
	$ rebar3 eunit -v -m tests_07_carriage_return_02_tests
	$ rebar3 eunit -v -m tests_08_new_line_01_tests
	$ rebar3 eunit -v -m tests_08_new_line_02_tests
	$ rebar3 eunit -v -m tests_09_whitespace_01_tests
	$ rebar3 eunit -v -m tests_09_whitespace_02_tests
	$ rebar3 eunit -v -m tests_10_whitespace_tests
	$ rebar3 eunit -v -m tests_11_horizontal_whitespace_tests
	$ rebar3 eunit -v -m tests_12_not_horizontal_whitespace_tests
	$ rebar3 eunit -v -m tests_13_horizontal_tab_tests
	$ rebar3 eunit -v -m tests_13_horizontal_tab_tests
	$ rebar3 eunit -v -m tests_14_vertical_tab_tests
	$ rebar3 eunit -v -m tests_15_non_vertical_whitespace_tests
	
	# Posix notation
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
	
	# Maching any character
    $ rebar3 eunit -v -m any_01_full_stop_01_tests
	$ rebar3 eunit -v -m any_01_full_stop_02_tests
	$ rebar3 eunit -v -m any_01_full_stop_03_tests
	$ rebar3 eunit -d lib/lib_04_maching_any_character/test
	$ rebar3 eunit -v -m any_02_8_dots_01_tests
	$ rebar3 eunit -v -m any_02_8_dots_02_tests
	
	## ANCYENT
	$ rebar3 eunit -v -m app_01_get_all_env_tests
	
	

Build
-----
	$ rebar3 compile	