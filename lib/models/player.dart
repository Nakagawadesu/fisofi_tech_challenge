enum Role { citizen, undercover }

class Player {
  final String name;
  final Role role;
  final String secretWord;
  bool isEliminated;

  Player({
    required this.name,
    required this.role,
    required this.secretWord,
    this.isEliminated = false,
  });

  @override
  String toString() {
    return 'Player(name: $name, role: ${role.name}, word: $secretWord)';
  }
}
