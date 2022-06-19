# OSPF一鍵設定

## 聲明

腳本僅提供我自身使用，腳本並沒有經過測試

開發腳本只為了方便我自身測試及使用

此頁面留存的資料僅為了日後方便複習

## 教學及說明

請先設定虛擬機 R1 R2 R3

這邊選擇再製

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled.png)

注意 MAC位址原則請調整為產生新的MAC位址

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%201.png)

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%202.png)

這邊選擇設定

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%203.png)

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%204.png)

#### 如果電腦記憶體小(RAM 小於4GB) 

#### 到系統那邊將記憶體拉到1000以下(512MB)

### R1

介面卡2 為 Subnet12的ip

介面卡3 為 Subnet13的ip

介面卡4 為 Subnet1的ip

### R2

介面卡2 為 Subnet12的ip

介面卡3 為 Subnet23的ip

介面卡4 為 Subnet2的ip

### R3

介面卡2 為 Subnet13的ip

介面卡3 為 Subnet23的ip

介面卡4 為 Subnet3的ip

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%205.png)

選取群駔 啟動

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%206.png)

開啟R1 R2 R3 複製下列指令打到終端

```bash
sudo apt update
bash <(curl -Lso- https://raw.githubusercontent.com/vincent9579/OSPF/main/OSPF.sh)
```

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%207.png)


#### 常見命令

Ping指令

```bash
ping -c 次數 IP
```

關閉網路介面卡 (eth1)
```bash
sudo ifconfig eth1 down
```


開啟網路介面卡 (eth1)
```bash
sudo ifconfig eth1 down
```

## 腳本說明

安裝Quagga 並設定相關文件

```bash
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
```

設定每個虛擬機的IP位置

```bash
Router1(){
    read -p "請輸入Subnet 12的IP (輸入192.168.1.X的X即可)：" Subnet_12
    read -p "請輸入Subnet 12的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_12
    read -p "請輸入Subnet 13的IP (輸入192.168.1.X的X即可)：" Subnet_13
    read -p "請輸入Subnet 13的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_13
    read -p "請輸入Subnet 1的IP (輸入192.168.1.X的X即可)：" Subnet_1
    read -p "請輸入Subnet 1的掩碼 (輸入192.168.1.X/Y的Y即可)：" mask_1
    R1_eth1=$(($Subnet_12+1)) #R2為+2
    R1_eth2=$(($Subnet_13+1)) #R3為+2
    R1_eth3=$(($Subnet_1+1)) #R1 R2 R3 皆為+1
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
```