import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'data_serializer.dart';
import 'query_builder.dart';

class DatabaseService<T> {
  String collectionID;
  DataSerializer<T> serializer;
  late CollectionReference _collectionReference;
  final StreamController<List<T>> _streamController =
      StreamController<List<T>>.broadcast();
  final StreamController<T> _docStreamController =
      StreamController<T>.broadcast();

  DatabaseService({required this.collectionID, required this.serializer}) {
    _collectionReference = FirebaseFirestore.instance.collection(collectionID);
  }

  Stream<List<T>> notifyOnChange({QueryBuilder? queryBuilder}) {
    (queryBuilder == null ? _collectionReference : queryBuilder.query)
        .snapshots()
        .listen((event) {
      List<T> objectCollection = List.from(
        event.docs.map(
          (doc) => serializer.fromJson(
            id: doc.id,
            data: doc.data() as Map,
          ),
        ),
      );
      if (!_streamController.isClosed) {
        _streamController.add(objectCollection);
      }
    });

    return _streamController.stream;
  }

  Stream<T?> notifyOnDocumentChangeWith({required String id}) {
    _collectionReference.doc(id).snapshots().listen(
      (event) {
        if (event.data() != null) {
          T object =
              serializer.fromJson(id: event.id, data: event.data() as Map);
          if (!_docStreamController.isClosed) {
            _docStreamController.add(object);
          }
        }
      },
    );

    return _docStreamController.stream;
  }

  String generateID() {
    return _collectionReference.doc().id;
  }

  create({
    String? id,
    required T object,
  }) async {
    try {
      await _collectionReference.doc(id).set(serializer.toJson(object: object));
    } catch (e) {
      log("Error occured in $runtimeType process the create function with message - $e");
      rethrow;
    }
  }

  Future<T?> read({
    required String id,
  }) async {
    var snapshot = (await _collectionReference.doc(id).get());
    var data = snapshot.data() as Map?;
    if (data == null) {
      return null;
    } else if (data.isEmpty) {
      return null;
    }
    return serializer.fromJson(id: snapshot.id, data: data);
  }

  update({
    required String id,
    required T updatedObject,
  }) async {
    try {
      await _collectionReference.doc(id).update(
            serializer.toJson(object: updatedObject),
          );
    } catch (e) {
      log("Error occured in $runtimeType with message - $e");
      rethrow;
    }
  }

  appendToArray({
    required String id,
    required String key,
    required List value,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    await _collectionReference
        .doc(id)
        .update({key: FieldValue.arrayUnion(value)})
        .then((value) => onSuccess())
        .catchError((error) => onError(error));
  }

  removeFromArray({
    required String id,
    required String key,
    required List value,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    await _collectionReference
        .doc(id)
        .update({key: FieldValue.arrayRemove(value)})
        .then((value) => onSuccess())
        .catchError((err) => onError(err));
  }

  updateTimeStamp({
    required String id,
    required String key,
  }) async {
    await _collectionReference
        .doc(id)
        .update({key: FieldValue.serverTimestamp()});
  }

  Future<bool> documentExists({required String id}) async {
    return (await _collectionReference.doc(id).get()).exists;
  }

  close() {
    _streamController.close();
    _docStreamController.close();
  }
}
