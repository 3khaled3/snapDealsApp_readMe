import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

enum FailureType {
  network,
  authentication,
  server,
  permission,
  validation,
  unknown,
}

class Failure {
  final FailureType type;
  final String message;
  final String? code;

  Failure({
    required this.type,
    required this.message,
    this.code,
  });

  /// Factory method to create a Failure from Firebase exceptions
  factory Failure.fromFirebaseException(dynamic exception) {
    if (exception is FirebaseException) {
      switch (exception.code) {
        case 'invalid-email':
          return Failure(
            type: FailureType.validation,
            message: 'The email address is not valid.',
            code: exception.code,
          );
        case 'user-disabled':
          return Failure(
            type: FailureType.authentication,
            message: 'This user account has been disabled.',
            code: exception.code,
          );
        case 'user-not-found':
          return Failure(
            type: FailureType.authentication,
            message: 'No user found with this email.',
            code: exception.code,
          );
        case 'wrong-password':
          return Failure(
            type: FailureType.authentication,
            message: 'The password is incorrect.',
            code: exception.code,
          );
        case 'email-already-in-use':
          return Failure(
            type: FailureType.validation,
            message: 'This email address is already in use.',
            code: exception.code,
          );
        case 'permission-denied':
          return Failure(
            type: FailureType.permission,
            message: 'You do not have permission to perform this operation.',
            code: exception.code,
          );
        case 'unavailable':
          return Failure(
            type: FailureType.server,
            message:
                'The service is temporarily unavailable. Please try again later.',
            code: exception.code,
          );
        default:
          return Failure(
            type: FailureType.unknown,
            message: exception.message ?? 'An unknown error occurred.',
            code: exception.code,
          );
      }
    } else if (exception is SocketException) {
      return Failure(
        type: FailureType.network,
        message:
            'No Internet connection. Please check your network and try again.',
      );
    } else {
      return Failure(
        type: FailureType.unknown,
        message: exception.toString(),
      );
    }
  }

  @override
  String toString() {
    return 'Failure(type: $type, message: $message, code: $code)';
  }
}
