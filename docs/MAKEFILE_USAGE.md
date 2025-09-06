# Makefile 使用指南

## 概述

这个Makefile为 `markdown-css` 项目提供了完整的构建、测试、部署和开发工具链，支持Python3环境。

## 快速开始

### 查看帮助
```bash
make help
```

### 开发环境设置
```bash
make dev-setup
```

### 运行所有测试
```bash
make test-all
```

## 主要功能

### 🔧 安装和依赖管理

| 命令 | 描述 | 示例 |
|------|------|------|
| `make install-deps` | 安装依赖包 | `make install-deps` |
| `make install` | 安装包到当前环境 | `make install` |
| `make check-deps` | 检查依赖包 | `make check-deps` |

### 🧪 测试功能

| 命令 | 描述 | 示例 |
|------|------|------|
| `make test` | 运行Python3兼容性测试 | `make test` |
| `make test-themes` | 测试所有主题样式 | `make test-themes` |
| `make test-all` | 运行所有测试 | `make test-all` |
| `make test-single` | 测试单个主题 | `make test-single THEME=simple` |
| `make quick-test` | 快速测试(simple主题) | `make quick-test` |

### 📊 报告和演示

| 命令 | 描述 | 示例 |
|------|------|------|
| `make report` | 生成测试报告 | `make report` |
| `make open-report` | 在浏览器中打开报告 | `make open-report` |
| `make demo` | 运行演示 | `make demo` |
| `make demo-open` | 运行演示并打开浏览器 | `make demo-open` |
| `make list-themes` | 列出所有主题 | `make list-themes` |

### 🏗️ 构建和发布

| 命令 | 描述 | 示例 |
|------|------|------|
| `make dist` | 构建分发包 | `make dist` |
| `make release` | 发布到PyPI | `make release` |

### 🧹 清理功能

| 命令 | 描述 | 示例 |
|------|------|------|
| `make clean` | 清理所有文件 | `make clean` |
| `make clean-build` | 清理构建文件 | `make clean-build` |
| `make clean-pyc` | 清理Python缓存 | `make clean-pyc` |
| `make clean-test` | 清理测试文件 | `make clean-test` |
| `make clean-output` | 清理输出文件 | `make clean-output` |

### 🔍 代码质量

| 命令 | 描述 | 示例 |
|------|------|------|
| `make format` | 格式化代码 | `make format` |
| `make lint` | 代码检查 | `make lint` |
| `make check` | 完整检查 | `make check` |

### ℹ️ 信息显示

| 命令 | 描述 | 示例 |
|------|------|------|
| `make info` | 显示项目信息 | `make info` |
| `make version` | 显示版本 | `make version` |
| `make validate` | 验证安装 | `make validate` |

## 工作流程

### 开发工作流程

1. **设置开发环境**
   ```bash
   make dev-setup
   ```

2. **运行测试**
   ```bash
   make test-all
   ```

3. **生成报告**
   ```bash
   make report
   ```

4. **查看结果**
   ```bash
   make open-report
   ```

### CI/CD工作流程

```bash
make ci
```

这个命令会执行：
- 检查依赖包
- 运行所有测试
- 生成测试报告

### 发布工作流程

1. **构建包**
   ```bash
   make dist
   ```

2. **发布到PyPI**
   ```bash
   make release
   ```

## 高级用法

### 测试特定主题

```bash
# 测试simple主题
make test-single THEME=simple

# 测试ocean主题
make test-single THEME=ocean

# 测试wecatch主题
make test-single THEME=wecatch
```

### 自定义Python版本

如果需要使用不同的Python版本，可以设置环境变量：

```bash
# 使用Python3.9
PYTHON=python3.9 make test-all

# 使用Python3.10
PYTHON=python3.10 make test-all
```

### 并行测试

对于大型项目，可以使用并行测试：

```bash
# 使用4个进程并行测试
make -j4 test-themes
```

## 输出文件说明

### 测试输出

- `test_output/` - 测试结果目录
  - `test_*.html` - 各主题的测试输出
  - `TEST_REPORT.md` - 详细测试报告
  - `index.html` - 测试结果索引页面

### 演示输出

- `demo_output/` - 演示文件目录
  - `demo.html` - 演示文件

### 构建输出

- `dist/` - 分发包目录
  - `*.tar.gz` - 源码分发包
  - `*.whl` - Wheel分发包

## 环境要求

- Python 3.6+
- pip3
- 可选：black (代码格式化)
- 可选：flake8 (代码检查)

## 故障排除

### 常见问题

1. **权限错误**
   ```bash
   # 使用sudo安装依赖
   sudo make install-deps
   ```

2. **Python版本问题**
   ```bash
   # 检查Python版本
   python3 --version
   
   # 使用特定版本
   PYTHON=python3.8 make test
   ```

3. **依赖包问题**
   ```bash
   # 重新安装依赖
   make clean
   make install-deps
   ```

4. **测试失败**
   ```bash
   # 清理并重新测试
   make clean-output
   make test-all
   ```

### 调试模式

启用详细输出：

```bash
# 显示详细命令
make -n test-all

# 显示所有输出
make -d test-all
```

## 最佳实践

1. **开发前**
   ```bash
   make dev-setup
   make validate
   ```

2. **提交前**
   ```bash
   make check
   make test-all
   ```

3. **发布前**
   ```bash
   make ci
   make dist
   ```

4. **定期维护**
   ```bash
   make clean
   make install-deps
   make test-all
   ```

## 扩展功能

### 添加新的Makefile目标

在Makefile中添加新目标：

```makefile
new-target: ## 新目标描述
	@echo "$(YELLOW)执行新目标...$(NC)"
	@your-command
	@echo "$(GREEN)新目标完成$(NC)"
```

### 自定义颜色

修改颜色定义：

```makefile
# 自定义颜色
PURPLE := \033[0;35m
CYAN := \033[0;36m
```

## 总结

这个Makefile提供了完整的项目管理和自动化工具，支持：

- ✅ 依赖管理
- ✅ 测试自动化
- ✅ 报告生成
- ✅ 构建发布
- ✅ 代码质量检查
- ✅ 开发环境设置

使用这些命令可以大大提高开发效率和项目质量！ 