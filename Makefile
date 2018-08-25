all:

install:

	if [ ! -d $(DESTDIR)/usr/sbin ]; then \
	  mkdir -p $(DESTDIR)/usr/sbin; \
	  fi

	install --owner=root --group=root --mode=755 \
	  ocemr-appd $(DESTDIR)/usr/sbin

	if [ ! -d $(DESTDIR)/etc/sudoers.d ]; then \
	  mkdir -p $(DESTDIR)/etc/sudoers.d; \
	  fi

	install --owner=root --group=root --mode=600 \
	  ocemr.sudoers $(DESTDIR)/etc/sudoers.d/ocemr

	if [ ! -d $(DESTDIR)/etc/ocemr-appliance ]; then \
	  mkdir -p $(DESTDIR)/etc/ocemr-appliance; \
	  fi

	install --owner=www-data --group=www-data --mode=640 \
	  config/* $(DESTDIR)/etc/ocemr-appliance

	if [ ! -d $(DESTDIR)/etc/ocemr-appliance/ansible ]; then \
	  mkdir -p $(DESTDIR)/etc/ocemr-appliance/ansible; \
	  fi

	install --owner=www-data --group=www-data --mode=640 \
	  ansible/ocemr.yml $(DESTDIR)/etc/ocemr-appliance/ansible/

	find ansible/ocemr/ -type f -exec install \
	  --owner=www-data --group=www-data --mode=640 -D \
	  "{}" "$(DESTDIR)/etc/ocemr-appliance/{}" \;

.PHONY: install

