class BettingTip {
  final String id;
  final String date;
  final String leagueName;
  final String odds;
  final String results;
  final String status;
  final String team1;
  final String team2;
  final String time;
  final String tipsName;

  BettingTip({
    required this.id,
    required this.date,
    required this.leagueName,
    required this.odds,
    required this.results,
    required this.status,
    required this.team1,
    required this.team2,
    required this.time,
    required this.tipsName,
  });

  factory BettingTip.fromFirestore(Map<String, dynamic> data, [String? id]) {
    return BettingTip(
      id: id ?? '',
      date: data['date'] ?? '',
      leagueName: data['league_name'] ?? '',
      odds: data['odds'] ?? '',
      results: data['results'] ?? '',
      status: data['status'] ?? '',
      team1: data['team_1'] ?? '',
      team2: data['team_2'] ?? '',
      time: data['time'] ?? '',
      tipsName: data['tips_name'] ?? '',
    );
  }
}