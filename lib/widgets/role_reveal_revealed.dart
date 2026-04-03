import 'package:fisofi_tech_challenge/models/player.dart';
import 'package:fisofi_tech_challenge/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class RevealedView extends StatelessWidget {
  final Player player;
  final bool isLastPlayer;
  final VoidCallback onNext;

  const RevealedView({
    super.key,
    required this.player,
    required this.isLastPlayer,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.fingerprint, size: 80, color: Colors.deepPurpleAccent),
        const SizedBox(height: 24),
        Text('You are a', style: Theme.of(context).textTheme.titleLarge),
        Text(
          player.role == Role.undercover ? 'Undercover' : 'Citizen',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: player.role == Role.undercover
                ? Colors.redAccent
                : Colors.greenAccent,
          ),
        ),
        const SizedBox(height: 24),
        const Text('Your secret word is:', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        Text(
          player.secretWord,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 48),
        PrimaryButton(
          text: isLastPlayer ? 'Start Discussion' : 'Hide and Next',
          icon: isLastPlayer ? Icons.forum : Icons.visibility_off,
          onPressed: onNext, // Trigger the passed-in function!
        ),
      ],
    );
  }
}
