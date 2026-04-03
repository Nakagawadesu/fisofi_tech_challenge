import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/game_session.dart';

class GameSessionController extends ChangeNotifier {
  final GameSession session;

  // The temporary state map
  Map<Player, int> votes = {};

  GameSessionController(this.session) {
    _initializeVotes();
  }

  // Gets the total number of votes currently cast
  int get totalVotesCast => votes.values.fold(0, (sum, count) => sum + count);

  // Checks if everyone has voted
  bool get allVotesCast => totalVotesCast == session.activePlayers.length;

  // Resets the map for a new round
  void _initializeVotes() {
    votes.clear();
    for (var player in session.activePlayers) {
      votes[player] = 0;
    }
    notifyListeners();
  }

  void addVote(Player player) {
    if (totalVotesCast < session.activePlayers.length) {
      votes[player] = (votes[player] ?? 0) + 1;
      notifyListeners();
    }
  }

  void removeVote(Player player) {
    if ((votes[player] ?? 0) > 0) {
      votes[player] = votes[player]! - 1;
      notifyListeners();
    }
  }

  // Returns the eliminated player, or null if it was a tie.
  Player? tallyVotesAndEliminate() {
    int maxVotes = 0;
    Player? eliminatedPlayer;
    bool isTie = false;

    votes.forEach((player, voteCount) {
      if (voteCount > maxVotes) {
        maxVotes = voteCount;
        eliminatedPlayer = player;
        isTie = false; // Reset tie flag if we found a new highest
      } else if (voteCount == maxVotes && maxVotes > 0) {
        isTie = true; // Two people have the same highest votes
      }
    });

    if (isTie || eliminatedPlayer == null) {
      return null; // Nobody is eliminated
    } else {
      eliminatedPlayer!.isEliminated = true; // Mark them dead!
      return eliminatedPlayer;
    }
  }

  // Call this to move to the next round if the game isn't over
  void startNextRound() {
    session.roundNumber++;
    _initializeVotes();
  }
}
