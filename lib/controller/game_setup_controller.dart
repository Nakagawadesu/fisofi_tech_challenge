import 'package:flutter/material.dart';

class GameSetupController extends ChangeNotifier {
  int playerCount = 3;
  final int minPlayers = 3;
  final int maxPlayers = 12;

  final List<TextEditingController> nameControllers = [
    TextEditingController(text: 'Player 1'),
    TextEditingController(text: 'Player 2'),
    TextEditingController(text: 'Player 3'),
  ];

  // list to track error messages for each text field
  final List<String?> nameErrors = [null, null, null];

  //  check if ANY field currently has an error
  bool get hasErrors => nameErrors.any((error) => error != null);

  void updatePlayerCount(int newCount) {
    playerCount = newCount;

    while (nameControllers.length < playerCount) {
      nameControllers.add(
        TextEditingController(text: 'Player ${nameControllers.length + 1}'),
      );
      nameErrors.add(null); // Keep the errors list the same size
    }

    while (nameControllers.length > playerCount) {
      final removedController = nameControllers.removeLast();
      removedController.dispose();
      nameErrors.removeLast(); // Keep the errors list the same size
    }

    validateAllNames(); // Re-validate just in case removing a player fixed a duplicate
  }

  // 3. The Validation Engine
  void validateAllNames() {
    for (int i = 0; i < nameControllers.length; i++) {
      nameErrors[i] = null; // Reset the error to null first
      String currentName = nameControllers[i].text.trim();

      // Check if the field empty
      if (currentName.isEmpty) {
        nameErrors[i] = 'Name cannot be empty';
        continue;
      }

      // Check if there Are there duplicates
      for (int j = 0; j < nameControllers.length; j++) {
        // If it's NOT the exact same field, but the text is identical
        if (i != j && nameControllers[j].text.trim() == currentName) {
          nameErrors[i] = 'Duplicate name';
          break; // Stop checking this name, we already found an error
        }
      }
    }

    // Tell the UI to redraw the red error text
    notifyListeners();
  }

  @override
  void dispose() {
    for (var controller in nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
