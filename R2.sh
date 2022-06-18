#!/bin/sh
sudo ifconfig eth1 up && sudo ifconfig eth1 192.168.1.4/29
sudo ifconfig eth2 up && sudo ifconfig eth2 192.168.1.17/29
sudo ifconfig eth3 up && sudo ifconfig eth3 192.168.1.33/29
sudo ifconfig