
class Verse{
  late String book;
  late String chapter;
  late String verse;
  late String link;

  Verse({
    required this.book,
    required this.chapter,
    required this.verse,
    required this.link
  });

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["book"] = book;
    map["chapter"] = chapter;
    map["vers"] = verse;
    map["link"] = link;
    return map;
  }


  Verse.fromJson(dynamic o) {
    this.book = o["book"] as String;
    this.chapter = o["chapter"] as String;
    this.verse = o["vers"] as String;
    this.link = o["link"] as String;
  }
}