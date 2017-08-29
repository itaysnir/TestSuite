#!/bin/bash
#
# Multiqueue: Using pktgen threads for sending on multiple CPUs
#  * adding devices to kernel threads
#  * notice the naming scheme for keeping device names unique
#  * nameing scheme: dev@thread_number
#  * flow variation via random UDP source port
#
basedir=`dirname $0`/pktgen
source ${basedir}/functions.sh
root_check_run_with_sudo "$@"
#
# Required param: -i dev in $DEV
source ${basedir}/parameters.sh

# Base Config
DELAY="0"        # Zero means max speed
COUNT="300000000"   # Zero means indefinitely
[ -z "$CLONE_SKB" ] && CLONE_SKB="0"

# Flow variation random source port between min and max
[ -z "$UDP_MIN" ] && UDP_MIN=1980
UDP_MAX=$UDP_MIN

# (example of setting default params in your script)
[ -z "$DEST_IP" ] && DEST_IP="10.1.100.31"
[ -z "$DST_MAC" ] && DST_MAC="7c:fe:90:6f:39:5b"

PKT_SIZE=64
# General cleanup everything since last run
pg_ctrl "reset"

thread=$THREADS
dev=${DEV}@${thread}

# Add remove all other devices and add_device $dev to thread
pg_thread $thread "rem_device_all"
pg_thread $thread "add_device" $dev

# Notice config queue to map to cpu (mirrors smp_processor_id())
# It is beneficial to map IRQ /proc/irq/*/smp_affinity 1:1 to CPU number
pg_set $dev "flag QUEUE_MAP_CPU"

# Base config of dev
pg_set $dev "count $COUNT"
pg_set $dev "clone_skb $CLONE_SKB"
pg_set $dev "pkt_size $PKT_SIZE"
pg_set $dev "delay $DELAY"

# Flag example disabling timestamping
pg_set $dev "flag NO_TIMESTAMP"
pg_set $dev "flag NODE_ALLOC"

echo "$UDP_MIN"
# Setup random UDP port src range
pg_set $dev "flag UDPSRC_RND"
pg_set $dev "udp_src_min $UDP_MIN"
pg_set $dev "udp_src_max $UDP_MAX"

# Destination
echo "ip:[$DEST_IP] mac:[$DST_MAC]"
pg_set $dev "dst_mac $DST_MAC"
pg_set $dev "dst $DEST_IP"

SRC_MAC="7c:fe:90:6f:3a:cf"
pg_set $dev "src_mac $SRC_MAC"
# start_run
echo "Running... ctrl^C to stop" >&2
pg_ctrl "start"
echo "Done" >&2


