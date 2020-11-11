class Video {
  String id, title, link, description, category, created, creator;

  static Video fromMap(var data) {
    return Video()
      ..id = data["id"]
      ..title = data["title"]
      ..link = data["link"]
      ..description = data["description"];
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
    };
  }
}
