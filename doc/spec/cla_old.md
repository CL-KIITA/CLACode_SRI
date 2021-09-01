# CLA コード(旧版群)　仕様書

## 第 1 版(従来版)

> Class: CLaKIS CC2015-1  
> Suggested: 2015/7/21  
> Published: 2015/7/21  
> Author: おかゆ, Yuhr  
> Editor: 佐藤陽花

CLA コードは 3-5 文字の ASCII ラテン小文字で規定される。初めの 3 文字はその言語に割り当てられたコードを表し、後ろの 2 文字はその言語の属する人工言語語族 (以下本仕様書において単に語族という) に割り当てられたコードを表す。特に重複などの無い限りは、3 文字のみで表記することができる。前者を言語ブロック、後者を語族ブロックという。

語族とは、世界・作者などによる暫定的な分類をいう。

語族ブロックは、世界を用意していない等の理由で語族を用意できない言語は、これを指定しないことができる。

### コード表記の決定法

ある言語のコードを決定する際には、その言語名をその言語によって綴ったものをさらにラテン小文字転写したものをもとに、重複のないよう決定する。

### CLA1 コード構文

FCPEG により定義する。正規表現は POSIX である。

```fcpeg
[Main]{
  + start CLACode1,
  + use Blocks as Bl,
  + use Symbols as Sym,
  CLACode1 <- CLACode1Gen : CLACode1New,
  CLACode1Gen <- Bl.LanguageBlock Bl.FamilyBlock,
  CLACode1New <- Bl.LanguageBlock Sym.Delimiter Bl.FamilyBlock,
}
[Blocks]{
  + use Symbols as Sym,
  FamilyBlock <- [a-z]{2} : Sym.Undefined,
  LanguageBlock <- [a-z]{3},
}
[Symbols]{
  Undefined <-  "**",
  Delimiter <- "_",
}
```

## 第 2 版(私案版)

> Class: CLaKIS CC2021-1  
> Suggested Date: 2021/8/5  
> Published Date: 2021/8/5  
> Author: 佐藤陽花  
> Editor: 佐藤陽花

CLaKIS CD2015-1 を部分改訂する。

語族ブロックに代えて領域ブロックとしたほか、ブロック間デリミタを定めた。領域ブロックは、無所属／未定コードに関する処理に対応したものである。

### 領域

領域には以下のような種別がある。その性格により 4 種に分けられ、充てられるプリフィックスや、語族ブロックの書式がそれぞれ定義される。

- 語族領域　:　それぞれの言語(群)ごとの設定や世界観に伴った語族によってコードを付与するための領域。`/`をプリフィックスとし、ASCII ラテン小文字 2 字の語族コードが充てられる。
- 製作者領域　:　語族別ではなく、製作者/製作団体のコード附与を希望する製作者/製作団体に付与するための領域。`~`をプリフィックスとし、ASCII ラテン小文字 2 字の製作者コードが充てられる。
- 無所属領域　:　語族領域にも製作者領域にも属さないことを希望した言語のための領域。プリフィックス含め`#**`が充てられる。
- 未定領域　:　どのコード付与を希望するか未だ決まっていない言語のためのための領域。プリフィックス含め`?**`が充てられる。

### CLA2 コード構文

FCPEG により定義する。正規表現は POSIX である。

```fcpeg
[Main]{
  + start CLACode2,
  + use Blocks as Bl,
  CLACode2 <- Bl.LanguageBlock Bl.FamilyBlock,
}
[Blocks]{
  + use Symbols as Sym,
  Bl.FamilyBlock <- FamilyRegion : CreatorRegion : IndependentRegion : UndecidedRegion,
  FamilyRegion <- "/" [a-z]{2},
  CreatorRegion <- "~" [a-z]{2},
  IndependentRegion <- "#" Sym.Undefined,
  UndecidedRegion <- "?" Sym.Undefined,
  LanguageBlock <- [a-z]{3},
}
[Symbols]{
  Undefined <-  "**",
}
```
