if ! [[ "$UID" == 0 ]]; then
  echo "Not running as root, sudoing..."
  sudo $0
fi
pacman -Q openssh &> /dev/null
if ! [[ "$?" == 0 ]]; then
  echo "openssh is not installed, installing..."
  pacman -S --confirm openssh &> /dev/null
fi
mkdir -p /opt/sshkey
ssh-keygen -f /opt/sshkey/id_rsa -N "" -q
printf "Public key: "
cat /opt/sshkey/id_rsa.pub
rm /etc/default/sshtunnel
echo "USER=$1" >> /etc/default/sshtunnel
echo "HOST=$2" >> /etc/default/sshtunnel
echo "PORT=22" >> /etc/default/sshtunnel
echo "TPORT=$3" >> /etc/default/sshtunnel
cp ./sshtunnel.service /etc/systemd/system
systemctl daemon-reload &> /dev/null
systemctl enable sshtunnel.service &> /dev/null
read -ei "Press ENTER when ready..."
systemctl start sshtunnel.service &> /dev/null
