#!/bin/bash

#set -e

repeats=1
#text="I'm called"


while (( $# >= 1 ))
do
    key="$1"

    case $key in
        -a)
            hdmi="$2"
            shift # past argument
            ;;
        -b)
            act="$2"
            shift # past argument
            ;;
        -c)
            pwr="$2"
            shift # past argument
            ;;
        -d)
            wifi="$2"
            shift # past argument
            ;;
        -e)
            spot="$2"
            shift # past argument
            ;;
        -f)
            lann="$2"
            shift # past argument
            ;;
        -g)
            bufflan="$2"
            shift # past argument
            ;;
        -h)
            limit="$2"
            shift # past argument
            ;;
        -i)
            turbo="$2"
            shift # past argument
            ;;
        -l)
            delay="$2"
            shift # past argument
            ;;
        -m)
            sd="$2"
            shift # past argument
            ;;
        -n)
            arm="$2"
            shift # past argument
            ;;
        -o)
            gpu="$2"
            shift # past argument
            ;;
        -p)
            core="$2"
            shift # past argument
            ;;
        -q)
            ram="$2"
            shift # past argument
            ;;
        -r)
            dhcp="$2"
            shift # past argument
            ;;
        -s)
            ssh="$2"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
    shift # past argument or value
done



if [ "$hdmi" = "enable" ]; then
    if grep -Fxq hdmi_force_hotplug=1 "/boot/config.txt"; then
        echo "ok"
    else
        echo "hdmi_force_hotplug=1" >> "/boot/config.txt"
    fi
    if grep -Fxq hdmi_blanking=1 "/boot/config.txt"; then
        sed -i '/hdmi_blanking=1/c\' "/boot/config.txt"
        sed -i '/hdmi_ignore_hotplug=1/c\' "/boot/config.txt"
        sed -i '/hdmi_ignore_composite=1/c\' "/boot/config.txt"
    fi
fi


if [ "$hdmi" = "disable" ]; then
  if grep -Fxq hdmi_blanking=1 "/boot/config.txt"; then
        sed -i '/hdmi_force_hotplug=1/c\' "/boot/config.txt"
        echo "ok"
    else
        echo "hdmi_blanking=1" >> "/boot/config.txt"
        echo "hdmi_ignore_hotplug=1" >> "/boot/config.txt"
        echo "hdmi_ignore_composite=1" >> "/boot/config.txt"
        sed -i '/hdmi_force_hotplug=1/c\' "/boot/config.txt"
  fi
fi

if [ "$act" = "enable" ]; then
  if grep -Fxq dtparam=act_led_trigger=none "/boot/config.txt"; then
        sed -i '/dtparam=act_led_trigger=none/c\' "/boot/config.txt"
        sed -i '/dtparam=act_led_activelow=on/c\' "/boot/config.txt"
  else
    echo "ok"
  fi
fi
if [ "$act" = "disable" ]; then
  if grep -Fxq dtparam=act_led_trigger=none "/boot/config.txt"; then
    echo "ok"
  else
    echo "dtparam=act_led_trigger=none" >> /boot/config.txt
    echo "dtparam=act_led_activelow=on" >> /boot/config.txt
  fi
fi

if [ "$pwr" = "enable" ]; then
  if grep -Fxq dtparam=pwr_led_trigger=none "/boot/config.txt"; then
        sed -i '/dtparam=pwr_led_trigger=none/c\' "/boot/config.txt"
        sed -i '/dtparam=pwr_led_activelow=on/c\' "/boot/config.txt"
  else
    echo "ok"
  fi
fi
if [ "$pwr" = "disable" ]; then
  if grep -Fxq dtparam=pwr_led_trigger=none "/boot/config.txt"; then
    echo "ok"
  else
    echo "dtparam=pwr_led_trigger=none" >> /boot/config.txt
    echo "dtparam=pwr_led_activelow=on" >> /boot/config.txt
  fi
fi

if [ "$wifi" = "enable" ]; then
      if grep -Fxq dtoverlay=pi3-disable-wifi "/boot/config.txt"; then
        sed -i '/dtoverlay=pi3-disable-wifi/c\' "/boot/config.txt"
        echo "ok"
    else
        echo "ok"
    fi
fi

if [ "$wifi" = "disable" ]; then
    if grep -Fxq dtoverlay=pi3-disable-wifi "/boot/config.txt"; then
        echo "ok"
    else
        echo "dtoverlay=pi3-disable-wifi" >> "/boot/config.txt"
        echo "ok"
    fi
fi

if [ "$spot" = "enable" ]; then
    if [ -f /etc/local.d/ireteonline.start ]; then
        echo "ok"
    else
        mv /etc/local.d/ireteonline.start.back /etc/local.d/ireteonline.start
        echo "ok"
    fi
fi

if [ "$spot" = "disable" ]; then
    if [ -f /etc/local.d/ireteonline.start ]; then
        mv /etc/local.d/ireteonline.start /etc/local.d/ireteonline.start.back
        echo "ok"
    else
        echo "ok"
    fi
fi

if [ "$lann" = "enable" ]; then
    if grep -Fxq dtparam=eth_led0=14 "/boot/config.txt"; then
        sed -i '/dtparam=eth_led0=14/c\' "/boot/config.txt"
        sed -i '/dtparam=eth_led1=14/c\' "/boot/config.txt"
    else
        echo "ok"
    fi
fi

if [ "$lann" = "disable" ]; then
    if grep -Fxq dtparam=eth_led0=14 "/boot/config.txt"; then
        echo "ok"
    else
        echo "dtparam=eth_led0=14" >> /boot/config.txt
        echo "dtparam=eth_led1=14" >> /boot/config.txt
    fi
fi

if [ "$turbo" = "disable" ]; then
    if grep -Fxq force_turbo=1 "/boot/config.txt"; then
        sed -i '/force_turbo=1/c\' "/boot/config.txt"
    else
        echo "OK"
    fi
fi
if [ "$turbo" = "enable" ]; then
    if grep -Fxq force_turbo=1 "/boot/config.txt"; then
        echo "ok"
    else
        echo "force_turbo=1" >> /boot/config.txt
    fi
fi

if [ "$delay" = "disable" ]; then
    if grep -Fxq boot_delay=1 "/boot/config.txt"; then
        sed -i '/boot_delay=1/c\' "/boot/config.txt"
    else
        echo "OK"
    fi
fi
if [ "$delay" = "enable" ]; then
    if grep -Fxq boot_delay=1 "/boot/config.txt"; then
        echo "ok"
    else
        echo "boot_delay=1" >> /boot/config.txt
    fi
fi

if [ "$sd" = "disable" ]; then
    if grep -Fxq dtoverlay=sdhost,overclock_50=100 "/boot/config.txt"; then
        sed -i '/dtoverlay=sdhost,overclock_50=100/c\' "/boot/config.txt"
    else
        echo "OK"
    fi
fi
if [ "$sd" = "enable" ]; then
    if grep -q dtoverlay=sdhost,overclock_50=100 "/boot/config.txt"; then
        echo "ok"
    else
        echo "dtoverlay=sdhost,overclock_50=100" >> /boot/config.txt
    fi
fi

if [ "$arm" = "default" ]; then
        sed -i '/arm_freq=/c\' "/boot/config.txt"
        echo "OK"
    else
      if grep -q arm_freq= "/boot/config.txt"; then
        sed -i '/arm_freq=/c\arm_freq='"$arm"'' "/boot/config.txt"
      else
        echo "arm_freq=$arm" >> /boot/config.txt
        echo "arm_freq=$arm"
      fi
fi

if [ "$gpu" = "default" ]; then
        sed -i '/gpu_freq=/c\' "/boot/config.txt"
        echo "OK"
    else
      if grep -q gpu_freq= "/boot/config.txt"; then
        sed -i '/gpu_freq=/c\gpu_freq='"$gpu"'' "/boot/config.txt"
      else
        echo "gpu_freq=$gpu" >> /boot/config.txt
        echo "gpu_freq=$gpu"
      fi
fi

if [ "$core" = "default" ]; then
        sed -i '/core_freq=/c\' "/boot/config.txt"
        echo "OK"
    else
      if grep -q core_freq= "/boot/config.txt"; then
        sed -i '/core_freq=/c\core_freq='"$core"'' "/boot/config.txt"
      else
        echo "core_freq=$core" >> /boot/config.txt
        echo "core_freq=$core"
      fi
fi

if [ "$ram" = "default" ]; then
        sed -i '/sdram_freq=/c\' "/boot/config.txt"
        echo "OK"
    else
      if grep -q sdram_freq= "/boot/config.txt"; then
        sed -i '/sdram_freq=/c\sdram_freq='"$ram"'' "/boot/config.txt"
      else
        echo "sdram_freq=$ram" >> /boot/config.txt
        echo "sdram_freq=$ram"
      fi
fi

if [ "$dhcp" = "enable" ]; then
    rc-update add dhcpcd default 2>/dev/null
    rc-service dhcpcd restart 2>/dev/null
else
    rc-update del dhcpcd default 2>/dev/null
fi

if [ "$ssh" = "enable" ]; then
    rc-update add sshd default 2>/dev/null
    rc-service sshd restart 2>/dev/null
else
    rc-update del sshd default 2>/dev/null
fi

echo "$bufflan" > /etc/default/web/twk/bufflan

case $bufflan in
    GP-Standard)
        cat > /etc/sysctl.conf <<EOF
# Controls IP packet forwarding
net.ipv4.ip_forward = 0
# Controls source route verification
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1
# Disables IP source routing
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.all.accept_source_route = 0
# Controls the System Request debugging functionality of the kernel
kernel.sysrq = 0
# Controls whether core dumps will append the PID to the core filename.
# Useful for debugging multi-threaded applications.
kernel.core_uses_pid = 1
# Increase maximum amount of memory allocated to shm
# Only uncomment if needed!
# kernel.shmmax = 67108864
# Disable ICMP Redirect Acceptance
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
# Enable Log Spoofed Packets, Source Routed Packets, Redirect Packets
net.ipv4.conf.default.log_martians = 1
net.ipv4.conf.all.log_martians = 1
# Decrease the time default value for tcp_fin_timeout connection
net.ipv4.tcp_fin_timeout = 25
# Decrease the time default value for tcp_keepalive_time connection
net.ipv4.tcp_keepalive_time = 1200
# Turn on the tcp_window_scaling
net.ipv4.tcp_window_scaling = 1
# Turn on the tcp_sack
net.ipv4.tcp_sack = 1
# tcp_fack should be on because of sack
net.ipv4.tcp_fack = 1
# Turn on the tcp_timestamps
net.ipv4.tcp_timestamps = 1
# Enable TCP SYN Cookie Protection
net.ipv4.tcp_syncookies = 1
# Enable ignoring broadcasts request
net.ipv4.icmp_echo_ignore_broadcasts = 1
# Enable bad error message Protection
net.ipv4.icmp_ignore_bogus_error_responses = 1
# Make more local ports available
# net.ipv4.ip_local_port_range = 1024 65000
# Set TCP Re-Ordering value in kernel to '5'
net.ipv4.tcp_reordering = 5
# Lower syn retry rates
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 3
# Set Max SYN Backlog to '2048'
net.ipv4.tcp_max_syn_backlog = 2048
# Various Settings
net.core.netdev_max_backlog = 1024
# Increase the maximum number of skb-heads to be cached
net.core.hot_list_length = 256
# Increase the tcp-time-wait buckets pool size
net.ipv4.tcp_max_tw_buckets = 360000
# This will increase the amount of memory available for socket input/output queues
net.core.rmem_default = 65535
net.core.rmem_max = 8388608
net.ipv4.tcp_rmem = 4096 87380 8388608
net.core.wmem_default = 65535
net.core.wmem_max = 8388608
net.ipv4.tcp_wmem = 4096 65535 8388608
net.ipv4.tcp_mem = 8388608 8388608 8388608
net.core.optmem_max = 40960
#
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
    linux-Standard)
        cat > /etc/sysctl.conf <<EOF
# /etc/sysctl.conf
#
# For more information on how this file works, please see
# the manpages sysctl(8) and sysctl.conf(5).
#
# In order for this file to work properly, you must first
# enable 'Sysctl support' in the kernel.
#
# Look in /proc/sys/ for all the things you can setup.
#
# Disables packet forwarding
net.ipv4.ip_forward = 0
# Disables IP dynaddr
#net.ipv4.ip_dynaddr = 0
# Disable ECN
#net.ipv4.tcp_ecn = 0
# Enables source route verification
#net.ipv4.conf.default.rp_filter = 1
# Enable reverse path
#net.ipv4.conf.all.rp_filter = 1
# Enable SYN cookies (yum!)
# http://cr.yp.to/syncookies.html
#net.ipv4.tcp_syncookies = 1
# Enable people in the specified (min, max) group range to send ICMP_ECHO
# messages (i.e. ping) and receive ICMP_ECHOREPLY responses.  This allows
# you to run non-suid and non-caps ping, but it also means anyone with
# a gid in this range can send those packets (not just via ping).
#net.ipv4.ping_group_range = 100 100
# Disable source route
#net.ipv4.conf.all.accept_source_route = 0
#net.ipv4.conf.default.accept_source_route = 0
# Disable redirects
#net.ipv4.conf.all.accept_redirects = 0
#net.ipv4.conf.default.accept_redirects = 0
# Disable secure redirects
#net.ipv4.conf.all.secure_redirects = 0
#net.ipv4.conf.default.secure_redirects = 0
# Ignore ICMP broadcasts
#net.ipv4.icmp_echo_ignore_broadcasts = 1
# Disables the magic-sysrq key
#kernel.sysrq = 0
# When the kernel panics, automatically reboot in 3 seconds
#kernel.panic = 3
# Allow for more PIDs (cool factor!); may break some programs
#kernel.pid_max = 999999
# You should compile nfsd into the kernel or add it
# to modules.autoload for this to work properly
# TCP Port for lock manager
#fs.nfs.nlm_tcpport = 0
# UDP Port for lock manager
#fs.nfs.nlm_udpport = 0
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
    GP1)
        cat > /etc/sysctl.conf <<EOF
        net.core.rmem_max=26214400
net.core.wmem_max=26214400
net.ipv4.tcp_rmem='4096 1048576 26214400'
net.ipv4.tcp_wmem='4096 1048576 26214400'
net.ipv4.tcp_mem='26214400 26214400 26214400'
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
    GP2)
        cat > /etc/sysctl.conf <<EOF
net.core.rmem_max=8388608
net.core.wmem_max=8388608
net.core.rmem_default=65536
net.core.wmem_default=65536
net.ipv4.tcp_rmem='4096 87380 8388608'
net.ipv4.tcp_wmem='4096 65536 8388608'
net.ipv4.tcp_mem='8388608 8388608 8388608'
net.ipv4.route.flush=1
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
    GP3)
        cat > /etc/sysctl.conf <<EOF

### TUNING NETWORK PERFORMANCE ###

# Default Socket Receive Buffer
net.core.rmem_default = 31457280

# Maximum Socket Receive Buffer
net.core.rmem_max = 12582912

# Default Socket Send Buffer
net.core.wmem_default = 31457280

# Maximum Socket Send Buffer
net.core.wmem_max = 12582912

# Increase number of incoming connections
net.core.somaxconn = 4096

# Increase number of incoming connections backlog
net.core.netdev_max_backlog = 65536

# Increase the maximum amount of option memory buffers
net.core.optmem_max = 25165824

# Increase the maximum total buffer-space allocatable
# This is measured in units of pages (4096 bytes)
net.ipv4.tcp_mem = 65536 131072 262144
net.ipv4.udp_mem = 65536 131072 262144

# Increase the read-buffer space allocatable
net.ipv4.tcp_rmem = 8192 87380 16777216
net.ipv4.udp_rmem_min = 16384

# Increase the write-buffer-space allocatable
net.ipv4.tcp_wmem = 8192 65536 16777216
net.ipv4.udp_wmem_min = 16384

# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks
net.ipv4.tcp_max_tw_buckets = 1440000
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
    GP4)
        cat > /etc/sysctl.conf <<EOF
# /etc/sysctl.conf
#
# For more information on how this file works, please see
# the manpages sysctl(8) and sysctl.conf(5).
#
# In order for this file to work properly, you must first
# enable 'Sysctl support' in the kernel.
#
# Look in /proc/sys/ for all the things you can setup.
#

# Disables packet forwarding
net.ipv4.ip_forward = 0
# Disables IP dynaddr
#net.ipv4.ip_dynaddr = 0
# Disable ECN
#net.ipv4.tcp_ecn = 0
# Enables source route verification
#net.ipv4.conf.default.rp_filter = 1
# Enable reverse path
#net.ipv4.conf.all.rp_filter = 1

# Enable SYN cookies (yum!)
# http://cr.yp.to/syncookies.html
#net.ipv4.tcp_syncookies = 1

# Enable people in the specified (min, max) group range to send ICMP_ECHO
# messages (i.e. ping) and receive ICMP_ECHOREPLY responses.  This allows
# you to run non-suid and non-caps ping, but it also means anyone with
# a gid in this range can send those packets (not just via ping).
#net.ipv4.ping_group_range = 100 100

# Disable source route
#net.ipv4.conf.all.accept_source_route = 0
#net.ipv4.conf.default.accept_source_route = 0

# Disable redirects
#net.ipv4.conf.all.accept_redirects = 0
#net.ipv4.conf.default.accept_redirects = 0

# Disable secure redirects
#net.ipv4.conf.all.secure_redirects = 0
#net.ipv4.conf.default.secure_redirects = 0

# Ignore ICMP broadcasts
#net.ipv4.icmp_echo_ignore_broadcasts = 1

# Disables the magic-sysrq key
#kernel.sysrq = 0
# When the kernel panics, automatically reboot in 3 seconds
#kernel.panic = 3
# Allow for more PIDs (cool factor!); may break some programs
#kernel.pid_max = 999999

# You should compile nfsd into the kernel or add it
# to modules.autoload for this to work properly
# TCP Port for lock manager
#fs.nfs.nlm_tcpport = 0
# UDP Port for lock manager
#fs.nfs.nlm_udpport = 0
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
    GP5)
        cat > /etc/sysctl.conf <<EOF
net.core.wmem_max = 16777216
net.core.wmem_default = 131072
net.core.rmem_max = 16777216
net.core.rmem_default = 131072
net.ipv4.tcp_rmem = 4096 131072 16777216
net.ipv4.tcp_wmem = 4096 131072 16777216
net.ipv4.tcp_mem = 4096 131072 16777216

net.core.netdev_max_backlog = 30000
net.ipv4.ipfrag_high_threshold = 8388608
vm.swappiness=0
fs.inotify.max_user_watches = 524288
EOF
        ;;
esac


echo "$limit" > /etc/default/web/twk/limit

case $limit in
    GP-Standard)
        cat > /etc/security/limits.conf <<EOF
*  hard rtprio  0
*  soft rtprio  0
@realtime hard rtprio  20
@realtime    soft rtprio    10
@audio  - rtprio  99
@audio  - memlock  unlimited
EOF
        ;;
    linux-Standard)
        cat > /etc/security/limits.conf <<EOF
EOF
        ;;
    GP1)
        cat > /etc/security/limits.conf <<EOF
*  hard rtprio  0
*  soft rtprio  0
@realtime hard rtprio  20
@realtime    soft rtprio    10
@audio  - rtprio  99
@audio  - memlock  unlimited
@audio - nice -20
EOF
        ;;
    GP2)
        cat > /etc/security/limits.conf <<EOF
@audio - rtprio 99
@audio - memlock 512000
@audio - nice -20
EOF
        ;;
esac
