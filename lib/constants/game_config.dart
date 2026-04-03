import 'dart:math';

class GameConfig {
  //  The Predefined Word Pairs
  static const List<Map<String, String>> wordPairs = [
    {'majority': 'Cat', 'minority': 'Tiger'},
    {'majority': 'Coffee', 'minority': 'Tea'},
    {'majority': 'Ship', 'minority': 'Boat'},
    {'majority': 'Apple', 'minority': 'Pear'},
    {'majority': 'Guitar', 'minority': 'Bass'},
  ];

  // Dynamic Undercover Math
  static int getRandomUndercoverCount(int totalPlayers) {
    final random = Random();

    if (totalPlayers <= 4) {
      return 1; // 3-4 players: strictly 1 undercover
    } else if (totalPlayers <= 6) {
      return random.nextInt(2) + 1; // 5-6 players: 1 to 2
    } else if (totalPlayers <= 8) {
      return random.nextInt(2) + 2; // 7-8 players: 2 to 3
    } else if (totalPlayers <= 10) {
      return random.nextInt(3) + 2; // 9-10 players: 2 to 4
    } else {
      return random.nextInt(3) + 3; // 11-12 players: 3 to 5
    }
  }
}
