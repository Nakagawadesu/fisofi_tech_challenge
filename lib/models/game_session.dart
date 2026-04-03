import 'package:fisofi_tech_challenge/models/player.dart';

class GameSession {
  final List<Player> players;
  int roundNumber;

  GameSession({required this.players, this.roundNumber = 1});

  // A handy getter that only returns players who are still alive
  List<Player> get activePlayers =>
      players.where((player) => !player.isEliminated).toList();
}
