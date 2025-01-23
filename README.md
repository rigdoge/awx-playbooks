# AWX Playbooks Project

## 项目概述
本项目包含一系列用于自动化部署和管理各种服务的 Ansible playbooks。

## 目录结构
```
project_root/
├── docs/                    # 文档目录
│   ├── architecture/       # 架构设计文档
│   ├── deployment/        # 部署文档
│   ├── development/      # 开发规范文档
│   └── operations/       # 运维文档
├── scripts/               # 脚本目录
├── playbooks/            # Ansible playbooks
└── README.md            # 项目说明
```

## 技术栈
- AWX/Ansible: 自动化配置管理
- Docker: 容器化部署
- Kubernetes: 容器编排
- Prometheus + Grafana: 监控系统
- RabbitMQ: 消息队列
- Nginx: Web服务器

## 环境要求
- AWX 21.x.x
- Ansible 2.9+
- Python 3.8+
- Docker 20.x+
- Kubernetes 1.20+

## 快速开始
1. 克隆仓库
```bash
git clone https://github.com/your-username/awx-playbooks.git
cd awx-playbooks
```

2. 导入 Playbooks 到 AWX
- 在 AWX 中创建新项目
- 配置 Git 仓库 URL
- 同步项目

3. 创建作业模板
- 选择相应的 playbook
- 配置清单
- 配置凭据

## 可用的 Playbooks

### Kubernetes 部署
- install-rabbitmq-arm64.yml
- install-rabbitmq-amd64.yml
- uninstall-rabbitmq-arm64.yml
- uninstall-rabbitmq-amd64.yml
- install-nginx-arm64.yml
- install-nginx-amd64.yml
- uninstall-nginx-arm64.yml
- uninstall-nginx-amd64.yml
- install-prometheus-arm64.yml
- install-prometheus-amd64.yml
- uninstall-prometheus-arm64.yml
- uninstall-prometheus-amd64.yml

### Docker 部署
- install-rabbitmq-docker.yml
- uninstall-rabbitmq-docker.yml
- install-nginx-docker.yml
- uninstall-nginx-docker.yml
- install-prometheus-docker.yml
- uninstall-prometheus-docker.yml

## 开发规范
- 遵循 Ansible 最佳实践
- 使用清晰的命名约定
- 提供完整的文档
- 包含错误处理
- 添加适当的注释

## 贡献指南
1. Fork 项目
2. 创建功能分支
3. 提交更改
4. 推送到分支
5. 创建 Pull Request

## 版本控制
- 使用语义化版本
- 主分支保护
- 代码审查要求
- 自动化测试

## 维护者
- 您的姓名 <your.email@example.com>

## 许可证
MIT License