# AWX 中使用 Ansible Galaxy 角色指南

## 前置准备

1. 配置 Galaxy 服务器
```yaml
# 在 AWX 设置 → 作业 中配置
ANSIBLE_GALAXY_SERVER_LIST:
  - https://galaxy.ansible.com
```

2. 确保 requirements.yml 文件已添加到项目中
```yaml
roles:
  - src: geerlingguy.nginx
    version: 3.1.0
  - src: geerlingguy.mysql
    version: 3.3.2
```

## 在 AWX 中配置项目

1. 创建项目
   - 导航到：项目 → 添加
   - 源码管理类型：Git
   - 源码管理 URL：你的仓库地址
   - 更新修订版本时更新 Galaxy/Collections：启用
   - SCM 更新选项：清理、更新时删除

2. 创建清单
   - 导航到：清单 → 添加
   - 添加以下主机组：
     - web_servers：用于 Nginx
     - db_servers：用于 Percona
     - mq_servers：用于 RabbitMQ

3. 创建凭据
   - 导航到：凭据 → 添加
   - 添加 SSH 凭据用于连接目标服务器
   - 添加 Git 凭据用于访问代码仓库

## 创建作业模板

1. 基础设置
   - 导航到：模板 → 添加
   - 名称：安装服务
   - 作业类型：运行
   - 清单：选择之前创建的清单
   - 项目：选择之前创建的项目
   - Playbook：playbooks/install-services.yml
   - 凭据：选择 SSH 凭据

2. 高级设置
   - 特权提升：启用
   - 特权提升方法：sudo
   - 作业标签：可选择特定标签运行部分任务

## 运行作业

1. 启动作业模板
   - 点击运行按钮
   - AWX 会自动：
     - 更新项目代码
     - 安装/更新 Galaxy 角色
     - 执行 playbook

2. 监控作业执行
   - 查看实时输出
   - 检查任务状态
   - 查看详细日志

## 故障排除

1. Galaxy 角色安装失败
   - 检查网络连接
   - 验证角色版本是否存在
   - 检查 requirements.yml 语法

2. Playbook 执行失败
   - 检查目标主机连接
   - 验证权限设置
   - 查看详细错误信息

## 最佳实践

1. 版本控制
   - 始终指定具体的角色版本
   - 定期更新角色版本以获取安全修复
   - 在测试环境验证新版本

2. 安全性
   - 使用加密存储敏感变量
   - 定期更新密码
   - 限制角色权限

3. 文档
   - 记录所使用的角色和版本
   - 记录自定义的变量配置
   - 保存成功的配置示例
