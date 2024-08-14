import 'package:equatable/equatable.dart';

class GameModel extends Equatable {
  final String id;
  final String name;
  final String backgroundColor;
  final List<String> participants;

  const GameModel({
    required this.id,
    required this.name,
    required this.backgroundColor,
    required this.participants,
  });

  @override
  List<Object> get props => [id, name, backgroundColor, participants];

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      backgroundColor: json['backgroundColor'],
      participants: List<String>.from(json['participants']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'backgroundColor': backgroundColor,
      'participants': participants,
    };
  }
}
