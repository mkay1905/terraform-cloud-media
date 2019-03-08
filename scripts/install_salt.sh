#!/bin/bash
echo 'config saltstack repo'
yum install https://repo.saltstack.com/yum/redhat/salt-repo-2018.3.el7.noarch.rpm -y > /dev/null 2>&1

if [ -z $1 ]; then
  echo you need to give an arg: master or minion
  exit -1
fi

echo "install salt-$1"
yum install salt-$1 -y > /dev/null 2>&1
echo "enable salt-$1"
systemctl enable salt-$1
if [ $1 == 'master' ];then
cat >> /etc/salt/master <<EOL
  file_roots:
    base:
     - /srv/salt-cloudmedia-repo
  pillar_roots:
  base:
    - /srv/salt-cloudmedia-pillar
  auto_accept: True
EOL
elif [ $1 == 'minion' ];then
  echo "config salt-$1"
  echo 'master : 10.0.0.50' >> /etc/salt/minion
fi
if [ ! -z $2 ]; then
  echo 'We change the minion_id'
  echo $2 > /etc/salt/minion_id
fi
echo "start salt-$1"
systemctl start salt-$1
exit 0
