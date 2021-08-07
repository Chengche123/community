import 'dart:convert' show json;

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
  List<ChapterData> data;

  Chapter({this.title, this.data});

  Chapter.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    if (json['Data'] != null) {
      data = new List<ChapterData>.empty(growable: true);
      json['Data'].forEach((v) {
        data.add(new ChapterData.fromJson(v));
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

class ChapterData {
  int chapterId;
  String chapterTitle;
  int updatetime;
  int filesize;
  int chapterOrder;

  ChapterData(
      {this.chapterId,
      this.chapterTitle,
      this.updatetime,
      this.filesize,
      this.chapterOrder});

  ChapterData.fromJson(Map<String, dynamic> json) {
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

class ListComicChapterDetailRequest {
  int comicId;
  int chapterId;

  ListComicChapterDetailRequest({this.comicId, this.chapterId});

  ListComicChapterDetailRequest.fromJson(Map<String, dynamic> json) {
    comicId = json['comic_id'];
    chapterId = json['chapter_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comic_id'] = this.comicId;
    data['chapter_id'] = this.chapterId;
    return data;
  }
}

class ListComicChapterDetailResponse {
  int chapterId;
  int comicId;
  String title;
  int chapterOrder;
  int direction;
  List<String> pageUrl;
  int picnum;
  int commentCount;

  ListComicChapterDetailResponse(
      {this.chapterId,
      this.comicId,
      this.title,
      this.chapterOrder,
      this.direction,
      this.pageUrl,
      this.picnum,
      this.commentCount});

  ListComicChapterDetailResponse.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapter_id'];
    comicId = json['comic_id'];
    title = json['title'];
    chapterOrder = json['chapter_order'];
    direction = json['direction'];
    pageUrl = json['page_url'].cast<String>();
    picnum = json['picnum'];
    commentCount = json['comment_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_id'] = this.chapterId;
    data['comic_id'] = this.comicId;
    data['title'] = this.title;
    data['chapter_order'] = this.chapterOrder;
    data['direction'] = this.direction;
    data['page_url'] = this.pageUrl;
    data['picnum'] = this.picnum;
    data['comment_count'] = this.commentCount;
    return data;
  }
}

class ComicWebChapterDetail {
  int _id;
  int get id => _id;
  int _comic_id;
  int get comic_id => _comic_id;
  String _chapter_name;
  String get chapter_name => _chapter_name;
  int _chapter_order;
  int get chapter_order => _chapter_order;
  int _createtime;
  int get createtime => _createtime;
  String _folder;
  String get folder => _folder;
  List<String> _page_url;
  List<String> get page_url => _page_url;
  int _chapter_type;
  int get chapter_type => _chapter_type;
  int _chaptertype;
  int get chaptertype => _chaptertype;
  int _chapter_true_type;
  int get chapter_true_type => _chapter_true_type;
  double _chapter_num;
  double get chapter_num => _chapter_num;
  int _updatetime;
  int get updatetime => _updatetime;
  int _sum_pages;
  int get sum_pages => _sum_pages;
  int _sns_tag;
  int get sns_tag => _sns_tag;
  int _uid;
  int get uid => _uid;
  String _username;
  String get username => _username;
  String _translatorid;
  String get translatorid => _translatorid;
  String _translator;
  String get translator => _translator;
  String _link;
  String get link => _link;
  String _message;
  String get message => _message;
  String _download;
  String get download => _download;
  int _hidden;
  int get hidden => _hidden;
  int _direction;
  int get direction => _direction;
  int _filesize;
  int get filesize => _filesize;
  int _high_file_size;
  int get high_file_size => _high_file_size;
  int _picnum;
  int get picnum => _picnum;
  int _hit;
  int get hit => _hit;
  int _prev_chap_id;
  int get prev_chap_id => _prev_chap_id;
  int _comment_count;
  int get comment_count => _comment_count;

  ComicWebChapterDetail({
    int id,
    int comic_id,
    String chapter_name,
    int chapter_order,
    int createtime,
    String folder,
    List<String> page_url,
    int chapter_type,
    int chaptertype,
    int chapter_true_type,
    double chapter_num,
    int updatetime,
    int sum_pages,
    int sns_tag,
    int uid,
    String username,
    String translatorid,
    String translator,
    String link,
    String message,
    String download,
    int hidden,
    int direction,
    int filesize,
    int high_file_size,
    int picnum,
    int hit,
    int prev_chap_id,
    int comment_count,
  })  : _id = id,
        _comic_id = comic_id,
        _chapter_name = chapter_name,
        _chapter_order = chapter_order,
        _createtime = createtime,
        _folder = folder,
        _page_url = page_url,
        _chapter_type = chapter_type,
        _chaptertype = chaptertype,
        _chapter_true_type = chapter_true_type,
        _chapter_num = chapter_num,
        _updatetime = updatetime,
        _sum_pages = sum_pages,
        _sns_tag = sns_tag,
        _uid = uid,
        _username = username,
        _translatorid = translatorid,
        _translator = translator,
        _link = link,
        _message = message,
        _download = download,
        _hidden = hidden,
        _direction = direction,
        _filesize = filesize,
        _high_file_size = high_file_size,
        _picnum = picnum,
        _hit = hit,
        _prev_chap_id = prev_chap_id,
        _comment_count = comment_count;
  factory ComicWebChapterDetail.fromJson(jsonRes) {
    if (jsonRes == null) return null;
    List<String> page_url = jsonRes['page_url'] is List ? [] : null;
    if (page_url != null) {
      for (var item in jsonRes['page_url']) {
        if (item != null) {
          page_url.add(item);
        }
      }
    }

    return ComicWebChapterDetail(
      id: jsonRes['id'],
      comic_id: jsonRes['comic_id'],
      chapter_name: jsonRes['chapter_name'],
      chapter_order: jsonRes['chapter_order'],
      createtime: jsonRes['createtime'],
      folder: jsonRes['folder'],
      page_url: page_url,
      chapter_type: jsonRes['chapter_type'],
      chaptertype: jsonRes['chaptertype'],
      chapter_true_type: jsonRes['chapter_true_type'],
      chapter_num: double.tryParse(jsonRes['chapter_num'].toString()) ?? 0,
      updatetime: jsonRes['updatetime'],
      sum_pages: jsonRes['sum_pages'],
      sns_tag: jsonRes['sns_tag'],
      uid: jsonRes['uid'],
      username: jsonRes['username'],
      translatorid: jsonRes['translatorid'],
      translator: jsonRes['translator'],
      link: jsonRes['link'],
      message: jsonRes['message'],
      download: jsonRes['download'],
      hidden: jsonRes['hidden'],
      direction: jsonRes['direction'],
      filesize: jsonRes['filesize'],
      high_file_size: jsonRes['high_file_size'],
      picnum: jsonRes['picnum'],
      hit: jsonRes['hit'],
      prev_chap_id: jsonRes['prev_chap_id'],
      comment_count: jsonRes['comment_count'],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': _id,
        'comic_id': _comic_id,
        'chapter_name': _chapter_name,
        'chapter_order': _chapter_order,
        'createtime': _createtime,
        'folder': _folder,
        'page_url': _page_url,
        'chapter_type': _chapter_type,
        'chaptertype': _chaptertype,
        'chapter_true_type': _chapter_true_type,
        'chapter_num': _chapter_num,
        'updatetime': _updatetime,
        'sum_pages': _sum_pages,
        'sns_tag': _sns_tag,
        'uid': _uid,
        'username': _username,
        'translatorid': _translatorid,
        'translator': _translator,
        'link': _link,
        'message': _message,
        'download': _download,
        'hidden': _hidden,
        'direction': _direction,
        'filesize': _filesize,
        'high_file_size': _high_file_size,
        'picnum': _picnum,
        'hit': _hit,
        'prev_chap_id': _prev_chap_id,
        'comment_count': _comment_count,
      };

  @override
  String toString() {
    return json.encode(this);
  }
}
