#!/bin/bash

# Claude MCP Tools Setup Script
# このスクリプトはClaude用のMCPツールをインストールします

set -e

echo "🔧 Claude MCP Tools セットアップを開始します..."
echo ""

# Node.jsの確認
if ! command -v node &> /dev/null; then
    echo "❌ Node.jsがインストールされていません。"
    echo "   Node.js 20.0.0以上をインストールしてください。"
    exit 1
fi

NODE_VERSION=$(node -v | cut -d'v' -f2)
echo "✅ Node.js v${NODE_VERSION} を検出しました"

# npmの確認
if ! command -v npm &> /dev/null; then
    echo "❌ npmがインストールされていません。"
    exit 1
fi

NPM_VERSION=$(npm -v)
echo "✅ npm v${NPM_VERSION} を検出しました"
echo ""

# Core MCP tools のインストール
echo "📦 Core MCP tools をインストールしています..."

# File System MCP
echo "  1/5 File System MCP..."
npm install -g @modelcontextprotocol/server-filesystem 2>/dev/null || {
    echo "  ⚠️  File System MCPのインストールをスキップ（パッケージが見つかりません）"
}

# Git MCP
echo "  2/5 Git MCP..."
npm install -g @modelcontextprotocol/server-git 2>/dev/null || {
    echo "  ⚠️  Git MCPのインストールをスキップ（パッケージが見つかりません）"
}

# Memory MCP
echo "  3/5 Memory MCP..."
npm install -g @modelcontextprotocol/server-memory 2>/dev/null || {
    echo "  ⚠️  Memory MCPのインストールをスキップ（パッケージが見つかりません）"
}

# Web Search MCP
echo "  4/5 Web Search MCP..."
npm install -g @modelcontextprotocol/server-websearch 2>/dev/null || {
    echo "  ⚠️  Web Search MCPのインストールをスキップ（パッケージが見つかりません）"
}

# Database MCP (条件付き)
echo "  5/5 Database MCP (オプション)..."
if [ -f "package.json" ]; then
    if grep -q "postgres" package.json 2>/dev/null; then
        echo "     PostgreSQLの使用を検出。PostgreSQL MCPをインストール..."
        npm install -g @modelcontextprotocol/server-postgres 2>/dev/null || {
            echo "  ⚠️  PostgreSQL MCPのインストールをスキップ"
        }
    elif grep -q "sqlite" package.json 2>/dev/null; then
        echo "     SQLiteの使用を検出。SQLite MCPをインストール..."
        npm install -g @modelcontextprotocol/server-sqlite 2>/dev/null || {
            echo "  ⚠️  SQLite MCPのインストールをスキップ"
        }
    else
        echo "     データベース依存関係が検出されませんでした。スキップします。"
    fi
fi

echo ""
echo "📁 MCP設定ディレクトリを作成しています..."

# .claude ディレクトリの作成
mkdir -p .claude

# 設定ファイルのサンプルをコピー
if [ -f ".claude/mcp_config.json.example" ]; then
    if [ ! -f ".claude/mcp_config.json" ]; then
        cp .claude/mcp_config.json.example .claude/mcp_config.json
        echo "✅ MCP設定ファイルを作成しました: .claude/mcp_config.json"
    else
        echo "ℹ️  MCP設定ファイルは既に存在します: .claude/mcp_config.json"
    fi
else
    echo "⚠️  mcp_config.json.example が見つかりません。手動で設定ファイルを作成してください。"
fi

echo ""
echo "✨ MCP tools のセットアップが完了しました！"
echo ""
echo "次のステップ:"
echo "1. .claude/mcp_config.json を編集してプロジェクトに合わせて設定してください"
echo "2. Claude を再起動して新しい MCP tools を読み込んでください"
echo ""
echo "詳細については SETUP.md の MCP セクションを参照してください。"