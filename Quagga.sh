sudo apt-get update
sudo apt-get install quagga
sudo chmod -R 777 /etc/quagga
sudo cp /usr/share/doc/quagga/examples/zebra.conf.sample /etc/quagga/zebra.conf
sudo cp /usr/share/doc/quagga/examples/ospfd.conf.sample /etc/quagga/ospfd.conf
sudo sed -i s'/zebra=no/zebra=yes/' /etc/quagga/daemons
sudo sed -i s'/ospfd=no/ospfd=yes/' /etc/quagga/daemons
sudo /etc/init.d/quagga start 