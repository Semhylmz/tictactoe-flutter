class GameModel {
  final String gameId;
  final String gameName;
  final String gameColor;
  final List<String> board;
  final String currentPlayer;
  final String player1Id;
  final String player2Id;
  final String player1Symbol; // 'X'
  final String player2Symbol; // 'O'
  final bool isGameOver;
  final String? winnerId;

  const GameModel({
    required this.gameName,
    required this.gameColor,
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

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      gameName: json['gameName'],
      gameColor: json['gameColor'],
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
      'gameName': gameName,
      'gameId': gameId,
      'gameColor': gameColor,
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
