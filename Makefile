
# SHELL=zsh


install:
	install --directory -D $(DESTDIR)/bin/
	install scripts/*[^~] $(DESTDIR)/bin/
	# install scripts/* $(DESTDIR)/bin/


clean:
	@echo  "nothing to clean"
