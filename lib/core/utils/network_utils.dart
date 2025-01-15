import 'dart:io';
import 'package:dartz/dartz.dart'; // For Either
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';

import 'failure_model.dart';

class NetworkUtils {
  // Firebase instances
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;
  static final FirebaseDatabase _database = FirebaseDatabase.instance;

  /// Handle requests with Either for error handling
  static Future<Either<Failure, T>> handleRequest<T>(
    Future<T> Function() requestFunction,
  ) async {
    try {
      final result = await requestFunction();
      return Right(result);
    } catch (e) {
      final failure = Failure.fromFirebaseException(e);
      print("Error: $failure");
      return Left(failure);
    }
  }

  // --------------------- Firebase Authentication ---------------------

  /// Sign in with email and password
  static Future<User?> signInWithEmail(String email, String password) async {
    final UserCredential userCredential =
        await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  /// Sign up with email and password
  static Future<User?> signUpWithEmail(String email, String password) async {
    final UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  /// Sign out the current user
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // --------------------- Firestore Database ---------------------

  /// Add a document to Firestore
  static Future<void> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    if (documentId != null) {
      await _firestore.collection(collectionPath).doc(documentId).set(data);
    } else {
      await _firestore.collection(collectionPath).add(data);
    }
  }

  /// Get a document from Firestore
  static Future<DocumentSnapshot> getDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    return await _firestore.collection(collectionPath).doc(documentId).get();
  }

  /// Get all documents from a Firestore collection
  static Future<QuerySnapshot> getCollection({
    required String collectionPath,
  }) async {
    return await _firestore.collection(collectionPath).get();
  }

  /// Update a document in Firestore
  static Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(documentId).update(data);
  }

  /// Delete a document from Firestore
  static Future<void> deleteDocument({
    required String collectionPath,
    required String documentId,
  }) async {
    await _firestore.collection(collectionPath).doc(documentId).delete();
  }

  // --------------------- Firebase Storage ---------------------

  /// Upload a file to Firebase Storage
  static Future<String> uploadFile({
    required String storagePath,
    required String filePath,
  }) async {
    final fileRef = _storage.ref(storagePath);
    await fileRef.putFile(File(filePath));
    return await fileRef.getDownloadURL();
  }

  /// Delete a file from Firebase Storage
  static Future<void> deleteFile(String storagePath) async {
    final fileRef = _storage.ref(storagePath);
    await fileRef.delete();
  }

  // --------------------- Firebase Realtime Database ---------------------

  /// Add or update a data node in Realtime Database
  static Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _database.ref(path).set(data);
  }

  /// Get data from Realtime Database
  static Future<DataSnapshot> getData(String path) async {
    return await _database.ref(path).get();
  }

  /// Delete a data node in Realtime Database
  static Future<void> deleteData(String path) async {
    await _database.ref(path).remove();
  }
}
