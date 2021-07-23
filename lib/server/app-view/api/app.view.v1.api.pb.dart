class ListHomeMoRequest {
  String categoryName;
  int pageIndex;
  int pageSize;

  ListHomeMoRequest({this.categoryName, this.pageIndex, this.pageSize});

  ListHomeMoRequest.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    pageIndex = json['page_index'];
    pageSize = json['page_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['page_index'] = this.pageIndex;
    data['page_size'] = this.pageSize;
    return data;
  }
}

class ListHomeMoResponse {
  List<BannerMo> bannerList;
  List<CategoryMo> categoryList;
  List<ComicMo> comicList;

  ListHomeMoResponse({this.bannerList, this.categoryList, this.comicList});

  ListHomeMoResponse.fromJson(Map<String, dynamic> json) {
    if (json['banner_list'] != null) {
      bannerList = new List<BannerMo>.empty(growable: true);
      json['banner_list'].forEach((v) {
        bannerList.add(new BannerMo.fromJson(v));
      });
    }
    if (json['category_list'] != null) {
      categoryList = new List<CategoryMo>.empty(growable: true);
      json['category_list'].forEach((v) {
        categoryList.add(new CategoryMo.fromJson(v));
      });
    }
    if (json['comic_list'] != null) {
      comicList = new List<ComicMo>.empty(growable: true);
      json['comic_list'].forEach((v) {
        comicList.add(new ComicMo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bannerList != null) {
      data['banner_list'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.categoryList != null) {
      data['category_list'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    if (this.comicList != null) {
      data['comic_list'] = this.comicList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerMo {
  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String cover;
  String createTime;

  BannerMo(
      {this.id,
      this.sticky,
      this.type,
      this.title,
      this.subtitle,
      this.url,
      this.cover,
      this.createTime});

  BannerMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sticky = json['sticky'];
    type = json['type'];
    title = json['title'];
    subtitle = json['subtitle'];
    url = json['url'];
    cover = json['cover'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sticky'] = this.sticky;
    data['type'] = this.type;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['create_time'] = this.createTime;
    return data;
  }
}

class CategoryMo {
  String name;
  int count;

  CategoryMo({this.name, this.count});

  CategoryMo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['count'] = this.count;
    return data;
  }
}

class ComicMo {
  int id;
  String title;
  String authors;
  String status;
  String cover;
  String types;
  int lastUpdatetime;
  int num;

  ComicMo(
      {this.id,
      this.title,
      this.authors,
      this.status,
      this.cover,
      this.types,
      this.lastUpdatetime,
      this.num});

  ComicMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authors = json['authors'];
    status = json['status'];
    cover = json['cover'];
    types = json['types'];
    lastUpdatetime = json['last_updatetime'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['authors'] = this.authors;
    data['status'] = this.status;
    data['cover'] = this.cover;
    data['types'] = this.types;
    data['last_updatetime'] = this.lastUpdatetime;
    data['num'] = this.num;
    return data;
  }
}
