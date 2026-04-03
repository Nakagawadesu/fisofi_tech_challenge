import 'package:fisofi_tech_challenge/models/player.dart';
import 'package:fisofi_tech_challenge/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class HiddenView extends StatelessWidget {
  final Player player;
  final VoidCallback onReveal;

  const HiddenView({super.key, required this.player, required this.onReveal});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.screen_lock_portrait, size: 80, color: Colors.grey),
        const SizedBox(height: 24),
        Text(
          'Pass the phone to',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(
          player.name,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurpleAccent,
          ),
        ),
        const SizedBox(height: 48),
        PrimaryButton(
          text: 'Tap to Reveal',
          icon: Icons.visibility,
          onPressed: onReveal, // Trigger the passed-in function!
        ),
      ],
    );
  }
}
