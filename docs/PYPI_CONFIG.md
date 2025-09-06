# PyPI 发布配置指南

## 概述

本指南介绍如何配置和发布 `markdown-css` 项目到 PyPI (Python Package Index)。

## 前置要求

### 1. 安装发布工具
```bash
pip3 install twine
```

### 2. PyPI 账户
- 在 [PyPI](https://pypi.org/) 注册账户
- 在 [TestPyPI](https://test.pypi.org/) 注册测试账户（可选）

## 配置认证

### 方法一：使用 .pypirc 文件

在用户主目录创建 `.pypirc` 文件：

```bash
# 创建配置文件
touch ~/.pypirc
```

编辑 `~/.pypirc` 文件：

```ini
[distutils]
index-servers =
    pypi
    testpypi

[pypi]
repository = https://pypi.org/pypi
username = your_pypi_username
password = your_pypi_password

[testpypi]
repository = https://test.pypi.org/legacy/
username = your_testpypi_username
password = your_testpypi_password
```

### 方法二：使用环境变量

```bash
export TWINE_USERNAME=your_pypi_username
export TWINE_PASSWORD=your_pypi_password
```

### 方法三：使用 keyring（推荐）

```bash
# 配置 PyPI 认证
keyring set https://pypi.org/pypi your_pypi_username

# 配置 TestPyPI 认证
keyring set https://test.pypi.org/legacy/ your_testpypi_username
```

## 发布流程

### 1. 测试构建
```bash
# 清理并构建
make clean && make dist

# 检查分发包
twine check dist/*
```

### 2. 测试发布（推荐）
```bash
# 发布到 TestPyPI
twine upload --repository testpypi dist/*

# 测试安装
pip3 install --index-url https://test.pypi.org/simple/ markdown-css
```

### 3. 正式发布
```bash
# 发布到 PyPI
make release

# 或手动发布
twine upload dist/*
```

## 发布前检查清单

### ✅ 代码质量
- [ ] 所有测试通过 (`make test-all`)
- [ ] 代码格式正确
- [ ] 没有语法错误

### ✅ 文档完整性
- [ ] README.md 更新
- [ ] CHANGES.md 记录版本变更
- [ ] 文档语法正确

### ✅ 分发包质量
- [ ] 构建成功 (`make dist`)
- [ ] 分发包检查通过 (`twine check`)
- [ ] 安装测试通过

### ✅ 元数据正确性
- [ ] 版本号正确
- [ ] 依赖包列表完整
- [ ] 分类器设置正确

## 常见问题

### 1. 认证失败
**错误**: `HTTPError: 401 Client Error: Unauthorized`

**解决方案**:
```bash
# 检查认证配置
cat ~/.pypirc

# 重新配置认证
keyring set https://pypi.org/pypi your_username
```

### 2. 版本冲突
**错误**: `File already exists`

**解决方案**:
```bash
# 更新版本号
# 编辑 markdown_css/__init__.py
version = "0.0.9"

# 重新构建
make clean && make dist
```

### 3. 分发包验证失败
**错误**: `The distribution is not valid`

**解决方案**:
```bash
# 检查分发包
twine check dist/*

# 重新构建
make clean && make dist
```

## 自动化发布

### 使用 Makefile
```bash
# 完整发布流程
make release
```

### 使用 GitHub Actions（推荐）
创建 `.github/workflows/release.yml`:

```yaml
name: Release to PyPI

on:
  release:
    types: [published]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.8'
    - name: Install dependencies
      run: |
        pip install wheel setuptools twine
    - name: Build and publish
      env:
        TWINE_USERNAME: ${{ secrets.PYPI_USERNAME }}
        TWINE_PASSWORD: ${{ secrets.PYPI_PASSWORD }}
      run: |
        python setup.py sdist bdist_wheel
        twine upload dist/*
```

## 版本管理

### 语义化版本
- **主版本号**: 不兼容的API修改
- **次版本号**: 向下兼容的功能性新增
- **修订版本号**: 向下兼容的问题修正

### 版本更新流程
1. 修改 `markdown_css/__init__.py` 中的版本号
2. 更新 `CHANGES.md` 记录变更
3. 提交代码并创建 Git tag
4. 构建并发布分发包

## 安全建议

### 1. 使用 API Token
- 在 PyPI 账户设置中生成 API Token
- 使用 Token 而不是密码进行认证

### 2. 环境隔离
- 使用虚拟环境进行发布
- 不要在共享环境中存储认证信息

### 3. 定期更新
- 定期更新 twine 和 setuptools
- 检查安全公告

## 相关命令

| 命令 | 描述 |
|------|------|
| `twine check dist/*` | 检查分发包 |
| `twine upload dist/*` | 上传到 PyPI |
| `twine upload --repository testpypi dist/*` | 上传到 TestPyPI |
| `make release` | 完整发布流程 |

通过这些配置和流程，可以安全、可靠地将项目发布到 PyPI。 