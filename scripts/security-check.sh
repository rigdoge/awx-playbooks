#!/bin/bash

# 检查文件权限
echo "检查文件权限..."
find . -type f -name "*.yml" ! -perm 644 -exec ls -l {} \;
find . -type f -name "*.sh" ! -perm 755 -exec ls -l {} \;

# 检查敏感信息
echo "检查敏感信息..."
grep -r "password:" .
grep -r "token:" .
grep -r "secret:" .

# 检查配置文件权限
echo "检查配置文件权限..."
find . -type f -name "*.conf" ! -perm 600 -exec ls -l {} \;
