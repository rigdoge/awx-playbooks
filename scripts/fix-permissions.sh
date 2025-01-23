#!/bin/bash

# 设置配置文件权限
find . -type f -name "*.yml" -exec chmod 644 {} \;
find . -type f -name "*.yaml" -exec chmod 644 {} \;

# 设置脚本文件权限
find ./scripts -type f -name "*.sh" -exec chmod 755 {} \;

# 设置目录权限
find . -type d -exec chmod 755 {} \;

echo "文件权限已修复" 