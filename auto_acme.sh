#!/bin/bash

# 提示用户输入域名
read -p "请输入域名: " domain_name

# 第一条命令
curl https://get.acme.sh | sh

# 暂停2秒
sleep 2

# 第二条命令
alias acme.sh=~/.acme.sh/acme.sh

# 暂停2秒
sleep 2

# 第三条命令
~/.acme.sh/acme.sh --upgrade --auto-upgrade

# 暂停2秒
sleep 2

# 第四条命令
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt

# 暂停2秒
sleep 2

# 第五条命令
~/.acme.sh/acme.sh --issue -d $domain_name --standalone --keylength ec-256

# 暂停2秒
sleep 2

# 第六条命令
~/.acme.sh/acme.sh --install-cert -d $domain_name --ecc \
--fullchain-file /etc/ssl/private/fullchain.cer \
--key-file /etc/ssl/private/private.key

# 暂停2秒
sleep 2

# 第七条命令
chown -R nobody:nogroup /etc/ssl/private

# 暂停2秒
sleep 2

# 第八条命令
~/.acme.sh/acme.sh --renew -d $domain_name --force --ecc

