#!/bin/sh
sudo ifconfig eth1 up && sudo ifconfig eth1 192.168.1.1/29
sudo ifconfig eth2 up && sudo ifconfig eth2 192.168.1.9/29
sudo ifconfig eth3 up && sudo ifconfig eth3 192.168.1.41/30
sudo ifconfig