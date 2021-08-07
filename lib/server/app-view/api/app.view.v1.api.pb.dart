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

class ListComicDetailRequest {
  List<int> comicIds;

  ListComicDetailRequest({this.comicIds});

  ListComicDetailRequest.fromJson(Map<String, dynamic> json) {
    comicIds = json['comic_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comic_ids'] = this.comicIds;
    return data;
  }
}

class ListComicDetailResponse {
  List<ComicDetail> comics;

  ListComicDetailResponse({this.comics});

  ListComicDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['comics'] != null) {
      comics = new List<ComicDetail>.empty(growable: true);
      json['comics'].forEach((v) {
        comics.add(new ComicDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comics != null) {
      data['comics'] = this.comics.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ComicDetail {
  int id;
  String title;
  int direction;
  int islong;
  String cover;
  String description;
  int lastUpdatetime;
  String lastUpdateChapterName;
  String firstLetter;
  String comicPy;
  int hotNum;
  int hitNum;
  int lastUpdateChapterId;
  int subscribeNum;
  String authors;
  String status;
  String types;
  List<Chapter> chapters;

  ComicDetail(
      {this.id,
      this.title,
      this.direction,
      this.islong,
      this.cover,
      this.description,
      this.lastUpdatetime,
      this.lastUpdateChapterName,
      this.firstLetter,
      this.comicPy,
      this.hotNum,
      this.hitNum,
      this.lastUpdateChapterId,
      this.subscribeNum,
      this.authors,
      this.status,
      this.types,
      this.chapters});

  ComicDetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    direction = json['Direction'];
    islong = json['Islong'];
    cover = json['Cover'];
    description = json['Description'];
    lastUpdatetime = json['LastUpdatetime'];
    lastUpdateChapterName = json['LastUpdateChapterName'];
    firstLetter = json['FirstLetter'];
    comicPy = json['ComicPy'];
    hotNum = json['HotNum'];
    hitNum = json['HitNum'];
    lastUpdateChapterId = json['LastUpdateChapterId'];
    subscribeNum = json['SubscribeNum'];
    authors = json['authors'];
    status = json['status'];
    types = json['types'];
    if (json['Chapters'] != null) {
      chapters = new List<Chapter>.empty(growable: true);
      json['Chapters'].forEach((v) {
        chapters.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Direction'] = this.direction;
    data['Islong'] = this.islong;
    data['Cover'] = this.cover;
    data['Description'] = this.description;
    data['LastUpdatetime'] = this.lastUpdatetime;
    data['LastUpdateChapterName'] = this.lastUpdateChapterName;
    data['FirstLetter'] = this.firstLetter;
    data['ComicPy'] = this.comicPy;
    data['HotNum'] = this.hotNum;
    data['HitNum'] = this.hitNum;
    data['LastUpdateChapterId'] = this.lastUpdateChapterId;
    data['SubscribeNum'] = this.subscribeNum;
    data['authors'] = this.authors;
    data['status'] = this.status;
    data['types'] = this.types;
    if (this.chapters != null) {
      data['Chapters'] = this.chapters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  String title;
  List<Data> data;

  Chapter({this.title, this.data});

  Chapter.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    if (json['Data'] != null) {
      data = new List<Data>.empty(growable: true);
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool _desc = true;
  bool get desc => _desc;
  set desc(bool value) {
    _desc = value;
  }

  int _showNum = 14;
  int get showNum => _showNum;
  set showNum(int value) {
    _showNum = value;
  }
}

class Data {
  int chapterId;
  String chapterTitle;
  int updatetime;
  int filesize;
  int chapterOrder;

  Data(
      {this.chapterId,
      this.chapterTitle,
      this.updatetime,
      this.filesize,
      this.chapterOrder});

  Data.fromJson(Map<String, dynamic> json) {
    chapterId = json['ChapterId'];
    chapterTitle = json['ChapterTitle'];
    updatetime = json['Updatetime'];
    filesize = json['Filesize'];
    chapterOrder = json['ChapterOrder'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ChapterId'] = this.chapterId;
    data['ChapterTitle'] = this.chapterTitle;
    data['Updatetime'] = this.updatetime;
    data['Filesize'] = this.filesize;
    data['ChapterOrder'] = this.chapterOrder;
    return data;
  }
}
