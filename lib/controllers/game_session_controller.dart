import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/game_session.dart';

enum GameWinner { none, citizens, undercovers }

class GameSessionController extends ChangeNotifier {
  final GameSession session;
  Map<Player, int> votes = {};

  GameSessionController(this.session) {
    _initializeVotes();
  }

  int get totalVotesCast => votes.values.fold(0, (sum, count) => sum + count);
  bool get allVotesCast => totalVotesCast == session.activePlayers.length;

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

  Player? tallyVotesAndEliminate() {
    int maxVotes = 0;
    Player? eliminatedPlayer;
    bool isTie = false;

    votes.forEach((player, voteCount) {
      if (voteCount > maxVotes) {
        maxVotes = voteCount;
        eliminatedPlayer = player;
        isTie = false;
      } else if (voteCount == maxVotes && maxVotes > 0) {
        isTie = true;
      }
    });

    if (isTie || eliminatedPlayer == null) {
      return null;
    } else {
      eliminatedPlayer!.isEliminated = true;
      return eliminatedPlayer;
    }
  }

  //  Win Condition Logic
  GameWinner checkWinCondition() {
    //Rule 1: Citizens win if the Undercover is eliminated
    if (session.activeUndercovers == 0) {
      return GameWinner.citizens;
    }
    //Rule 2: Undercover wins if only two players remain (the Undercover and one Citizen)
    // (Plus the safety net for multiple undercovers)
    else if ((session.totalActivePlayers == 2 &&
            session.activeUndercovers == 1) ||
        session.activeUndercovers >= session.activeCitizens) {
      return GameWinner.undercovers;
    }

    //No win condition met yet, keep playing!
    return GameWinner.none;
  }

  void startNextRound() {
    session.roundNumber++;
    _initializeVotes();
  }
}
