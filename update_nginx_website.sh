#!/bin/bash

# 提示用户输入新的网址
read -p "请输入新的网址: " new_website

# 检查输入是否为空
if [ -z "$new_website" ]; then
  echo "输入的网址为空，未做任何更改。"
  exit 1
fi

# 使用sed命令将新的网址写入nginx.conf文件
sed -i "s|set \$website.*;|set \$website $new_website;|" /etc/nginx/nginx.conf

# 检查sed命令是否成功执行
if [ $? -eq 0 ]; then
  echo "网址已成功更新为: $new_website"
  
  # 重启Nginx
  systemctl restart nginx
  
  # 检查Nginx是否重启成功
  if [ $? -eq 0 ]; then
    echo "Nginx已成功重启。"
  else
    echo "重启Nginx时出错，请手动检查。"
  fi
  
else
  echo "更新网址时出错，请手动检查。"
fi

