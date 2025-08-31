.PHONY: help clean clean-build clean-pyc clean-test clean-output install test test-all test-themes report dist release version check-deps

# 默认目标
.DEFAULT_GOAL := help

# Python版本
PYTHON := python3
PIP := pip3

# 项目信息
PROJECT_NAME := markdown-css
VERSION := $(shell $(PYTHON) -c "from markdown_css import version; print(version)")

# 颜色定义
GREEN := \033[0;32m
YELLOW := \033[1;33m
RED := \033[0;31m
BLUE := \033[0;34m
NC := \033[0m # No Color

# 帮助信息
define PRINT_HELP_PYSCRIPT
import re, sys

for line in sys.stdin:
	match = re.match(r'^([a-zA-Z_-]+):.*?## (.*)$$', line)
	if match:
		target, help = match.groups()
		print("%-20s %s" % (target, help))
endef
export PRINT_HELP_PYSCRIPT

help: ## 显示帮助信息
	@echo "$(BLUE)$(PROJECT_NAME) Makefile$(NC)"
	@echo "$(BLUE)版本: $(VERSION)$(NC)"
	@echo ""
	@$(PYTHON) -c "$$PRINT_HELP_PYSCRIPT" < $(MAKEFILE_LIST)

version: ## 显示项目版本
	@echo "$(GREEN)版本: $(VERSION)$(NC)"

check-deps: ## 检查依赖包
	@echo "$(YELLOW)检查依赖包...$(NC)"
	@$(PIP) check
	@echo "$(GREEN)依赖包检查完成$(NC)"

install-deps: ## 安装依赖包
	@echo "$(YELLOW)安装依赖包...$(NC)"
	@$(PIP) install -r requirements.txt
	@echo "$(GREEN)依赖包安装完成$(NC)"

install: clean ## 安装包到当前Python环境
	@echo "$(YELLOW)安装 $(PROJECT_NAME)...$(NC)"
	@$(PYTHON) setup.py install
	@echo "$(GREEN)安装完成$(NC)"

test: ## 运行Python3兼容性测试
	@echo "$(YELLOW)运行Python3兼容性测试...$(NC)"
	@$(PYTHON) tests/test_python3_compatibility.py
	@echo "$(GREEN)兼容性测试完成$(NC)"

test-themes: ## 测试所有主题样式
	@echo "$(YELLOW)测试所有主题样式...$(NC)"
	@$(PYTHON) tests/test_themes.py
	@echo "$(GREEN)主题测试完成$(NC)"

test-single: ## 测试单个主题 (使用: make test-single THEME=simple)
	@echo "$(YELLOW)测试主题: $(THEME)$(NC)"
	@$(PYTHON) tests/test_themes.py test $(THEME)
	@echo "$(GREEN)主题 $(THEME) 测试完成$(NC)"

test-all: test test-themes ## 运行所有测试
	@echo "$(GREEN)所有测试完成$(NC)"

report: test-themes ## 生成测试报告
	@echo "$(YELLOW)生成测试报告...$(NC)"
	@$(PYTHON) tests/generate_test_report.py
	@echo "$(GREEN)测试报告生成完成$(NC)"
	@echo "$(BLUE)报告位置: output/test_output/TEST_REPORT.md$(NC)"
	@echo "$(BLUE)索引页面: output/test_output/index.html$(NC)"

open-report: ## 在浏览器中打开测试报告
	@echo "$(YELLOW)打开测试报告...$(NC)"
	@$(PYTHON) -c "import webbrowser; webbrowser.open('file://$(shell pwd)/output/test_output/index.html')"

list-themes: ## 列出所有可用主题
	@echo "$(YELLOW)可用主题列表:$(NC)"
	@$(PYTHON) tests/test_themes.py list

demo: ## 运行演示 (使用simple主题)
	@echo "$(YELLOW)运行演示...$(NC)"
	@mkdir -p output/demo_output
	@$(PYTHON) markdown_css/bin/markdown-css themes/markdown.html --style=themes/simple.css --out=output/demo_output --name=demo.html --codehighlight=yes
	@echo "$(GREEN)演示文件生成: output/demo_output/demo.html$(NC)"

demo-open: demo ## 运行演示并在浏览器中打开
	@echo "$(YELLOW)打开演示文件...$(NC)"
	@$(PYTHON) -c "import webbrowser; webbrowser.open('file://$(shell pwd)/output/demo_output/demo.html')"

dist: clean ## 构建分发包
	@echo "$(YELLOW)构建分发包...$(NC)"
	@$(PYTHON) setup.py sdist bdist_wheel
	@echo "$(GREEN)分发包构建完成$(NC)"
	@ls -la dist/

release: dist ## 发布包到PyPI
	@echo "$(YELLOW)发布包到PyPI...$(NC)"
	@twine upload dist/*
	@echo "$(GREEN)发布完成$(NC)"

clean: clean-build clean-pyc clean-test clean-output ## 清理所有构建和测试文件

clean-build: ## 清理构建文件
	@echo "$(YELLOW)清理构建文件...$(NC)"
	@rm -rf build/
	@rm -rf dist/
	@rm -rf .eggs/
	@find . -name '*.egg-info' -exec rm -rf {} +
	@find . -name '*.egg' -exec rm -f {} +
	@echo "$(GREEN)构建文件清理完成$(NC)"

clean-pyc: ## 清理Python缓存文件
	@echo "$(YELLOW)清理Python缓存文件...$(NC)"
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -rf {} +
	@echo "$(GREEN)Python缓存文件清理完成$(NC)"

clean-test: ## 清理测试文件
	@echo "$(YELLOW)清理测试文件...$(NC)"
	@rm -rf .tox/
	@rm -f .coverage
	@rm -rf htmlcov/
	@rm -f tests/*.log
	@rm -f *.log
	@echo "$(GREEN)测试文件清理完成$(NC)"

clean-output: ## 清理输出文件
	@echo "$(YELLOW)清理输出文件...$(NC)"
	@rm -rf output/
	@rm -rf public/
	@echo "$(GREEN)输出文件清理完成$(NC)"

format: ## 格式化代码 (需要安装black)
	@echo "$(YELLOW)格式化代码...$(NC)"
	@black markdown_css/ test_*.py generate_*.py
	@echo "$(GREEN)代码格式化完成$(NC)"

lint: ## 代码检查 (需要安装flake8)
	@echo "$(YELLOW)代码检查...$(NC)"
	@flake8 markdown_css/ test_*.py generate_*.py
	@echo "$(GREEN)代码检查完成$(NC)"

check: format lint test-all ## 完整检查 (格式化 + 检查 + 测试)

dev-setup: install-deps install ## 开发环境设置
	@echo "$(GREEN)开发环境设置完成$(NC)"

ci: test-all report ## CI/CD流程
	@echo "$(GREEN)CI/CD流程完成$(NC)"

# 特殊目标
.PHONY: quick-test
quick-test: ## 快速测试 (只测试simple主题)
	@echo "$(YELLOW)快速测试...$(NC)"
	@$(PYTHON) tests/test_themes.py test simple
	@echo "$(GREEN)快速测试完成$(NC)"

.PHONY: validate
validate: ## 验证安装
	@echo "$(YELLOW)验证安装...$(NC)"
	@$(PYTHON) -c "import markdown_css; print('✅ markdown_css 导入成功')"
	@$(PYTHON) markdown_css/bin/markdown-css --help > /dev/null && echo "✅ 命令行工具正常" || echo "❌ 命令行工具异常"
	@echo "$(GREEN)验证完成$(NC)"

# 信息显示
info: ## 显示项目信息
	@echo "$(BLUE)项目信息:$(NC)"
	@echo "  名称: $(PROJECT_NAME)"
	@echo "  版本: $(VERSION)"
	@echo "  Python: $(shell $(PYTHON) --version)"
	@echo "  路径: $(shell pwd)"
	@echo "  主题数量: $(shell ls themes/*.css | wc -l | tr -d ' ')"