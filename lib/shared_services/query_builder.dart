import 'package:cloud_firestore/cloud_firestore.dart';

class QueryBuilder {
  late Query _query;

  QueryBuilder({
    required String collectionID,
    String? orderByKey,
    bool descending = false,
  }) {
    _query = FirebaseFirestore.instance
        .collection(collectionID)
        .orderBy(orderByKey ?? FieldPath.documentId, descending: descending);
  }

  Query get query {
    return _query;
  }

  add({required Query Function(Query) builder}) {
    _query = builder(_query);
  }
}
