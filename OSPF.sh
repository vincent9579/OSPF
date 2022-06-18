#!/bin/sh

pass="zebra"
Router=0


install_Quagga(){
sudo apt-get install expect
sudo apt-get install quagga
sudo chmod -R 777 /etc/quagga
sudo cp /usr/share/doc/quagga/examples/zebra.conf.sample /etc/quagga/zebra.conf
sudo cp /usr/share/doc/quagga/examples/ospfd.conf.sample /etc/quagga/ospfd.conf
sudo sed -i s'/zebra=no/zebra=yes/' /etc/quagga/daemons
sudo sed -i s'/ospfd=no/ospfd=yes/' /etc/quagga/daemons
sudo /etc/init.d/quagga start
}


Router1(){
read -p "請輸入Subnet 12的IP (輸入192.168.1.X的X即可)：" Subnet_12
read -p "請輸入Subnet 12的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_12
read -p "請輸入Subnet 13的IP (輸入192.168.1.X的X即可)：" Subnet_13
read -p "請輸入Subnet 13的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_13
read -p "請輸入Subnet 1的IP (輸入192.168.1.X的X即可)：" Subnet_1
read -p "請輸入Subnet 1的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_1
R1_eth1=$(($Subnet_12+1))
R1_eth2=$(($Subnet_13+1))
R1_eth3=$(($Subnet_1+1))
sudo ifconfig eth1 up && sudo ifconfig eth1 192.168.1.$R1_eth1/$mask_12
sudo ifconfig eth2 up && sudo ifconfig eth2 192.168.1.$R1_eth2/$mask_13
sudo ifconfig eth3 up && sudo ifconfig eth3 192.168.1.$R1_eth3/$mask_1
install_Quagga

expect << EOF
        set timeout 1
        spawn telnet localhost 2604
        expect "Password:"
        send "$pass\n"
        expect "ospfd>"
        send "enable\n"
        expect "ospfd#"
        send "configure t\n"
        expect "ospfd(config)#"
        send "hostname r$Router\n"
        expect "r$Router(config)#"
        send "router ospf\n"
        expect "r$Router(config-router)#"
        send "ospf router-id 192.168.1.$R1_eth1\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_12/$mask_12 area 0\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_13/$mask_13 area 0\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_1/$mask_1 area 0\n"
        expect "r$Router(config-router)#"
        send "debug ospf event\n"
        expect "r$Router(config)#"
        send "exit\n"
        expect "r$Router#"
        send "exit\n"
EOF

}

Router2(){
read -p "請輸入Subnet 12的IP (輸入192.168.1.X的X即可)：" Subnet_12
read -p "請輸入Subnet 12的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_12
read -p "請輸入Subnet 23的IP (輸入192.168.1.X的X即可)：" Subnet_23
read -p "請輸入Subnet 23的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_23
read -p "請輸入Subnet 2的IP (輸入192.168.1.X的X即可)：" Subnet_2
read -p "請輸入Subnet 2的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_2
R2_eth1=$(($Subnet_12+2))
R2_eth2=$(($Subnet_23+1))
R2_eth3=$(($Subnet_2+1))
sudo ifconfig eth1 up && sudo ifconfig eth1 192.168.1.$R2_eth1/$mask_12
sudo ifconfig eth2 up && sudo ifconfig eth2 192.168.1.$R2_eth2/$mask_23
sudo ifconfig eth3 up && sudo ifconfig eth3 192.168.1.$R2_eth3/$mask_2
install_Quagga
expect << EOF
        set timeout 1
        spawn telnet localhost 2604
        expect "Password:"
        send "$pass\n"
        expect "ospfd>"
        send "enable\n"
        expect "ospfd#"
        send "configure t\n"
        expect "ospfd(config)#"
        send "hostname r$Router\n"
        expect "r$Router(config)#"
        send "router ospf\n"
        expect "r$Router(config-router)#"
        send "ospf router-id 192.168.1.$R2_eth1\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_12/$mask_12 area 0\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_23/$mask_23 area 0\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_2/$mask_2 area 0\n"
        expect "r$Router(config-router)#"
        send "debug ospf event\n"
        expect "r$Router(config)#"
        send "exit\n"
        expect "r$Router#"
        send "exit\n"
EOF
}

Router3(){
read -p "請輸入Subnet 13的IP (輸入192.168.1.X的X即可)：" Subnet_13
read -p "請輸入Subnet 13的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_13
read -p "請輸入Subnet 23的IP (輸入192.168.1.X的X即可)：" Subnet_23
read -p "請輸入Subnet 23的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_23
read -p "請輸入Subnet 3的IP (輸入192.168.1.X的X即可)：" Subnet_3
read -p "請輸入Subnet 3的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_3
R3_eth1=$(($Subnet_13+2))
R3_eth2=$(($Subnet_23+2))
R3_eth3=$(($Subnet_3+1))
sudo ifconfig eth1 up && sudo ifconfig eth1 192.168.1.$R3_eth1/$mask_13
sudo ifconfig eth2 up && sudo ifconfig eth2 192.168.1.$R3_eth2/$mask_23
sudo ifconfig eth3 up && sudo ifconfig eth3 192.168.1.$R3_eth3/$mask_3
install_Quagga
expect << EOF
        set timeout 1
        spawn telnet localhost 2604
        expect "Password:"
        send "$pass\n"
        expect "ospfd>"
        send "enable\n"
        expect "ospfd#"
        send "configure t\n"
        expect "ospfd(config)#"
        send "hostname r$Router\n"
        expect "r$Router(config)#"
        send "router ospf\n"
        expect "r$Router(config-router)#"
        send "ospf router-id 192.168.1.$R3_eth1\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_13/$mask_13 area 0\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_23/$mask_23 area 0\n"
        expect "r$Router(config-router)#"
        send "network 192.168.1.$Subnet_3/$mask_3 area 0\n"
        expect "r$Router(config-router)#"
        send "debug ospf event\n"
        expect "r$Router(config)#"
        send "exit\n"
        expect "r$Router#"
        send "exit\n"
EOF
}


show_menu(){
echo "注意：腳本無防呆 請警慎使用"
echo "請查看project 2的表單 並在接下來的部分照實填寫"
echo "192.168.1.0/30 的 0 為需要輸入的IP"
echo "192.168.1.0/30 的 30 為需要輸入的掩碼"
echo && read -p "請輸入Router編號 [0：退出] [1-3]: " num
    case "${num}" in
    0)
        exit 0
        ;;
    1)
        Router=1
        Router1
        ;;
    2)
        Router=2
        Router2
        ;;
    3)
        Router=3
        Router3
        ;;
    *)
        echo "請輸入正確數字 [1-3]"
        ;;
    esac
}

show_menu