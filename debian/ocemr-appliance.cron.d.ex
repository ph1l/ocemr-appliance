#
# Regular cron jobs for the ocemr-appliance package
#
0 4	* * *	root	[ -x /usr/bin/ocemr-appliance_maintenance ] && /usr/bin/ocemr-appliance_maintenance
