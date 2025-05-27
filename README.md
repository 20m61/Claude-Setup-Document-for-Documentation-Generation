# 🪄 Claude Setup Document for Documentation Generation

## 📋 概要

このリポジトリは、Claude Code を使用してプロジェクトのセットアップと包括的なドキュメント生成を自動化するためのガイドラインを提供します。開発者が Claude と協働して、一貫性のあるプロジェクト構造、高品質なドキュメント、自動化されたワークフローを構築できるようにすることを目的としています。

## 🎯 目的

1. **標準化されたプロジェクトセットアップ** - 全てのプロジェクトで一貫した構造とベストプラクティスを実現
2. **自動ドキュメント生成** - Claude による包括的で保守しやすいドキュメントの作成
3. **GitHub 統合の自動化** - イシューや PR への自動応答とコード生成
4. **品質保証** - テスト、リンティング、セキュリティチェックの自動化

## 🚀 クイックスタート

### 1. リポジトリのクローン

```bash
git clone https://github.com/20m61/Claude-Setup-Document-for-Documentation-Generation.git
cd Claude-Setup-Document-for-Documentation-Generation
```

### 2. Claude Code の起動

```bash
claude
```

### 3. SETUP.md の読み込み

```bash
# Claude内で以下を実行
read SETUP.md
```

### 4. プロジェクトのセットアップ実行

Claude に以下のように指示します：

```
SETUP.mdに従って、新しいプロジェクトをセットアップしてください。
プロジェクト名は「my-awesome-project」です。
```

## 📘 詳細な使い方

### プロジェクト仕様の準備

1. `docs/specification.md`を作成し、以下の情報を記載：
   - プロジェクトの目的と目標
   - 機能要件と非機能要件
   - ユーザーストーリー
   - 技術スタック
   - 成功指標

### Claude による自動セットアップ

Claude は以下のタスクを自動的に実行します：

1. **ディレクトリ構造の生成**

   ```
   my-project/
   ├── .claude/          # Claude設定ファイル
   ├── src/              # ソースコード
   ├── tests/            # テストファイル
   ├── docs/             # ドキュメント
   ├── scripts/          # ユーティリティスクリプト
   └── .github/          # GitHub設定
   ```

2. **ドキュメントの生成**

   - `README.md` - プロジェクト概要
   - `TESTING.md` - テスト戦略
   - `STRUCTURE.md` - アーキテクチャ説明
   - `CONTRIBUTING.md` - 貢献ガイドライン

3. **設定ファイルの作成**

   - `package.json` - 依存関係とスクリプト
   - `tsconfig.json` - TypeScript 設定
   - `.eslintrc.json` - リンター設定
   - `.prettierrc` - フォーマッター設定

4. **GitHub Actions の設定**
   - 自動テスト
   - コード品質チェック
   - デプロイメントパイプライン

### MCP ツールの活用

```bash
# MCPツールのインストール
./scripts/setup-mcp.sh

# 設定の確認
cat .claude/mcp_config.json
```

## 🛠️ ベストプラクティス

### 1. 仕様駆動開発

- 必ず`docs/specification.md`を最初に作成
- 明確な要件定義と成功指標を設定
- Claude に仕様を理解させてから実装を開始

### 2. 段階的な実装

```bash
# 良い例：段階的なアプローチ
1. 基本構造の生成
2. コア機能の実装
3. テストの追加
4. ドキュメントの更新
5. CI/CDの設定

# 避けるべき：一度に全てを実装
❌ "プロジェクト全体を一度に作成してください"
```

### 3. バージョン管理

- 各機能は個別のブランチで開発
- コミットメッセージは明確で意味のあるものに
- PR には詳細な説明を含める

### 4. セキュリティ

- API キーは必ず GitHub Secrets に保存
- `.env.local`は`.gitignore`に追加
- 定期的な依存関係の監査

### 5. テスト駆動

```javascript
// テストファーストアプローチ
// 1. テストを書く
test('should calculate total correctly', () => {
  expect(calculateTotal([10, 20, 30])).toBe(60);
});

// 2. 実装する
function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item, 0);
}
```

## 🔧 カスタマイズ

### プロジェクトタイプ別の設定

#### Web アプリケーション

```yaml
# .claude/project-type.yml
type: web-app
framework: react
styling: tailwind
testing: jest
```

#### CLI ツール

```yaml
type: cli-tool
language: typescript
packaging: npm
testing: vitest
```

#### API サーバー

```yaml
type: api-server
framework: express
database: postgresql
testing: supertest
```

### カスタムプロンプト

`.claude/prompts.md`に独自のプロンプトを追加：

```markdown
## コーディング規約

- 関数名は動詞で始める
- 変数名は意味のある名前を使用
- コメントは日本語で記載

## エラーハンドリング

- 全ての非同期処理で try-catch を使用
- エラーメッセージは具体的に
- ログには十分なコンテキストを含める
```

## 📊 活用例

### 例 1: React アプリケーションの作成

```bash
claude

# Claude内で
SETUP.mdを読み込んで、Reactベースのタスク管理アプリケーションを作成してください。
以下の機能を含めてください：
- タスクの追加/編集/削除
- カテゴリ分け
- 期限設定
- ローカルストレージへの保存
```

### 例 2: Node.js CLI ツールの作成

```bash
claude

# Claude内で
SETUP.mdに従って、ファイル整理用のCLIツールを作成してください。
機能：
- ファイルの拡張子別整理
- 重複ファイルの検出
- 一括リネーム
```

## 🤝 コントリビューション

1. このリポジトリをフォーク
2. 機能ブランチを作成 (`git checkout -b feature/amazing-feature`)
3. 変更をコミット (`git commit -m 'feat: Add amazing feature'`)
4. ブランチにプッシュ (`git push origin feature/amazing-feature`)
5. プルリクエストを作成

## 📝 ライセンス

このプロジェクトは MIT ライセンスの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。

## 📞 サポート

- 🐛 バグ報告: [GitHub Issues](https://github.com/20m61/Claude-Setup-Document-for-Documentation-Generation/issues)
- 💬 ディスカッション: [GitHub Discussions](https://github.com/20m61/Claude-Setup-Document-for-Documentation-Generation/discussions)
- 📧 お問い合わせ: your-email@example.com
