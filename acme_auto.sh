#!/bin/bash

# 提示用户输入域名
read -p "请输入域名: " domain_name

# 定义函数来执行命令并等待2秒
run_command() {
  echo "正在执行命令: $1"
  $1
  sleep 2
}

# 第一条命令
run_command "curl https://get.acme.sh | sh"

# 第二条命令
run_command "alias acme.sh=~/.acme.sh/acme.sh"

# 第三条命令
run_command "~/.acme.sh/acme.sh --upgrade --auto-upgrade"

# 第四条命令
run_command "~/.acme.sh/acme.sh --set-default-ca --server letsencrypt"

# 第五条命令
run_command "~/.acme.sh/acme.sh --issue -d $domain_name --standalone --keylength ec-256"

# 第六条命令 (已更新)
run_command "~/.acme.sh/acme.sh --install-cert -d $domain_name --ecc \
--fullchain-file /etc/ssl/private/fullchain.cer \
--key-file /etc/ssl/private/private.key"

# 第七条命令
run_command "chown -R nobody:nogroup /etc/ssl/private"

# 第八条命令
run_command "~/.acme.sh/acme.sh --renew -d $domain_name --force --ecc"

