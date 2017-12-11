echo "SET Public Key"
echo $PUBLIC_KEY >> /home/cloud9/.ssh/authorized_keys
echo "START sshd"
/usr/sbin/sshd -D && tail -f /dev/null 
