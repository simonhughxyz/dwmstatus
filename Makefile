PREFIX ?= /usr/local
CC ?= cc
LDFLAGS = -lX11

output: dwmblocks.c blocks.h
	${CC}  dwmblocks.c $(LDFLAGS) -o dwmblocks

clean:
	rm -f *.o *.gch dwmblocks
install: output
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 0755 dwmblocks $(DESTDIR)$(PREFIX)/bin/dwmblocks
	install -m 0755 dwmmodules.sh $(DESTDIR)$(PREFIX)/bin/dwmmodules
	install -m 0755 dwmstatus.sh $(DESTDIR)$(PREFIX)/bin/dwmstatus
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwmblocks
