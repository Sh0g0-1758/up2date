import 'package:hive/hive.dart';

part 'storage.g.dart';

@HiveType(typeId: 0)
class Storage extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? description;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  DateTime? publishedAt;
  @HiveField(7)
  String? content;
}
