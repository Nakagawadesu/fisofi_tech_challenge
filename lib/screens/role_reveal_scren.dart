import 'package:fisofi_tech_challenge/widgets/role_reveal_hidden.dart';
import 'package:fisofi_tech_challenge/widgets/role_reveal_revealed.dart';
import 'package:flutter/material.dart';
import '../models/player.dart';
import '../controllers/reveal_controller.dart';

class RoleRevealScreen extends StatefulWidget {
  // We require the list of players to be passed into this screen
  final List<Player> players;

  const RoleRevealScreen({super.key, required this.players});

  @override
  State<RoleRevealScreen> createState() => _RoleRevealScreenState();
}

class _RoleRevealScreenState extends State<RoleRevealScreen> {
  late final RevealController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the players passed from the Setup Screen
    _controller = RevealController(widget.players);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Identity'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          final currentPlayer = _controller.currentPlayer;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: _controller.isWordRevealed
                  ? RevealedView(
                      player: currentPlayer,
                      isLastPlayer: _controller.isLastPlayer,
                      onNext: () {
                        final isFinished = _controller.nextPlayer();
                        if (isFinished) {
                          print('Navigate to Discussion Phase!');
                        }
                      },
                    )
                  : HiddenView(
                      player: currentPlayer,
                      onReveal: _controller.revealWord,
                    ),
            ),
          );
        },
      ),
    );
  }
}
