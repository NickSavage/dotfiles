lxc-create -n $1 -t debian -- -r stretch -a amd64 --mirror=http://10.0.3.10:80/debian

cp /root/scripts/lxcinit.sh /var/lib/lxc/$1/rootfs
