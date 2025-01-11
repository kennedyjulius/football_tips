import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_tips/models/model_tips.dart';
import 'package:football_tips/models/vippackage_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Tips related methods
  // Stream<List<BettingTip>> getFreeTips() {
  //   return _firestore
  //       .collection('free')
  //       .where('status', isEqualTo: 'pending')
  //       .orderBy('time')
  //       .snapshots()
  //       .map((snapshot) {
  //         return snapshot.docs
  //             .map((doc) => BettingTip.fromFirestore(doc.data()))
  //             .toList();
  //       });
  // }

  Future<List<Map<String, dynamic>>> getDailyTips() async {
  try {
    QuerySnapshot snapshot = await _firestore.collection('free').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  } catch (e) {
    throw Exception('Failed to fetch daily tips: $e');
  }
}


  Stream<List<BettingTip>> getHistoryTips() {
    return _firestore
        .collection('tips')
        .where('status', isNotEqualTo: 'pending')
        .orderBy('status')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => BettingTip.fromFirestore(doc.data()))
              .toList();
        });
  }

  // VIP related methods
  // Future<List<VIPPackage>> getVIPPackages() async {
  //   final snapshot = await _firestore.collection('vip_packages').get();
  //   return snapshot.docs
  //       .map((doc) => VIPPackage.fromFirestore(doc.data()))
  //       .toList();
  // }

  // Stream<List<VIPTip>> getVIPTips() {
  //   return _firestore
  //       .collection('vip_tips')
  //       .where('status', isEqualTo: 'pending')
  //       .orderBy('time')
  //       .snapshots()
  //       .map((snapshot) {
  //         return snapshot.docs
  //             .map((doc) => VIPTip.fromFirestore(doc.data()))
  //             .toList();
  //       });
  // }

  // Statistics methods
  // Future<TipStats> getTipStats() async {
  //   final snapshot = await _firestore.collection('stats').doc('tips_stats').get();
  //   return TipStats.fromFirestore(snapshot.data() ?? {});
  // }
}