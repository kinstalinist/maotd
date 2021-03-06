PREFIX = /usr/local
BUILD = ./build

FILES = mao mao.dat maotd
TARGETS = $(addprefix $(BUILD)/, $(FILES))

.PHONY: all
all: $(TARGETS)

$(BUILD):
	mkdir $(BUILD)

$(BUILD)/mao: | $(BUILD)
	cp mao $(BUILD)

$(BUILD)/maotd: | $(BUILD)
	cp maotd $(BUILD)
	sed -i 's;FORTUNE_FILE;$(DESTDIR)$(PREFIX)/share/mao;' $(BUILD)/maotd

$(BUILD)/mao.dat: $(BUILD)/mao | $(BUILD)
	strfile $(BUILD)/mao

.PHONY: install
install: all
	mkdir -p $(DESTDIR)$(PREFIX)/share
	install -m 644 $(BUILD)/mao $(BUILD)/mao.dat $(DESTDIR)$(PREFIX)/share
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install -m 755 $(BUILD)/maotd $(DESTDIR)$(PREFIX)/bin

.PHONY: uninstall
uninstall:
	rm $(addprefix $(DESTDIR)$(PREFIX)/share/, mao mao.dat)
	rm $(DESTDIR)$(PREFIX)/bin/maotd

.PHONY: clean
clean:
	rm -rf $(BUILD)
