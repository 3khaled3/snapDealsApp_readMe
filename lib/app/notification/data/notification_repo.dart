import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snap_deals/app/auth_feature/model_view/profile_cubit/profile_cubit.dart';
import 'package:snap_deals/app/notification/data/notification_model.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionPath = "notifications";

  // Fetch Notifications
  Stream<List<NotificationModel>> getNotifications() {
    final currentUser = ProfileCubit.instance.state.profile.id;
    return _firestore
        .collection(_collectionPath)
        .where("receiverId", isEqualTo: currentUser)
        .orderBy("date", descending: true)
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => NotificationModel.fromJson(doc.data()))
            .toList();
      },
    );
  }

  /// ✅ Add a new notification to Firestore
  Future<void> addNotification(NotificationModel notification) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(notification.id)
          .set(notification.toJson());
    } catch (e) {
      debugPrint("🔥 Error adding notification: $e");
    }
  }

  /// ✅  Mark Notification as Seen
  Future<void> markAsSeen(String id) async {
    try {
      await _firestore
          .collection(_collectionPath)
          .doc(id)
          .update({'isSeen': true});
    } catch (e) {
      debugPrint("🔥 Error updating notification: $e");
    }
  }

  /// ✅ Delete a notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore.collection(_collectionPath).doc(notificationId).delete();
    } catch (e) {
      debugPrint("🔥 Error deleting notification: $e");
    }
  }

  /// ✅ Mark all notifications as seen for a specific user
  Future<void> markAllAsSeen() async {
    try {
      final receiverId = ProfileCubit.instance.state.profile.id;
      final batch = _firestore.batch();

      // Get all unread notifications
      final querySnapshot = await _firestore
          .collection(_collectionPath)
          .where("receiverId", isEqualTo: receiverId)
          .where("isSeen", isEqualTo: false)
          .get();

      for (var doc in querySnapshot.docs) {
        batch.update(doc.reference, {"isSeen": true});
      }

      await batch.commit(); // Apply all updates in one batch
    } catch (e) {
      debugPrint("🔥 Error marking all as seen: $e");
    }
  }

  /// ✅ Delete all notifications for a specific user
  Future<void> deleteAllNotifications() async {
    try {
      final receiverId = ProfileCubit.instance.state.profile.id;
      final batch = _firestore.batch();

      // Get all notifications for the user
      final querySnapshot = await _firestore
          .collection(_collectionPath)
          .where("receiverId", isEqualTo: receiverId)
          .get();

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } catch (e) {
      debugPrint("🔥 Error deleting all notifications: $e");
    }
  }
}
