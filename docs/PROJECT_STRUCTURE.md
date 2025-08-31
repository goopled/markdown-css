# 项目结构说明

## 目录结构

```
markdown-css/
├── README.md                 # 项目主要说明文档（英文）
├── README-zh_cn.md          # 项目中文说明文档
├── CHANGES.md               # 项目变更日志
├── LICENSE                  # 开源许可证
├── requirements.txt         # Python依赖包列表
├── setup.py                # 安装配置文件
├── Makefile                # 项目构建和测试自动化脚本
├── MANIFEST.in             # 分发包文件清单
├── desc.png                # 项目描述图片
│
├── markdown_css/           # 核心代码目录
│   ├── __init__.py         # 主模块
│   └── bin/                # 命令行工具
│       └── markdown-css    # 主命令行脚本
│
├── themes/                 # 主题样式目录
│   ├── markdown.html       # 示例HTML文件
│   ├── apollo.css          # Apollo主题
│   ├── erye.css           # Erye主题
│   ├── infoq.css          # InfoQ主题
│   ├── less.css           # Less主题
│   ├── list-writing.css   # 列表写作主题
│   ├── ocean.css          # Ocean主题
│   ├── sanyuesha.css      # 三月沙主题
│   ├── simple.css         # 简洁主题
│   ├── style.css          # 默认主题
│   ├── typing.css         # 打字机主题
│   ├── wecatch-code.css   # WeCatch代码主题
│   ├── wecatch.css        # WeCatch主题
│   └── xiaolai.css        # 小来主题
│
├── docs/                   # 文档目录
│   ├── MAKEFILE_USAGE.md   # Makefile使用指南
│   ├── DOCUMENTATION.md    # 文档说明
│   └── PROJECT_STRUCTURE.md # 项目结构说明（本文件）
│
├── tests/                  # 测试目录
│   ├── test_python3_compatibility.py  # Python3兼容性测试
│   ├── test_themes.py      # 主题测试脚本
│   └── generate_test_report.py        # 测试报告生成脚本
│
├── output/                 # 输出目录
│   ├── test_output/        # 测试输出
│   │   ├── test_*.html     # 各主题测试结果
│   │   ├── index.html      # 测试结果索引页面
│   │   └── TEST_REPORT.md  # 测试报告
│   └── demo_output/        # 演示输出
│       └── demo.html       # 演示文件
│
├── build/                  # 构建临时目录（自动生成）
├── dist/                   # 分发包目录（自动生成）
├── markdown_css.egg-info/  # 安装信息（自动生成）
└── __pycache__/           # Python缓存（自动生成）
```

## 目录说明

### 📁 核心目录

- **`markdown_css/`** - 项目核心代码
  - 包含主要的Python模块和命令行工具
  - 这是项目的核心功能实现

- **`themes/`** - 主题样式目录
  - 包含所有可用的CSS主题样式
  - 提供示例HTML文件用于测试

### 📁 文档目录

- **`docs/`** - 项目文档
  - 包含开发指南、使用说明等文档
  - 与代码分离，便于维护

### 📁 测试目录

- **`tests/`** - 测试脚本
  - 包含所有测试相关的Python脚本
  - 集中管理，便于运行和维护

### 📁 输出目录

- **`output/`** - 所有输出文件
  - `test_output/` - 测试结果
  - `demo_output/` - 演示文件
  - 统一管理，避免根目录混乱

### 📁 构建目录

- **`build/`** - 构建临时文件
- **`dist/`** - 分发包文件
- **`markdown_css.egg-info/`** - 安装信息
- **`__pycache__/`** - Python缓存

## 文件分类

### 🔧 配置文件
- `setup.py` - 项目安装配置
- `requirements.txt` - 依赖包列表
- `Makefile` - 构建自动化脚本
- `MANIFEST.in` - 分发包文件清单

### 📖 文档文件
- `README.md` - 项目说明（英文）
- `README-zh_cn.md` - 项目说明（中文）
- `CHANGES.md` - 变更日志
- `docs/` - 详细文档

### 🧪 测试文件
- `tests/` - 测试脚本目录
- `output/test_output/` - 测试结果

### 🎨 主题文件
- `themes/` - 所有主题样式

### 🚀 核心代码
- `markdown_css/` - 主要功能实现

## 设计原则

### 1. 分离关注点
- 代码、文档、测试、输出分别放在不同目录
- 便于维护和查找

### 2. 清晰的层次结构
- 根目录保持简洁，只包含核心文件
- 子目录按功能分类

### 3. 自动化友好
- 输出文件统一放在output目录
- 便于Makefile自动化管理

### 4. 用户友好
- 主题文件集中管理，便于用户选择
- 文档结构清晰，便于查阅

## 维护建议

1. **新增主题** - 放在 `themes/` 目录
2. **新增测试** - 放在 `tests/` 目录
3. **新增文档** - 放在 `docs/` 目录
4. **输出文件** - 统一放在 `output/` 目录
5. **定期清理** - 使用 `make clean` 清理临时文件

这样的结构使项目更加专业、整洁，便于维护和扩展。 