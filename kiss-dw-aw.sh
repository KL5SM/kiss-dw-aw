#!/bin/bash -x
#Ending any prevously running systems for no fails
   sudo killall direwolf ax25 kissattach mkiss netrom netromd ax25d
    echo "AX.25 and Direwolf-1.8 Booting and Bind script"
    echo "Starting Direwolf"
#Load direwolf -p "tnc mode"
    direwolf -t 0 -c /home/<YOURFILE>/direwolf.conf -p & 
    sleep 5
   if [ -z "`ps ax | grep -v grep | grep direwolf`" ]; then
      echo "Warning - Direwolf failed to start"
      exit 1
  fi
    echo "Loading ax.25 kernel module"
#Loading ax25 and netrom kernals before kissattach
    sudo modprobe ax25 
    axkernal=`lsmod | grep ax25 | wc -l` 
  if [ $axkernal -eq 0 ]; then 
    echo "WARNING - Ax25 kernal failed to load" 
    sleep 5
     exit 1
  fi
    echo "Loading Netrom Kernal module"
#waiting for network service
    sudo modprobe netrom 
    
    sudo nrattach netrom
     nrdevice=`ifconfig | grep nr0 | wc -l`
  if [ $nrdevice -eq 0 ]; then
    echo "WARNING - Netrom kernal failed to load"
    exit 1
  fi
    echo "Installing one KISS connection on PTY port /tmp/kisstnc"
#Binding ax.25 to Direwolf tnc on created PTY port /tmp/kisstmp
     sudo kissattach `ls -l /tmp/kisstnc | awk '{ print $11 }'` radio   
     sudo kissparms -c 1 -p radio
    kisskernal=`lsmod | grep mkiss | wc -l` 
  if [ $kisskernal -eq 0 ]; then 
    echo "WARNING - KissTNC mkiss not present"
    sleep 5
     exit 1
  fi
     sudo /usr/sbin/netromd 
     sudo /usr/sbin/ax25d
     echo "Finished, if you have errors, check your related .conf files"
    exit 0 #WOO!
