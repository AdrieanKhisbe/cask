CASK ?= cask
EMACS ?= emacs

SERVANT_DIR = 'servant'
SERVANT_TMP_DIR = $(SERVANT_DIR)/'tmp'

all: test

test: unit ecukes

unit:
	$(CASK) exec ert-runner

ecukes:
	$(CASK) exec ecukes

start-server: $(SERVANT_DIR)
	${CASK} exec ${EMACS} -Q --load $(SERVANT_DIR)/app.el --batch > $(SERVANT_TMP_DIR)/servant.log

stop-server:
	kill $$(cat $(SERVANT_TMP_DIR)/servant.pid)

$(SERVANT_DIR):
	@mkdir -p $(SERVANT_DIR)
	@mkdir -p $(SERVANT_TMP_DIR)

.PHONY: start-server stop-server unit ecukes test all
