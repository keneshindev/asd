if ! [[ "$UID" == 0 ]]; then
  echo "Not running as root, sudoing..."
  sudo $0
fi
rm -rf /opt/sshkey
systemctl stop sshtunnel.service &> /dev/null
systemctl disable sshtunnel.service &> /dev/null
rm /etc/systemd/system/sshtunnel.service
systemctl daemon-reload &> /dev/null
