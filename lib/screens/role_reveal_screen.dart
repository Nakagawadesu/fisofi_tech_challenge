import 'package:fisofi_tech_challenge/screens/voting_screen.dart';
import 'package:fisofi_tech_challenge/widgets/role_reveal_hidden.dart';
import 'package:fisofi_tech_challenge/widgets/role_reveal_revealed.dart';
import 'package:flutter/material.dart';
import 'package:fisofi_tech_challenge/models/game_session.dart';
import 'package:fisofi_tech_challenge/controllers/reveal_controller.dart'; // Make sure this matches your file name!
// Required for the transition

class RoleRevealScreen extends StatefulWidget {
  final GameSession session;

  const RoleRevealScreen({super.key, required this.session});

  @override
  State<RoleRevealScreen> createState() => _RoleRevealScreenState();
}

class _RoleRevealScreenState extends State<RoleRevealScreen> {
  late final RevealController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the players inside the session
    _controller = RevealController(widget.session.players);
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
        automaticallyImplyLeading:
            false, // ANTI-CHEAT: Removes the back button!
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
                          // Pass the unbroken session directly to the Voting Screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VotingScreen(session: widget.session),
                            ),
                          );
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
