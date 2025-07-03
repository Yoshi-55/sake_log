
# TOKK_LOG.

日本酒の銘柄記録アプリ TOKK_LOG.

## 概要
TOKK_LOG.は日本酒の銘柄やテイスティング記録を管理できるWebアプリケーションです。

## 主な機能
- 銘柄の登録・検索・編集・削除
- テイスティングログの記録
- ブランド名オートコンプリート（`app/javascript/brand_autocomplete.js`）
- Deviseによるユーザー認証

## 動作環境
- Ruby: 3.x系
- Rails: 7.x系
- Node.js, Yarn
- Docker（開発用/本番用）

## ブランド名オートコンプリートについて
ブランド名入力欄でAPIから取得した候補をサジェスト表示します。
詳細は `app/javascript/brand_autocomplete.js` および該当Viewをご参照ください。
外部データ:さけのわデータ(https://sakenowa.com)を利用して銘柄(Brand)を取得しています。
