#!/bin/bash

echo "Installing development tools..."

# 检查包管理器
if command -v brew &> /dev/null; then
    echo "Using Homebrew..."
    brew update
    brew install python3 git pre-commit yamllint
    brew install ansible-lint
elif command -v apt-get &> /dev/null; then
    echo "Using apt-get..."
    PKG_MANAGER="apt-get"
    sudo $PKG_MANAGER update
    sudo $PKG_MANAGER install -y python3-pip git
    pip3 install --user ansible-lint yamllint pre-commit
elif command -v yum &> /dev/null; then
    echo "Using yum..."
    PKG_MANAGER="yum"
    sudo $PKG_MANAGER update
    sudo $PKG_MANAGER install -y python3-pip git
    pip3 install --user ansible-lint yamllint pre-commit
else
    echo "No supported package manager found"
    exit 1
fi

# 安装 pre-commit hooks
echo "Setting up pre-commit hooks..."
cat > .pre-commit-config.yaml << 'EOF'
repos:
- repo: https://github.com/ansible/ansible-lint
  rev: v6.22.1
  hooks:
    - id: ansible-lint
      files: \.(yaml|yml)$

- repo: https://github.com/adrienverge/yamllint
  rev: v1.33.0
  hooks:
    - id: yamllint
      files: \.(yaml|yml)$
      types: [file, yaml]
      entry: yamllint
      args: [-c=.yamllint]

- repo: https://github.com/pre-commit/pre-commit-hooks
  rev: v4.5.0
  hooks:
    - id: trailing-whitespace
    - id: end-of-file-fixer
    - id: check-yaml
    - id: check-added-large-files
EOF

# 创建 yamllint 配置文件
echo "Creating YAML lint configuration..."
cat > .yamllint << 'EOF'
extends: default

rules:
  line-length:
    max: 120
    level: warning
  document-start: disable
  truthy:
    allowed-values: ['true', 'false', 'yes', 'no']
EOF

# 初始化 pre-commit
pre-commit install

echo "Creating ansible-lint configuration..."
cat > .ansible-lint << 'EOF'
exclude_paths:
  - .git/
  - .github/
  - scripts/

skip_list:
  - '204'  # Lines should be no longer than 120 chars
  - '301'  # Commands should not change things if nothing needs doing
  - '303'  # Using command rather than module
  - '306'  # Shells that use pipes should set the pipefail option

warn_list:
  - '208'  # File permissions unset or incorrect
  - '503'  # Tasks that run when changed should likely be handlers
EOF

# 设置文件权限
chmod 755 scripts/install-dev-tools.sh

echo "Development tools installation completed!"
echo "Please run 'pre-commit run --all-files' to check existing files" 