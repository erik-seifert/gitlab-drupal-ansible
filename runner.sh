#!/bin/sh
if [ -z "$DEPLOY_HOST" ]; then
    echo "Need to set DEPLOY_HOST"
    exit 1
fi
if [ -z "$SSH_KEY" ]; then
    echo "Need to set SSH_KEY"
    exit 1
fi
if [ -z "$DEPLOY_USER" ]; then
    echo "Need to set DEPLOY_USER"
    exit 1
fi

ssh-keyscan ${DEPLOY_HOST}

echo "Starting ansible script";

echo "-- ADD SSH KEY --";

# mkdir /root/.ssh
echo "${SSH_KEY}" > /key.priv
chmod 700 /key.priv
chown root:root /key.priv

cat /root/.ssh/id_rsa

ansible --version

chmod root:root /root/.ssh -R

echo ${DEPLOY_HOST} > /inventory

ansible-playbook /playbook/bootstrap.yml -u $DEPLOY_USER --inventory /inventory --private-key /key.priv
