class TipStats {
  final int totalTips;
  final double winRate;
  final double roi;
  final int winningTips;
  final int losingTips;

  TipStats({
    required this.totalTips,
    required this.winRate,
    required this.roi,
    required this.winningTips,
    required this.losingTips,
  });

  factory TipStats.fromFirestore(Map<String, dynamic> data) {
    return TipStats(
      totalTips: data['total_tips'] ?? 0,
      winRate: (data['win_rate'] ?? 0).toDouble(),
      roi: (data['roi'] ?? 0).toDouble(),
      winningTips: data['winning_tips'] ?? 0,
      losingTips: data['losing_tips'] ?? 0,
    );
  }
}