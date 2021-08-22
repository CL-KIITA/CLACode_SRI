import "./cla_data.dart";


class CLA_Reg{
  CLA_Reg();
  String toAddrForm(String regularForm){}
  String toBCP47Form(String regularForm){}
  bool isRegularForm(String unkown){}
  
}
class CLA_Addr{
  CLA_Addr();
  String toRegularForm(String addrForm){}
  bool isAddrForm(String unkown){}
}
class CLA_BCP47{
  CLA_BCP47();
  String toRegularForm(String bcp47Form){}
  bool isBCP47Form(String unkown){}
}
class CLA_Kit{
  CLA_Reg reg;
  CLA_Addr addr;
  CLA_BCP47 bcp47;
  CLA_Kit(){
    this.reg = CLA_Reg();
    this.addr = CLA_Addr();
    this.bcp47 = CLA_BCP47();
  }
  String toAddrForm(String regularForm){
    if(this.reg.isRegularForm(regularForm)){
      return this.reg.toAddrForm(regularForm);
    }else{
      throw FormatException();
    }
  }
  String toBCP47Form(String regularForm){
    if(this.reg.isRegularForm(regularForm)){
      return this.reg.toBCP47Form(regularForm);
    }else{
      throw FormatException();
    }
  }
  String toRegularForm(String unkown){
    if(this.addr.isAddrForm(unkown)){
      return this.addr.toRegularForm(unkown);
    }else if(this.bcp47.isBCP47Form(unkown)){
      return this.bcp47.toRegularForm(unkown);
    }else{
      throw FormatException();
    }
  }
  ClaCode3 toCLACode3(String unkown){
    if(this.addr.isAddrForm(unkown)){
      return ClaCode3.onlyCode(this.addr.toRegularForm(unkown));
    }else if(this.bcp47.isBCP47Form(unkown)){
      return ClaCode3.onlyCode(this.bcp47.toRegularForm(unkown));
    }else if(this.reg.isRegularForm(unkown)){
      return ClaCode3.onlyCode(unkown);
    }else{
      throw FormatException();
    }
  }
}