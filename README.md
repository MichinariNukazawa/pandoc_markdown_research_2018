pandoc markdown research 2018
====
pandocを用いてMarkdownファイルからPDFを生成した際の、コードブロックに対するレイアウト補助について調査した。  

# TL;DR
- `--highlight-style`コマンドラインオプションのプリセットはすべての設定で自動改行をしてくれない。
- `--listings`コマンドラインオプションで設定することにより自動改行できるようになる。
- `--listings`を使用すると、デフォルトでシンタックスハイライトが無く、`--highlight-style`のプリセット設定が使用できなくなる。
- 自動改行は半角空白で行われるため、日本語など、半角空白を含まない部分では失敗する。
- また、自動改行にあたり、構文レベルでの解釈を行ってはいないようである。(C言語のリテラル中の空白で改行したりする。これは文法違反となる。)
  
# 問題意識
ドキュメントシステムによるコードブロックに対する主なレイアウト補助機能として、自動改行,シンタックスハイライト,コードブロック範囲表示が挙げられる。  
技術書・技術同人誌は多くの場合ページ数が多い。そのため、コードブロックの挿入をドキュメントシステムの自動改行機能の補助なしに行うと、ソースコードが印刷範囲から見切れるなどのレイアウト,印刷上の問題が発生する場合がある。  
また、シンタックスハイライト機能は文法を解釈してトークン文字列に適切な色を付与するが、技術書は本文がモノクロ印刷である場合がある。そのため、シンタックスハイライトで付けられた色によっては、印刷時のモノクロ化により文字が読めなくなってしまう可能性が懸念される。  
そこで今回は、ドキュメントシステムpandocについて、MarkdownファイルからPDFを生成した際の、コードブロックに対するレイアウト補助を有効化する方法と、レイアウト補助設定の実行結果を調査してまとめた。  
  
なお、調査に使用したスクリプト等をGitHubにて公開している。  
[pandoc markdown research 2018]( https://github.com/MichinariNukazawa/pandoc_markdown_research_2018 )  
  
# その他
- `--listings`設定値はtex由来の模様。
- `--highlight-style` `--listings`共にコードブロックを背景色で塗りつぶす設定が可能。
  
# 未解決の問題
- pandocにて、シンタックスハイライト(カラー)と自動改行を共存する設定値の調査。
- 半角空白がなくても右端到達で改行する設定値があるのではないか。
- 印刷と電子書籍PDFのソース共通化をねらった、モノクロ印刷に耐えるシンタックスハイライトの探求。
- 誰かRe:VIEWとgitbookその他競合を使っている人も調べてみていただけませんか...。
  
# 調査内容
pandocにてMarkdowndからのPDF生成において、以下を試した。  
1. `--highlight-style`オプションで、PDF出力。  
モノクロ印刷で利用可能な設定値があるか目視で確認できるよう、全オプションに対してサンプルコードをPDF出力した一覧を作成した。  
なおオプション一覧は公式ドキュメントによると以下。  
`pygments (the default), kate, monochrome, breezeDark, espresso, zenburn, haddock, and tango. `  
2. `--listings`自動改行の性能調査。  
自動改行した際に、自動改行がどの程度上手くソースコードを改行できるか、サンプルコードで出力して調査した。  
3. `--listings`と`--highlight-style`の重ねがけ。  
`--listings`には標準でシンタックスハイライトが無く、設定は複雑と思われる。`--highlight-style`のシンタックスハイライト設定に自動改行等の設定差分を上書きできればシンタックスハイライトと自動改行を容易に共存できると考え、重ねがけ設定が可能か確認した。  

サンプルコードはHTML,CSS,JavaScriptを用意した。Webフロントエンド言語が主要ユースケースと想定しているためである。  

# 参照URL
[Pandoc User’s Guide]( https://pandoc.org/MANUAL.html )

# 調査結果
TL;DR参照。  
以下に、`--highlight-style`オプション毎のPDF出力を示す。  

詳細なオプション等はGitHubリポジトリの生成スクリプトを参照。
(`--listings`は2ページに収まるようフォントサイズを指定している)