ex01_rime
=====

## Create new project

----	
	
	# all commands in one string
	$ rebar3 new umbrella ex01_rime && cd ex01_rime && rm -R apps && mkdir lib && cd lib && rebar3 new lib rime && cd ..
	
## EUnit
-----
	$ rebar3 eunit -v
	
### Rime intro
	$ rebar3 eunit -m line_01_beginning_end_tests
	$ rebar3 eunit -m line_02_words_no_words_boundaries_tests
	$ rebar3 eunit -m line_03_quoting_group_characters_as_literal_tests
	$ rebar3 eunit -m line_03_add_tags_tests