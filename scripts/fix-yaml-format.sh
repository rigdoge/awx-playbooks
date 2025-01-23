#!/bin/bash

# 修复行尾空格
find . -type f -name "*.yml" -exec sed -i 's/[[:space:]]*$//' {} +

# 确保文件末尾有换行符
find . -type f -name "*.yml" -exec sh -c '
  if [ -n "$(tail -c1 "$1")" ]; then
    echo "" >> "$1"
  fi
' sh {} \;

# 运行 yamllint 检查
yamllint .

# 运行 ansible-lint 检查
ansible-lint
