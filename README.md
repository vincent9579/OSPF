# Project 4

請先設定虛擬機 R1 R2 R3

這邊選擇再製

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled.png)

注意 MAC位址原則請調整為產生新的MAC位址

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%201.png)

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%202.png)

這邊選擇設定

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%203.png)

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%204.png)

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
出事或錯誤不甘我的事喔^^ 

```bash
sudo apt update && bash <(curl -Lso- https://raw.githubusercontent.com/vincent9579/OSPF/main/OSPF.sh)
```

![Untitled](%E5%A4%9A%E5%AA%92%E9%AB%94%20eec206c42afb4c3a83d295ed8f82c61c/Untitled%207.png)

剩下的按照表單的說明即可