import '../model/tag.dart';
import 'base_provider.dart';

class TagProvider extends BaseProvider<Tag> {
  TagProvider() : super("Tag");

  @override
  Tag fromJson(data) {
    // TODO: implement fromJson
    return Tag.fromJson(data);
  }
}
