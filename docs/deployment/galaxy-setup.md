# Ansible Galaxy 配置和使用指南

## 配置 Galaxy 服务器
1. 在 AWX 界面中导航到：Settings → Jobs
2. 添加以下配置：
   ```yaml
   ANSIBLE_GALAXY_SERVER_LIST:
     - https://galaxy.ansible.com
   ```

## 使用 Galaxy 角色
1. 创建 requirements.yml 文件：
   ```yaml
   ---
   roles:
     # 从 Galaxy 安装 nginx 角色
     - src: geerlingguy.nginx
       version: 3.1.0

     # 从 GitHub 安装 rabbitmq 角色
     - src: rabbitmq
       name: rabbitmq
       scm: git
       version: main
       repo: https://github.com/cloudalchemy/ansible-rabbitmq.git

   collections:
     # 安装 community.general 集合
     - name: community.general
       version: "7.5.0"

     # 安装 kubernetes.core 集合
     - name: kubernetes.core
       version: "2.4.0"
   ```

2. 在项目中使用角色：
   ```yaml
   ---
   - name: 安装 Nginx
     hosts: web_servers
     roles:
       - geerlingguy.nginx

   - name: 安装 RabbitMQ
     hosts: mq_servers
     roles:
       - rabbitmq
   ```

## 在 AWX 中使用 Galaxy 角色
1. 创建项目时启用 "更新修订版本时更新 Galaxy/Collections"
2. 在作业模板中：
   - 选择包含 requirements.yml 的项目
   - 选择包含角色使用的 playbook
   - 确保有适当的清单和凭据

## 最佳实践
1. 版本控制：
   - 始终指定角色和集合的具体版本
   - 避免使用 latest 标签

2. 安全性：
   - 审查第三方角色的代码
   - 使用可信任的作者和维护良好的角色
   - 定期更新角色版本以获取安全修复

3. 测试：
   - 在开发环境中测试新角色
   - 验证角色的幂等性
   - 检查角色的兼容性

4. 文档：
   - 记录使用的外部角色和版本
   - 保存角色的配置示例
   - 记录任何修改或自定义

## 常用 Galaxy 角色推荐
1. 系统基础设施：
   - geerlingguy.docker
   - geerlingguy.nginx
   - geerlingguy.mysql

2. 监控和日志：
   - cloudalchemy.prometheus
   - cloudalchemy.grafana
   - geerlingguy.elasticsearch

3. 消息队列：
   - cloudalchemy.rabbitmq
   - idealista.rabbitmq_role

4. 安全相关：
   - geerlingguy.security
   - dev-sec.os-hardening

## 故障排除
1. 角色下载失败：
   - 检查网络连接
   - 验证 requirements.yml 语法
   - 确认角色版本存在

2. 角色执行失败：
   - 检查角色文档中的依赖关系
   - 验证变量配置
   - 查看角色的兼容性要求
