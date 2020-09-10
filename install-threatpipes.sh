# script to install threatpipes automatically

apt-update
apt-get install python3-venv
tar xvzf threatpipes.tar.gz
cd threatpipes
./threatpipes.sh prodinstall

sleep 10s
systemctl stop threatpipes
systemctl start threatpipes
systemctl restart threatpipes
systemctl status threatpipes
