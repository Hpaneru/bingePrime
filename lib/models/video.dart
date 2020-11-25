class Video {
  String id, title, link, description, category, created, creator, iconUrl;

  static Video fromMap(var data) {
    return Video()
      ..id = data["id"]
      ..title = data["title"]
      ..link = data["link"]
      ..description = data["description"]
      ..iconUrl = data["iconUrl"];
  }

  toMap() {
    return {
      "id": id,
      "title": title,
      "link": link,
      "description": description,
      "category": category,
      "created": created,
      "creator": creator,
      "iconUrl": iconUrl,
    };
  }
}
