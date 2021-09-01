# CLA コード改訂版関係　仕様書群

## CLA コード改訂版(第 3 版)　基本仕様書

> Class: CLaKIS CC2021-2  
> Suggested Date: 2021/8/17  
> Published Date: 2021/9/2  
> Author: 佐藤陽花,Ziphil,Furcht,Xirdim,AI  
> Editor: 佐藤陽花

CLaKIS CC2021-1 を改訂する。

CLA コードは製作者ブロック、語族ブロック、言語ブロック、方言ブロックの 4 ブロックにて構成される。

- 製作者ブロックは、言語の製作者もしくは製作グループを表す。これはラテン字 3 字により規定される。
- 語族ブロックは、語族や架空世界などに従う言語グループを表す。これはラテン字 3 字により規定される。
- 言語ブロックは、各個別の言語を表す。これはラテン字 2 字により規定される。
- 方言ブロックは、各個別の言語の内における各個別の言語変種を表す。これはラテン字 2 字により規定される。

CLA コードは正規形及び省略形のほか、従来仕様への経過措置的対応のための仮変換である BCP 形の 3 形式のいづれかをとる。

- CLA コード正規形は、正規的な基本形たる正式な形式であり、特に別段の理由がなければこれを用いる。これは製作者ブロック、語族ブロック、言語ブロック、方言ブロックをこの逆順にならべ、アンダースコアで結合したものである。
- CLA コード省略形は、使用者が記憶及び筆記、入力、記録の簡便のために用いることができる形式である。別に定める省略法に従って正規形を省略したものである。
- CLA コード BCP 形は、従来仕様への経過措置的対応のための仮変換たる形式である。別に定める変換法によって正規形を変換したものである。この形式は、BCP 47 形式に適合する。

### 記号類

デリミタは正規形及び省略形で`_`、BCP 形で`-`とする。また次のように特殊な値を取り得る。

- 未定義　そのブロックのに意味のあるデータが存在しない場合。語族ブロック及び方言ブロックでのみ可能。正規形及び省略形で`~`、BCP 形で`0`とする。
- 総称　その部分ブロック群に属する下位コードを総称する場合。製作者ブロックを除き、方言ブロックからの連続したブロック群でのみ可能。正規形及び省略形で`*`、BCP 形で`1`とする。
- 不明　検索機能あるいは省略形において特定のブロックが不明である場合。すべての形態で`9`とする。

### 衝突の制約

同一のコードで異なる製作者、語族、言語、方言を表すことはない。

製作者ブロックのコードは最上位単位であり互いに素である。

同一の製作者において、語族ブロックのコードは互いに素である。例外を除いて製作者ブロック及び語族ブロックのコードはそのそれぞれのみならず、その和集合においても互いに素である。

異なる製作者において同一の語族ブロックのコードを持ち得るのは同一の語族を表す場合のみであり、その他の場合は互いに素である。他者が作成した言語を改変してまたは参考にして新たな言語を作成する場合は、同一の語族と考えられるので、審査により同一のコードを持つことを許可する。

同一の語族において、言語ブロックのコード及び方言ブロックのコードは、そのそれぞれのみならず、その和集合においても互いに素である。

### 省略法

製作者ブロック又は語族ブロックのいずれか、及び言語ブロック又は方言ブロックのいずれかを省略することができる。省略した場合、次のフラグが立つ。フラグプリフィックスは"."であり、末尾に結合する。

- D 　言語ブロックを省略した場合
- L 　方言ブロックを省略した場合のうち、残った言語ブロックが言語を表す場合
- P 　方言ブロックを省略した場合のうち、残った言語ブロックが祖語を表す場合
- F 　製作者ブロックを省略した場合のうち、残った語族ブロックが語族を表す場合
- M 　製作者ブロックを省略した場合のうち、残った語族ブロックがマクロ言語を表す場合
- C 　語族ブロックを省略した場合

### 変換法

正規形を逆順に並べ替えたのち記号類を変換し、プリフィックス"x-v3-"を付加する。

### CLA3 コード構文

FCPEG により定義する。正規表現は POSIX である。

```fcpeg
[Main]{
  + start CLACode3,
  + use Blocks as Bl,
  + use Symbols as Sym,
  CLACode3 <- CLACode3Reg : CLACode3Addr : CLACode3BCP,
  CLACode3Reg <- Bl.DialectBlockGen Sym.DelimitersGen Bl.LanguageBlock Sym.DelimitersGen Bl.FamilyBlockGen Sym.DelimitersGen Bl.CreatorBlock,
  CLACode3Addr <- (Bl.DialectBlockGen-1 : Bl.LanguageBlock-2) Sym.DelimitersGen (Bl.FamilyBlockGen-3 : Bl.CreatorBlock-4) Sym.AddrFlagDelimiter (Sym.AddrDirFlag-1 : Sym.AddrLangFlag-2) (Sym.AddrFamFlag-3 : Sym.AddrCreFlag-4),
  CLACode3BCP <- "x-v3-" Bl.CreatorBlock Bl.FamilyBlockBCP Bl.LanguageBlock (Sym.DelimitersBCP Bl.DialectBlockBCP)?,
}
[Blocks]{
  + use Symbols as Sym,
  CreatorBlock <- [a-z]{3},
  FamilyBlock <- [a-z]{3} : Sym.Undefined,
  FamilyBlockGen <- [a-z]{3} : Sym.UndefinedGen,
  FamilyBlockBCP <- [a-z]{3} : Sym.UndefinedBCP,
  LanguageBlock <- [a-z]{2},
  DialectBlock <- [a-z]{2} : Sym.Undefined,
  DialectBlockGen <- [a-z]{2} : Sym.UndefinedGen,
  DialectBlockBCP <- [a-z]{2} : Sym.UndefinedBCP,
}
[Symbols]{
  AddrFlag <- AddrFlagDia : AddrLangFlag : AddrFamFlag : AddrCreFlag
  AddrDiaFlag <- "D"
  AddrLangFlag <- "L" : "P"
  AddrFamFlag <- "F" : "M"
  AddrCreFlag <- "C"
  AddrFlagDelimiter <-".",
  Delimiters <- DelimitersGen : DelimitersBCP,
  DelimitersGen <- "_",
  DelimitersBCP <- "-",
  Undefined <- UndefinedGen : UndefinedBCP,
  UndefinedGen <- "~",
  UndefinedBCP <- "0",
  Generic <- GenericGen : GenericBCP,
  GenericGen <- "*",
  GenericBCP <- "1",
  Unknown <- "9",
}
```

## CLA コード改訂版(第 3 版)　共通人工言語情報記述形式及び自由オプション仕様書

> Class: CLaKIS CC2021-3  
> Suggested Date: 2021/8/17  
> Published Date: 2021/9/2  
> Author: 佐藤陽花,Ziphil,ѕkytomo  
> Editor: 佐藤陽花

CLaKIS CC2021-2 に追加する。

共通人工言語情報記述形式は、CLaKIS CC2021-2 を含んだシリアライズデータ形式であり、改行を含まない連記形式と改行を含む標準形式からなる。本文書では連記形式のみ定義する。

### 連記形式

連記形式はコード部及び自由オプション部からなる。自由オプション部はコード部の直後に結合する。コード部は CLaKIS CC2021-2 形式である。

自由オプションは、共通プロパティ部及び自由プロパティ部に分かれる。

- 共通プロパティ部は、ある程度の(緩めの)共通的標準形式を設けた部分である。
- 自由プロパティ部は、標準形式をもうけず自由に記述可能としたものである。

#### 冒頭記号

・共通プロパティ部は、それぞれのプロパティ毎に`-`の冒頭記号を付加し結合する。
・自由プロパティ部は、全体として`--`の冒頭記号を付加し共通プロパティ部の後尾に結合する。

#### 共通プロパティ部

- se 分類　　各タグは se 分類(CLaKIS CCX000-1)による 3 桁略号である。

  POSIX 正規表現：`R"[a-z]{3}"`

> 実験言語 exp、芸術言語 art、輔助言語 aux、工学言語 eng、哲学的言語 phi、論理的言語 log

- モユネ分類　　各タグはモユネ分類(CLaKIS CT2014-1)のタグ。`_`をデリミタとして結合する。
- バージョン　　各レヴェル 1 ～ 4 桁の半角英数字とした、1 ～ 4 個のレヴェルからなる。各レヴェルは上位から順に並べ`.`をデリミタとして結合する。

  POSIX 正規表現：`R"([a-z0-9]{1,4}){1,4}"`

- 更新日の形式　　 ISO8601 基本形式の日付部、日本標準時は無標(あるいはプリフィックス 0000)、協定世界時はプリフィックス`utc0`、、ほかの地域は IATA タイムゾーンコードに従う(末尾 0 パディング)プリフィックスをもつ。

  POSIX 正規表現：R"[a-z0-9]{4}"

#### 自由プロパティ部

ハイフンを除くサブデリミタ及び非リザーブド文字(RFC3986 に定義されているもの)を用いることができる。

## CLA コード改訂版(第 3 版)　手続仕様書

> Class: CLaKIS CC2021-4  
> Suggested Date: 2021/8/17  
> Published Date: 2021/9/2  
> Author: 佐藤陽花,Ziphil  
> Editor: 佐藤陽花

CLaKIS CC2021-2 に準拠したコードを登録するための手続を定義する。原則として電子的手段を用いて CLA コードの登録手続を行う。

コード申請者はこのサーバーにアクセスし所定のコード申請画面からコードを申請する。このとき、申請画面にかかるクライアント側プログラムは、送信時点の日時を協定世界時として申請データに付記して送信する。申請データとして入力すべきデータは別に定める。

申請画面により送信された CLA コードのデータは未承認データとしてサーバに保存蓄積される。この未承認前データは申請者及び CLA コード管理者を除いて非公開とする。

CLA コード管理者がデータベースに保存蓄積された申請内容を適宜承認する。サーバ側プログラムはフラグを未承認から承認済に書き換える。このとき、承認日時をデータに追加する。

承認済コードは、コード申請者により追加情報を設定画面から登録することができる。このとき入力可能なデータは別に定める。

## CLA コード改訂版(第 3 版)　ソフトウェアデータ仕様書

> Class: CLaKIS CC2021-5  
> Suggested Date: 2021/8/17  
> Published Date: 2021/9/-  
> Author: 佐藤陽花,Ziphil,AI  
> Editor: 佐藤陽花

CLaKIS CC2021-2 及び CC2021-4 に用いるソフトウェア及びデータ形式を定義する。
