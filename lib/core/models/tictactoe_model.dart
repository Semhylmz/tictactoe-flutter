class TicTacToeModel {
  final String gameId;
  final List<String> board; // 9 hücreli oyun tahtası
  final String currentPlayer; // Kim oynuyor
  final String player1Id;
  final String player2Id;
  final String player1Symbol; // 'X'
  final String player2Symbol; // 'O'
  final bool isGameOver;
  final String? winnerId;

  const TicTacToeModel({
    required this.gameId,
    required this.board,
    required this.currentPlayer,
    required this.player1Id,
    required this.player2Id,
    required this.player1Symbol,
    required this.player2Symbol,
    required this.isGameOver,
    this.winnerId,
  });

  factory TicTacToeModel.fromJson(Map<String, dynamic> json) {
    return TicTacToeModel(
      gameId: json['gameId'],
      board: List<String>.from(json['board']),
      currentPlayer: json['currentPlayer'],
      player1Id: json['player1Id'],
      player2Id: json['player2Id'],
      player1Symbol: json['player1Symbol'],
      player2Symbol: json['player2Symbol'],
      isGameOver: json['isGameOver'],
      winnerId: json['winnerId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'board': board,
      'currentPlayer': currentPlayer,
      'player1Id': player1Id,
      'player2Id': player2Id,
      'player1Symbol': player1Symbol,
      'player2Symbol': player2Symbol,
      'isGameOver': isGameOver,
      'winnerId': winnerId,
    };
  }
}
