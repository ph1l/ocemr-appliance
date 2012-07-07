#

POLICY_FILES=cfengine_stdlib.cf promises.cf library.cf init.cf base.cf ocemr.cf failsafe.cf

POLICY_DIR=/var/cfengine/masterfiles


##########################################

all: check


install: $(addprefix promises/,$(POLICY_FILES))
	
	if [ ! -d $(DESTDIR)$(POLICY_DIR)/templates ]; then \
	  mkdir -p $(DESTDIR)$(POLICY_DIR)/templates; \
	  fi
	
	if [ ! -d $(DESTDIR)$(POLICY_DIR)/data ]; then \
	  mkdir -p $(DESTDIR)$(POLICY_DIR)/data; \
	  fi
	
	if [ ! -d $(DESTDIR)$(POLICY_DIR)/modules ]; then \
	  mkdir -p $(DESTDIR)$(POLICY_DIR)/modules; \
	  fi
	
	install --owner=root --group=root --mode=644 \
	  $(addprefix promises/,$(POLICY_FILES)) $(DESTDIR)$(POLICY_DIR)
	
	install --owner=root --group=root --mode=644 \
	  promises/templates/*.dat $(DESTDIR)$(POLICY_DIR)/templates
	
	install --owner=root --group=root --mode=644 \
	  promises/data/* $(DESTDIR)$(POLICY_DIR)/data
	
	install --owner=root --group=root --mode=755 \
	  promises/modules/* $(DESTDIR)$(POLICY_DIR)/modules
	
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
	
	( cd promises ; /usr/sbin/cf-promises -Ivf ./promises.cf )
	

.PHONY: all check install

