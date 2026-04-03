import 'package:flutter/material.dart';
import '../../../models/player.dart';
import '../../../widgets/primary_button.dart';

class ResultDialog extends StatelessWidget {
  final Player? eliminatedPlayer;
  final VoidCallback onContinue;

  const ResultDialog({
    super.key,
    required this.eliminatedPlayer,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        eliminatedPlayer == null ? 'It\'s a Tie!' : 'Player Eliminated',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (eliminatedPlayer == null) ...[
            const Icon(Icons.balance, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            const Text('The votes were tied. No one is eliminated this round!'),
          ] else ...[
            const Icon(Icons.person_remove, size: 60, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              eliminatedPlayer!.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Their role was: ${eliminatedPlayer!.role.name.toUpperCase()}',
            ),
          ],
        ],
      ),
      actions: [
        Center(
          child: PrimaryButton(
            text: 'Continue',
            icon: Icons.arrow_forward,
            onPressed: onContinue, // Uses the passed-in logic
          ),
        ),
      ],
    );
  }
}
