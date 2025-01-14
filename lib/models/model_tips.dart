import 'package:cloud_firestore/cloud_firestore.dart';

class Tip {
  final String date;
  final String leagueName;
  final String message;
  final String odds;
  final String results;
  final String status;
  final String team1;
  final String team2;
  final String time;
  final String tipsName;

  Tip({
    required this.date,
    required this.leagueName,
    required this.message,
    required this.odds,
    required this.results,
    required this.status,
    required this.team1,
    required this.team2,
    required this.time,
    required this.tipsName,
  });

  // Factory constructor to create an object from a Map (for Firestore data)
  factory Tip.fromMap(Map<String, dynamic> map) {
    return Tip(
      date: map['date'] ?? '',
      leagueName: map['league_name'] ?? '',
      message: map['message'] ?? '',
      odds: map['odds'] ?? '',
      results: map['results'] ?? '',
      status: map['status'] ?? '',
      team1: map['team_1'] ?? '',
      team2: map['team_2'] ?? '',
      time: map['time'] ?? '',
      tipsName: map['tips_name'] ?? '',
    );
  }

  // Factory constructor to create an object from Firestore DocumentSnapshot
  factory Tip.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Tip(
      date: data['date'] ?? '',
      leagueName: data['league_name'] ?? '',
      message: data['message'] ?? '',
      odds: data['odds'] is double ? data['odds'].toString() : data['odds'] ?? '',
      results: data['results'] ?? '',
      status: data['status'] ?? '',
      team1: data['team_1'] ?? '',
      team2: data['team_2'] ?? '',
      time: data['time'] ?? '',
      tipsName: data['tips_name'] ?? '',
    );
  }

  // Method to convert the object back to a Map (useful for saving to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'league_name': leagueName,
      'message': message,
      'odds': odds,
      'results': results,
      'status': status,
      'team_1': team1,
      'team_2': team2,
      'time': time,
      'tips_name': tipsName,
    };
  }
}
