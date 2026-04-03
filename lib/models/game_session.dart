import 'player.dart';

class GameSession {
  final List<Player> players;
  int roundNumber;

  GameSession({required this.players, this.roundNumber = 1});

  List<Player> get activePlayers =>
      players.where((player) => !player.isEliminated).toList();

  int get totalActivePlayers => activePlayers.length;

  int get activeUndercovers =>
      activePlayers.where((player) => player.role == Role.undercover).length;

  int get activeCitizens =>
      activePlayers.where((player) => player.role == Role.citizen).length;
}
