import 'package:flutter/material.dart';
import '../../../models/player.dart';

class VotingPlayerTile extends StatelessWidget {
  final Player player;
  final int votes;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const VotingPlayerTile({
    super.key,
    required this.player,
    required this.votes,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          player.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Votes: $votes'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.red,
              onPressed: onRemove,
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.green,
              onPressed: onAdd,
            ),
          ],
        ),
      ),
    );
  }
}
