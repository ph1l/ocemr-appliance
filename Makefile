#

POLICY_FILES=cfengine_stdlib.cf promises.cf library.cf init.cf base.cf ocemr.cf failsafe.cf

POLICY_DIR=/var/cfengine/masterfiles


##########################################

all: check


install: $(POLICY_FILES) $(addprefix templates/,$(TEMPLATES))
	
	if [ ! -d $(DESTDIR)$(POLICY_DIR)/templates ]; then \
	  mkdir -p $(DESTDIR)$(POLICY_DIR)/templates; \
	  fi
	
	if [ ! -d $(DESTDIR)$(POLICY_DIR)/data ]; then \
	  mkdir -p $(DESTDIR)$(POLICY_DIR)/data; \
	  fi
	
	install --owner=root --group=root --mode=644 \
	  $(POLICY_FILES) $(DESTDIR)$(POLICY_DIR)
	
	install --owner=root --group=root --mode=644 \
	  templates/*.dat $(DESTDIR)$(POLICY_DIR)/templates

	install --owner=root --group=root --mode=644 \
	  data/* $(DESTDIR)$(POLICY_DIR)/data


check: $(POLICY_FILES)
	
	/usr/sbin/cf-promises -Ivf ./promises.cf
	

.PHONY: all check install

