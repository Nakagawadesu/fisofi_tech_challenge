import 'package:flutter/material.dart';
import '../models/player.dart';

class RevealController extends ChangeNotifier {
  // The data passed in from the setup phase
  final List<Player> players;

  // State variables for the UI
  int currentPlayerIndex = 0;
  bool isWordRevealed = false;

  // Constructor requires the generated list of players
  RevealController(this.players);

  //  getters to keep our UI code incredibly clean
  Player get currentPlayer => players[currentPlayerIndex];
  bool get isLastPlayer => currentPlayerIndex == players.length - 1;

  void revealWord() {
    isWordRevealed = true;
    notifyListeners();
  }

  // Returns true if the game should move to the voting phase
  bool nextPlayer() {
    if (isLastPlayer) {
      return true; // Signal the UI to navigate to the next major phase
    } else {
      currentPlayerIndex++;
      isWordRevealed = false; // Instantly hide the screen for the next person
      notifyListeners();
      return false; // Keep looping through players
    }
  }
}
