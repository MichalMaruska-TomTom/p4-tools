
# SHELL=zsh

all:



install: all
	install --directory -D $(DESTDIR)/usr/bin/
	install scripts/*[^~] $(DESTDIR)/usr/bin/
# share...


clean:
	@echo  "nothing to clean"
