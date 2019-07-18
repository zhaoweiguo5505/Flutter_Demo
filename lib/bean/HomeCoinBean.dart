class HomeCoinBean {
  String btc;
  String rate;
  DataMap dataMap;
  String eth;

  HomeCoinBean({this.btc, this.rate, this.dataMap, this.eth});

  HomeCoinBean.fromJson(Map<String, dynamic> json) {
    btc = json['btc'];
    rate = json['rate'];
    dataMap =
        json['dataMap'] != null ? new DataMap.fromJson(json['dataMap']) : null;
    eth = json['eth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['btc'] = this.btc;
    data['rate'] = this.rate;
    if (this.dataMap != null) {
      data['dataMap'] = this.dataMap.toJson();
    }
    data['eth'] = this.eth;
    return data;
  }
}

class DataMap {
  List<USDT> uSDT;

  DataMap({this.uSDT});

  DataMap.fromJson(Map<String, dynamic> json) {
    if (json['USDT'] != null) {
      uSDT = new List<USDT>();
      json['USDT'].forEach((v) {
        uSDT.add(new USDT.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.uSDT != null) {
      data['USDT'] = this.uSDT.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class USDT {
  int fid;
  bool fisShare;
  String fname;
  String fShortName;
  String fnameSn;
  String furl;
  double fupanddown;
  double fupanddownweek;
  double fmarketValue;
  double fentrustValue;
  double volumn;
  double lastDealPrize;
  double higestBuyPrize;
  double lowestSellPrize;
  int status;
  String openTrade;
  int coinTradeType;
  String group;
  bool homeShow;
  int homeOrder;
  int typeOrder;
  int totalOrder;
  double lowestPrize24;
  double highestPrize24;
  double totalDeal24;
  double entrustValue24;
  int priceDecimals;
  int amountDecimals;
  int sort;
  bool innovate;
  int chgTime;
  double openPrice;
  int weekChgTime;
  double weekOpenPrice;

  USDT(
      {this.fid,
      this.fisShare,
      this.fname,
      this.fShortName,
      this.fnameSn,
      this.furl,
      this.fupanddown,
      this.fupanddownweek,
      this.fmarketValue,
      this.fentrustValue,
      this.volumn,
      this.lastDealPrize,
      this.higestBuyPrize,
      this.lowestSellPrize,
      this.status,
      this.openTrade,
      this.coinTradeType,
      this.group,
      this.homeShow,
      this.homeOrder,
      this.typeOrder,
      this.totalOrder,
      this.lowestPrize24,
      this.highestPrize24,
      this.totalDeal24,
      this.entrustValue24,
      this.priceDecimals,
      this.amountDecimals,
      this.sort,
      this.innovate,
      this.chgTime,
      this.openPrice,
      this.weekChgTime,
      this.weekOpenPrice});

  USDT.fromJson(Map<String, dynamic> json) {
    fid = json['fid'];
    fisShare = json['fisShare'];
    fname = json['fname'];
    fShortName = json['fShortName'];
    fnameSn = json['fname_sn'];
    furl = json['furl'];
    fupanddown = json['fupanddown'];
    fupanddownweek = json['fupanddownweek'];
    fmarketValue = json['fmarketValue'];
    fentrustValue = json['fentrustValue'];
    volumn = json['volumn'];
    lastDealPrize = json['lastDealPrize'];
    higestBuyPrize = json['higestBuyPrize'];
    lowestSellPrize = json['lowestSellPrize'];
    status = json['status'];
    openTrade = json['openTrade'];
    coinTradeType = json['coinTradeType'];
    group = json['group'];
    homeShow = json['homeShow'];
    homeOrder = json['homeOrder'];
    typeOrder = json['typeOrder'];
    totalOrder = json['totalOrder'];
    lowestPrize24 = json['lowestPrize24'];
    highestPrize24 = json['highestPrize24'];
    totalDeal24 = json['totalDeal24'];
    entrustValue24 = json['entrustValue24'];
    priceDecimals = json['priceDecimals'];
    amountDecimals = json['amountDecimals'];
    sort = json['sort'];
    innovate = json['innovate'];
    chgTime = json['chgTime'];
    openPrice = json['openPrice'];
    weekChgTime = json['weekChgTime'];
    weekOpenPrice = json['weekOpenPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fid'] = this.fid;
    data['fisShare'] = this.fisShare;
    data['fname'] = this.fname;
    data['fShortName'] = this.fShortName;
    data['fname_sn'] = this.fnameSn;
    data['furl'] = this.furl;
    data['fupanddown'] = this.fupanddown;
    data['fupanddownweek'] = this.fupanddownweek;
    data['fmarketValue'] = this.fmarketValue;
    data['fentrustValue'] = this.fentrustValue;
    data['volumn'] = this.volumn;
    data['lastDealPrize'] = this.lastDealPrize;
    data['higestBuyPrize'] = this.higestBuyPrize;
    data['lowestSellPrize'] = this.lowestSellPrize;
    data['status'] = this.status;
    data['openTrade'] = this.openTrade;
    data['coinTradeType'] = this.coinTradeType;
    data['group'] = this.group;
    data['homeShow'] = this.homeShow;
    data['homeOrder'] = this.homeOrder;
    data['typeOrder'] = this.typeOrder;
    data['totalOrder'] = this.totalOrder;
    data['lowestPrize24'] = this.lowestPrize24;
    data['highestPrize24'] = this.highestPrize24;
    data['totalDeal24'] = this.totalDeal24;
    data['entrustValue24'] = this.entrustValue24;
    data['priceDecimals'] = this.priceDecimals;
    data['amountDecimals'] = this.amountDecimals;
    data['sort'] = this.sort;
    data['innovate'] = this.innovate;
    data['chgTime'] = this.chgTime;
    data['openPrice'] = this.openPrice;
    data['weekChgTime'] = this.weekChgTime;
    data['weekOpenPrice'] = this.weekOpenPrice;
    return data;
  }
}
