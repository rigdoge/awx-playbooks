# 部署文档

## 环境要求

### 硬件要求
- CPU: 2核心以上
- 内存: 4GB以上
- 磁盘: 20GB以上
- 网络: 1Gbps

### 软件要求
- 操作系统: Ubuntu 20.04+ / CentOS 8+
- Python 3.8+
- AWX 21.x.x
- Ansible 2.9+
- Docker 20.x+
- Kubernetes 1.20+ (K3s)

## 前置准备

### 系统配置
1. 更新系统
```bash
apt update && apt upgrade -y  # Ubuntu
# 或
dnf update -y  # CentOS
```

2. 安装基础包
```bash
apt install -y python3 python3-pip git curl  # Ubuntu
# 或
dnf install -y python3 python3-pip git curl  # CentOS
```

### AWX 配置
1. 创建项目
   - 名称: AWX Playbooks
   - SCM 类型: Git
   - SCM URL: https://github.com/your-username/awx-playbooks.git
   - 更新选项: 清理、更新时删除

2. 创建清单
   - 名称: Local Inventory
   - 添加主机: localhost
   - 变量:
     ```yaml
     ansible_connection: local
     ```

3. 创建凭据
   - 类型: Machine
   - 用户名: root/sudo用户
   - 权限提升方法: sudo

## 部署流程

### Kubernetes 部署 (ARM64)
1. 创建作业模板
   - 名称: Install RabbitMQ ARM64
   - 作业类型: Run
   - 清单: Local Inventory
   - 项目: AWX Playbooks
   - Playbook: install-rabbitmq-arm64.yml
   - 凭据: Machine
   
2. 执行作业
   - 点击启动
   - 监控输出
   - 验证服务

### Kubernetes 部署 (AMD64)
1. 创建作业模板
   - 名称: Install RabbitMQ AMD64
   - 作业类型: Run
   - 清单: Local Inventory
   - 项目: AWX Playbooks
   - Playbook: install-rabbitmq-amd64.yml
   - 凭据: Machine

2. 执行作业
   - 点击启动
   - 监控输出
   - 验证服务

### Docker 部署
1. 创建作业模板
   - 名称: Install RabbitMQ Docker
   - 作业类型: Run
   - 清单: Local Inventory
   - 项目: AWX Playbooks
   - Playbook: install-rabbitmq-docker.yml
   - 凭据: Machine

2. 执行作业
   - 点击启动
   - 监控输出
   - 验证服务

## 验证步骤

### RabbitMQ
1. 访问管理界面
   - Kubernetes: http://YOUR_SERVER_IP:31672
   - Docker: http://YOUR_SERVER_IP:15672
   - 默认凭据: admin/admin123

2. 验证 AMQP 连接
   - Kubernetes: YOUR_SERVER_IP:30672
   - Docker: YOUR_SERVER_IP:5672

### Nginx
1. 访问默认页面
   - Kubernetes: http://YOUR_SERVER_IP:30080
   - Docker: http://YOUR_SERVER_IP:80

### Prometheus Stack
1. 访问 Prometheus
   - Kubernetes: http://YOUR_SERVER_IP:30090
   - Docker: http://YOUR_SERVER_IP:9090

2. 访问 Grafana
   - Kubernetes: http://YOUR_SERVER_IP:30300
   - Docker: http://YOUR_SERVER_IP:3000
   - 默认凭据: admin/admin123

## 故障排除

### 常见问题
1. 端口冲突
   - 检查端口占用
   - 修改服务端口

2. 权限问题
   - 确认 sudo 权限
   - 检查目录权限

3. 网络问题
   - 检查防火墙规则
   - 验证网络连接

### 日志查看
1. Kubernetes 日志
```bash
kubectl logs -f deployment/服务名
```

2. Docker 日志
```bash
docker logs -f 容器名
```

3. AWX 作业日志
   - 查看作业详情
   - 下载作业输出

## 备份恢复

### 数据备份
1. 配置文件
```bash
tar -czf config-backup.tar.gz /opt/*/config
```

2. 数据目录
```bash
tar -czf data-backup.tar.gz /opt/*/data
```

### 数据恢复
1. 解压备份
```bash
tar -xzf config-backup.tar.gz -C /
tar -xzf data-backup.tar.gz -C /
```

2. 重启服务
   - 执行相应的安装 playbook
   - 验证服务状态 