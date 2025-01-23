# 开发规范文档

## 代码规范

### Ansible Playbook 规范
1. 命名规范
   - 使用小写字母和连字符
   - 清晰表达功能
   - 包含部署方式和架构信息
   ```
   install-rabbitmq-docker.yml
   install-rabbitmq-arm64.yml
   ```

2. 任务命名
   - 使用动词开头
   - 清晰描述任务目的
   - 包含必要的上下文
   ```yaml
   - name: Create RabbitMQ directories
   - name: Deploy RabbitMQ to K3s
   ```

3. 变量命名
   - 使用小写字母和下划线
   - 添加适当的前缀
   - 描述性命名
   ```yaml
   rabbitmq_version: 3.13.7
   nginx_port: 80
   ```

4. 目录结构
   ```
   playbooks/
   ├── kubernetes/
   │   ├── arm64/
   │   └── amd64/
   └── docker/
   ```

### YAML 格式规范
1. 缩进
   - 使用 2 个空格
   - 保持一致的缩进级别
   - 不使用 Tab

2. 列表格式
   ```yaml
   - name: Install packages
     apt:
       name:
         - package1
         - package2
       state: present
   ```

3. 字典格式
   ```yaml
   vars:
     app_name: myapp
     app_port: 8080
   ```

## Git 规范

### 分支管理
1. 主分支
   - main: 稳定版本
   - develop: 开发版本

2. 功能分支
   - feature/xxx: 新功能
   - bugfix/xxx: 错误修复
   - hotfix/xxx: 紧急修复

3. 版本分支
   - release/x.y.z: 发布准备

### 提交规范
1. 提交信息格式
   ```
   <type>(<scope>): <subject>

   <body>

   <footer>
   ```

2. Type 类型
   - feat: 新功能
   - fix: 修复
   - docs: 文档
   - style: 格式
   - refactor: 重构
   - test: 测试
   - chore: 构建

3. 示例
   ```
   feat(rabbitmq): add Docker deployment support

   Add Docker-based deployment option for RabbitMQ with:
   - Configuration management
   - Data persistence
   - User management

   Closes #123
   ```

## 测试规范

### Playbook 测试
1. 语法检查
   ```bash
   ansible-playbook --syntax-check playbook.yml
   ```

2. 预运行
   ```bash
   ansible-playbook --check playbook.yml
   ```

3. 幂等性测试
   - 多次运行结果一致
   - 检查 changed 状态

### 代码审查
1. 审查清单
   - 代码规范符合性
   - 安全性检查
   - 文档完整性
   - 测试覆盖率

2. 审查流程
   - 创建 Pull Request
   - 指定审查人
   - 解决反馈
   - 合并代码

## 文档规范

### README 要求
1. 基本信息
   - 项目描述
   - 功能特性
   - 技术要求

2. 使用说明
   - 安装步骤
   - 配置说明
   - 使用示例

3. 维护信息
   - 作者信息
   - 许可证
   - 贡献指南

### 注释规范
1. 代码注释
   ```yaml
   # 创建必要的目录结构
   - name: Create directories
     file:
       path: "{{ item }}"
       state: directory
   ```

2. 变量注释
   ```yaml
   vars:
     # RabbitMQ 版本号
     rabbitmq_version: 3.13.7
     # 管理界面端口
     management_port: 15672
   ```

## 安全规范

### 密码管理
1. 不在代码中硬编码
2. 使用环境变量
3. 使用 AWX 凭据

### 权限控制
1. 最小权限原则
2. 使用 sudo 时明确权限
3. 容器使用非 root 用户

### 网络安全
1. 限制端口暴露
2. 使用 TLS/SSL
3. 配置防火墙规则

## 版本管理

### 版本号规范
1. 语义化版本
   - 主版本号: 不兼容的 API 修改
   - 次版本号: 向下兼容的功能性新增
   - 修订号: 向下兼容的问题修正

2. 示例
   ```
   1.0.0: 首次发布
   1.1.0: 新增功能
   1.1.1: 错误修复
   ```

### 发布流程
1. 版本准备
   - 更新版本号
   - 更新文档
   - 更新 CHANGELOG

2. 代码审查
   - 完整性检查
   - 功能测试
   - 性能测试

3. 发布操作
   - 合并到主分支
   - 创建标签
   - 发布说明 