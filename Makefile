#

POLICY_FILES=promises.cf library.cf init.cf base.cf ocemr.cf update.cf

WORK_DIR=/var/cfengine

CF_BIN=$(WORK_DIR)/bin

##########################################

all: check


install: $(addprefix promises/,$(POLICY_FILES))
	
	if [ ! -d $(DESTDIR)$(WORK_DIR)/masterfiles/templates ]; then \
	  mkdir -p $(DESTDIR)$(WORK_DIR)/masterfiles/templates; \
	  fi
	
	if [ ! -d $(DESTDIR)$(WORK_DIR)/masterfiles/data ]; then \
	  mkdir -p $(DESTDIR)$(WORK_DIR)/masterfiles/data; \
	  fi
	
	if [ ! -d $(DESTDIR)$(WORK_DIR)/modules ]; then \
	  mkdir -p $(DESTDIR)$(WORK_DIR)/modules; \
	  fi
	
	install --owner=root --group=root --mode=644 \
	  $(addprefix promises/,$(POLICY_FILES)) $(DESTDIR)$(WORK_DIR)/masterfiles
	
	install --owner=root --group=root --mode=644 \
	  promises/templates/*.dat $(DESTDIR)$(WORK_DIR)/masterfiles/templates
	
	install --owner=root --group=root --mode=644 \
	  promises/data/* $(DESTDIR)$(WORK_DIR)/masterfiles/data
	
	install --owner=root --group=root --mode=755 \
	  promises/modules/* $(DESTDIR)$(WORK_DIR)/modules
	
	date > $(DESTDIR)$(WORK_DIR)/masterfiles/cf_promises_validated
	
	if [ ! -d $(DESTDIR)/usr/sbin ]; then \
	  mkdir -p $(DESTDIR)/usr/sbin; \
	  fi
	
	install --owner=root --group=root --mode=755 \
	  ocemr-appd $(DESTDIR)/usr/sbin
	
	if [ ! -d $(DESTDIR)/etc/ocemr-appliance ]; then \
	  mkdir -p $(DESTDIR)/etc/ocemr-appliance; \
	  fi
	
	install --owner=www-data --group=www-data --mode=640 \
	  config/* $(DESTDIR)/etc/ocemr-appliance

check: $(addprefix promises/,$(POLICY_FILES))
	
	( cd promises ; $(CF_BIN)/cf-promises -Ivf ./promises.cf )
	

.PHONY: all check install

