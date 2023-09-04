abstract class DataSerializer<T> {
  T fromJson({required String id, required Map data});
  Map<String, dynamic> toJson({required T object});
}
