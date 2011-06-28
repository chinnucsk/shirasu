PREFIX:=../
DEST:=$(PREFIX)$(PROJECT)

REBAR=./rebar

all:
	@$(REBAR) get-deps compile

edoc:
	@$(REBAR) doc

test:
	@rm -rf .eunit
	@mkdir -p .eunit
	@$(REBAR) skip_deps=true eunit

clean:
	@$(REBAR) clean

build_plt:
	@$(REBAR) build-plt

dialyzer:
	@$(REBAR) dialyze

app:
	@$(REBAR) create template=mochiwebapp dest=$(DEST) appid=$(PROJECT)

xref:
	@$(REBAR) xref

eunit:
	@$(REBAR) eunit

info:
	@$(REBAR) list-deps

serve:
	(cd priv; ./start.sh)

debug:
	($(MAKE) clean; $(MAKE))
	(erl -pa $$PWD/ebin deps/*/ebin -boot start_sasl -s shirasu -shirasu setting \"priv/mysetting.yaml\")
