//CLAコード第3版
class CLACode3{
  CLACode3();
  CLACode3.onlyCode(String code){}
}
//言語コード体系識別コード
class DiscernCode{}
//製作者ブロック(include 製作団体)
class CreatorBlock{
}
//語族ブロック(withマクロランゲージ)
class FamilyBlock{}
//言語ブロック(with祖語・古語)
class LanguageBlock{
  //lang-name
  Map<String> name;
  //ブロックコード
  String code;
  //種別
  String kind;
  //漢字名
  String hans;
  //漢字略語
  String hanAddr;
  //英語略語
  String engAddr;


}
//方言ブロック
class DialectBlock{}

//CLAコード第2版
class CLACode2{
  //領域種別
  String regionKind;
  //言語ブロック
  String languageBlock;
  //領域プリフィックス
  String regionPrefix;
  //領域ブロック
  String regionBlock;

  CLACode2(String regionKind, String languageBlock, String regionBlock){
    if(langageBlock.length!=3){
      throw FormatException();
    }else{
      this.languageBlock = languageBlock;
    }
    switch (regionKind){
      case "語族":
        if(regionBlock.length!=2){
          throw FormatException();
        }else{
          this.regionBlock = regionBlock;
          this.regionPrefix = "/";
          this.regionKind = regionKind;
        }
        break;
      case "製作者":
        if(regionBlock.length!=2){
          throw FormatException();
        }else{
          this.regionBlock = regionBlock;
          this.regionPrefix = "~";
          this.regionKind = regionKind;
        }
        break;
      case "無所属":
        this.regionKind = regionKind;
        this.regionPrefix = "#";
        this.regionBlock = "**";
        break;
      case "未定":
        this.regionKind = regionKind;
        this.regionPrefix = "?";
        this.regionBlock = "**";
        break;
      default:
        throw FormatException();
        break;
    }
  }
  String toCodeStr(){
    return this.languageBlock+this.regionPrefix+this.regionBlock;
  }
}

//CLAコード第1版
class CLACode1{
  
}
