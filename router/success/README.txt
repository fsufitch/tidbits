Guidance from:

* https://arstechnica.com/gadgets/2016/04/the-ars-guide-to-building-a-linux-router-from-scratch/

Notes:

* Copy the contents of this dir (other than the README) into the root FS
* Run:
	sudo chown root /etc/network/if-pre-up.d/iptables ; chmod 755 /etc/network/if-pre-up.d/iptables1
* When iptables config changes (including now), run:
	sudo /etc/network/if-pre-up.d/iptables
* Install: dnsmasq
* Run:
	sudo systemctl enable dnsmasq
	sudo systemctl restart dnsmasq
* Restart dnsmasq anytime config changes or cache should be flushed


