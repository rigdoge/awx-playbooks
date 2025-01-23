# 运维文档

## 日常运维

### 系统监控
1. 资源监控
   - CPU 使用率
   - 内存使用率
   - 磁盘使用率
   - 网络流量

2. 服务监控
   - 服务状态
   - 端口可用性
   - 响应时间
   - 错误率

3. 日志监控
   - 系统日志
   - 应用日志
   - 审计日志
   - 安全日志

### 定期维护
1. 系统更新
   ```bash
   # Ubuntu
   apt update && apt upgrade -y
   
   # CentOS
   dnf update -y
   ```

2. 日志轮转
   ```bash
   # 检查日志大小
   du -sh /var/log/*
   
   # 手动触发轮转
   logrotate -f /etc/logrotate.conf
   ```

3. 磁盘清理
   ```bash
   # 清理旧日志
   find /var/log -type f -mtime +30 -delete
   
   # 清理 Docker 资源
   docker system prune -a
   ```

## 服务管理

### RabbitMQ 管理
1. 状态检查
   ```bash
   # Kubernetes
   kubectl get pods -l app=rabbitmq
   kubectl logs deployment/rabbitmq
   
   # Docker
   docker ps | grep rabbitmq
   docker logs rabbitmq
   ```

2. 用户管理
   ```bash
   # 添加用户
   rabbitmqctl add_user username password
   
   # 设置权限
   rabbitmqctl set_permissions -p vhost username ".*" ".*" ".*"
   ```

3. 性能优化
   - 调整内存限制
   - 配置连接数
   - 优化队列设置

### Nginx 管理
1. 配置检查
   ```bash
   # 语法检查
   nginx -t
   
   # 重新加载配置
   nginx -s reload
   ```

2. 访问日志分析
   ```bash
   # 查看访问量
   awk '{print $1}' access.log | sort | uniq -c | sort -nr
   
   # 查看响应时间
   awk '{print $NF}' access.log | sort -n
   ```

3. SSL 证书管理
   - 证书更新
   - 密钥备份
   - 配置更新

### Prometheus Stack 管理
1. 告警管理
   - 配置告警规则
   - 设置通知渠道
   - 处理告警事件

2. 数据管理
   - 数据保留策略
   - 存储空间管理
   - 备份恢复

3. Grafana 管理
   - 仪表板维护
   - 用户权限
   - 插件更新

## 故障处理

### 常见问题处理
1. 服务无法访问
   ```bash
   # 检查服务状态
   systemctl status service_name
   
   # 检查端口
   netstat -tulpn | grep PORT
   
   # 检查防火墙
   ufw status
   ```

2. 资源耗尽
   ```bash
   # 检查资源使用
   top
   df -h
   free -m
   
   # 清理资源
   docker system prune
   journalctl --vacuum-time=2d
   ```

3. 网络问题
   ```bash
   # 网络连通性
   ping host
   traceroute host
   
   # DNS 解析
   nslookup domain
   dig domain
   ```

### 应急响应
1. 服务降级
   - 关闭非核心功能
   - 限制访问流量
   - 启用备用系统

2. 数据恢复
   ```bash
   # 恢复配置
   tar -xzf config-backup.tar.gz -C /
   
   # 恢复数据
   tar -xzf data-backup.tar.gz -C /
   ```

3. 事件报告
   - 记录事件过程
   - 分析原因
   - 制定改进措施

## 安全维护

### 安全更新
1. 系统补丁
   ```bash
   # 安全更新
   apt update && apt upgrade -y
   
   # 内核更新
   apt dist-upgrade
   ```

2. 软件更新
   - Docker 镜像更新
   - 应用版本更新
   - 依赖包更新

3. 安全配置
   - 防火墙规则
   - 访问控制
   - SSL/TLS 配置

### 安全审计
1. 日志审计
   ```bash
   # 登录记录
   last
   
   # 失败登录
   faillog
   
   # 系统日志
   journalctl
   ```

2. 权限检查
   ```bash
   # 文件权限
   find / -type f -perm -4000
   
   # 用户权限
   getfacl path
   ```

3. 漏洞扫描
   - 系统漏洞
   - 应用漏洞
   - 配置漏洞

## 性能优化

### 系统优化
1. 内核参数
   ```bash
   # 文件描述符
   sysctl -w fs.file-max=65535
   
   # 网络优化
   sysctl -w net.core.somaxconn=65535
   ```

2. 资源限制
   ```bash
   # 修改限制
   ulimit -n 65535
   
   # 持久化配置
   echo "* soft nofile 65535" >> /etc/security/limits.conf
   ```

3. 磁盘优化
   - IO 调度
   - 文件系统选择
   - 挂载选项

### 应用优化
1. Docker 优化
   - 镜像层优化
   - 存储驱动选择
   - 网络模式选择

2. Kubernetes 优化
   - 资源限制
   - HPA 配置
   - 节点亲和性

3. 服务优化
   - 连接池设置
   - 缓存配置
   - 队列参数

## 备份策略

### 数据备份
1. 配置备份
   ```bash
   # 定期备份
   0 2 * * * tar -czf /backup/config-$(date +%Y%m%d).tar.gz /opt/*/config
   
   # 保留策略
   find /backup -name "config-*.tar.gz" -mtime +30 -delete
   ```

2. 数据备份
   ```bash
   # 定期备份
   0 3 * * * tar -czf /backup/data-$(date +%Y%m%d).tar.gz /opt/*/data
   
   # 保留策略
   find /backup -name "data-*.tar.gz" -mtime +30 -delete
   ```

3. 备份验证
   - 完整性检查
   - 恢复测试
   - 性能影响评估

### 灾难恢复
1. 恢复流程
   - 环境准备
   - 数据恢复
   - 服务启动
   - 验证检查

2. 演练计划
   - 定期演练
   - 流程优化
   - 文档更新

3. 应急预案
   - 人员分工
   - 联系方式
   - 处理流程 