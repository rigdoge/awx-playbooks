# 架构设计文档

## 整体架构
```
                                    ┌─────────────┐
                                    │    AWX      │
                                    └─────────────┘
                                          │
                                          ▼
                                    ┌─────────────┐
                                    │  Ansible    │
                                    └─────────────┘
                                          │
                    ┌───────────────┬─────┴─────┬───────────────┐
                    ▼               ▼           ▼               ▼
            ┌─────────────┐ ┌─────────────┐ ┌─────────┐ ┌─────────────┐
            │  Docker     │ │ Kubernetes  │ │ 系统配置 │ │ 其他服务    │
            └─────────────┘ └─────────────┘ └─────────┘ └─────────────┘
```

## 部署架构
### Kubernetes 部署
- 使用 K3s 作为轻量级 Kubernetes 发行版
- 支持 ARM64 和 AMD64 架构
- 使用 NodePort 暴露服务
- 使用 hostPath 持久化存储

### Docker 部署
- 直接使用 Docker Engine
- 自动架构适配
- 端口映射到主机
- 数据卷持久化

## 组件说明

### RabbitMQ
- 版本: 3.13.7
- 端口:
  * AMQP: 5672
  * Management: 15672
- 配置:
  * 默认虚拟主机: /
  * 开发虚拟主机: /development
  * 管理插件已启用

### Nginx
- 版本: 1.25.3
- 端口: 80
- 配置:
  * 默认站点配置
  * 静态文件服务
  * 反向代理支持

### Prometheus Stack
- Prometheus 版本: 2.45.0
- Alertmanager 版本: 0.26.0
- Grafana 版本: 10.2.0
- 端口:
  * Prometheus: 9090
  * Alertmanager: 9093
  * Grafana: 3000

## 网络架构
### Kubernetes 网络
- 使用 NodePort 服务类型
- 端口范围: 30000-32767
- 集群内部通信使用 ClusterIP

### Docker 网络
- 使用 bridge 网络
- 端口直接映射到主机
- 容器间通信使用 Docker 网络

## 存储架构
### Kubernetes 存储
- 使用 hostPath 卷
- 数据目录: /opt/{service}/data
- 配置目录: /opt/{service}/config

### Docker 存储
- 使用 Docker volumes
- 数据目录映射到主机
- 配置文件直接挂载

## 安全架构
- 使用 RBAC 控制访问
- 默认最小权限原则
- 敏感信息使用环境变量
- 容器以非 root 用户运行
- 定期安全更新

## 监控架构
- Prometheus 收集指标
- Alertmanager 处理告警
- Grafana 可视化
- 节点导出器收集主机指标
- 自定义告警规则

## 日志架构
- 容器日志使用 json-file 驱动
- 系统日志使用 rsyslog
- 应用日志输出到 stdout/stderr
- 日志轮转策略
- 集中式日志收集 