
# SHELL=zsh

all:


BIN_DIR:=$(DESTDIR)/usr/bin/
SHARE_DIR:=$(DESTDIR)/usr/share/p4-tools

install: all
	install --directory -D $(BIN_DIR)
	install bin/*[^~] $(BIN_DIR)

	install --directory -D $(SHARE_DIR)
	install share/*[^~] $(SHARE_DIR)/

# share...


clean:
	@echo  "nothing to clean"
