class HomeBannerBean {
  int code;
  List<ListBannerBean> data;
  int totalCount;
  int page;

  HomeBannerBean({this.code, this.data, this.totalCount, this.page});

  HomeBannerBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<ListBannerBean>();
      json['data'].forEach((v) {
        data.add(new ListBannerBean.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['page'] = this.page;
    return data;
  }
}

class ListBannerBean {
  String value;
  String key;
  String url;

  ListBannerBean({this.value, this.key, this.url});

  ListBannerBean.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    key = json['key'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['key'] = this.key;
    data['url'] = this.url;
    return data;
  }
}
