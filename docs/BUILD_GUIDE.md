# 构建指南

## 概述

本指南介绍如何构建和发布 `markdown-css` 项目。

## 环境要求

### 基本要求
- Python 3.6+
- pip3
- setuptools
- wheel

### 安装构建依赖
```bash
pip3 install wheel setuptools
```

## 构建流程

### 1. 开发环境设置
```bash
# 安装依赖
make install-deps

# 安装项目
make install

# 验证安装
make validate
```

### 2. 运行测试
```bash
# 运行所有测试
make test-all

# 快速测试
make quick-test

# 生成测试报告
make report
```

### 3. 构建分发包
```bash
# 清理并构建
make clean && make dist
```

这将生成以下文件：
- `dist/markdown-css-0.0.8.tar.gz` - 源码分发包
- `dist/markdown_css-0.0.8-py3-none-any.whl` - Wheel分发包

### 4. 发布到PyPI（可选）
```bash
# 发布到PyPI
make release
```

## 构建配置

### setup.py 配置
项目使用 `setup.py` 进行构建配置，主要设置包括：

- **基本信息**: 项目名称、版本、作者等
- **依赖管理**: 通过 `install_requires` 指定依赖包
- **Python版本**: 要求 Python 3.6+
- **分类器**: 指定项目类型、许可证、支持的Python版本等

### MANIFEST.in
控制分发包中包含的文件：
```
include README.md
include README-zh_cn.md
include CHANGES.md
include LICENSE
include requirements.txt
recursive-include themes *.css *.html
```

## 版本管理

### 版本号格式
使用语义化版本号：`主版本.次版本.修订版本`

### 更新版本
1. 修改 `markdown_css/__init__.py` 中的版本号
2. 更新 `CHANGES.md` 记录变更
3. 重新构建分发包

## 分发包内容

### 源码包 (.tar.gz)
包含项目的完整源代码和文档：
- Python源代码
- 主题样式文件
- 文档文件
- 配置文件

### Wheel包 (.whl)
预编译的分发包，安装更快：
- 编译后的Python字节码
- 元数据信息
- 依赖关系

## 安装测试

### 本地安装测试
```bash
# 从源码安装
pip3 install dist/markdown_css-0.0.8-py3-none-any.whl

# 测试安装
markdown-css --help
```

### 虚拟环境测试
```bash
# 创建虚拟环境
python3 -m venv test_env
source test_env/bin/activate

# 安装并测试
pip3 install dist/markdown_css-0.0.8-py3-none-any.whl
markdown-css --help
```

## 常见问题

### 1. bdist_wheel 错误
**错误**: `error: invalid command 'bdist_wheel'`

**解决方案**:
```bash
pip3 install wheel
```

### 2. 依赖包冲突
**错误**: 依赖包版本冲突

**解决方案**:
```bash
# 检查依赖
make check-deps

# 重新安装依赖
make install-deps
```

### 3. 权限错误
**错误**: 安装时权限不足

**解决方案**:
```bash
# 使用用户安装
pip3 install --user dist/markdown_css-0.0.8-py3-none-any.whl

# 或使用虚拟环境
python3 -m venv venv
source venv/bin/activate
pip3 install dist/markdown_css-0.0.8-py3-none-any.whl
```

## 自动化构建

### CI/CD 流程
```bash
# 完整的CI流程
make ci
```

包括：
- 依赖检查
- 代码测试
- 报告生成

### 发布流程
```bash
# 完整的发布流程
make clean && make test-all && make dist
```

## 最佳实践

### 1. 构建前检查
- 确保所有测试通过
- 检查代码质量
- 验证文档完整性

### 2. 版本管理
- 遵循语义化版本
- 及时更新变更日志
- 保持版本号一致性

### 3. 分发包质量
- 测试分发包安装
- 验证功能完整性
- 检查文件完整性

### 4. 发布前验证
- 在测试环境验证
- 检查PyPI元数据
- 验证下载链接

## 相关命令

| 命令 | 描述 |
|------|------|
| `make dist` | 构建分发包 |
| `make clean` | 清理构建文件 |
| `make test-all` | 运行所有测试 |
| `make install` | 安装项目 |
| `make validate` | 验证安装 |
| `make release` | 发布到PyPI |

通过这些步骤，可以确保构建出高质量的分发包，为用户提供良好的安装体验。 