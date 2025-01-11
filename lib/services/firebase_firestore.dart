import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:football_tips/models/model_tips.dart';
// Import the Tip model

class TipService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch and sort tips by date
  Future<List<Tip>> fetchTips() async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('free') // Replace 'tips' with your collection name
          .orderBy('date', descending: true)
          .get();

      // Convert the snapshot data to a list of Tip objects
      return snapshot.docs.map((doc) {
        return Tip.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching tips: $e");
      return [];
    }
  }
}
