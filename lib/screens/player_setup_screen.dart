import 'package:fisofi_tech_challenge/controllers/game_setup_controller.dart';
import 'package:fisofi_tech_challenge/models/game_session.dart';
import 'package:fisofi_tech_challenge/screens/role_reveal_screen.dart';
import 'package:flutter/material.dart';
import 'package:fisofi_tech_challenge/widgets/primary_button.dart';
import 'package:fisofi_tech_challenge/widgets/number_slider.dart';

class PlayerSetupScreen extends StatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  // Instantiate the controller here
  final GameSetupController _controller = GameSetupController();

  @override
  void dispose() {
    _controller.dispose(); // Clean up when leaving the screen
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Game Setup')),

      // ListenableBuilder listens to the controller and rebuilds when data changes
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                NumberSlider(
                  title: 'Total Players',
                  min: _controller.minPlayers,
                  max: _controller.maxPlayers,
                  currentValue: _controller.playerCount,
                  onChanged: _controller
                      .updatePlayerCount, // Point to the controller's logic
                ),

                const SizedBox(height: 16),

                //  The List of Names
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.nameControllers.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextField(
                          controller: _controller.nameControllers[index],
                          // Trigger the validation every time they type!
                          onChanged: (value) {
                            _controller.validateAllNames();
                          },
                          decoration: InputDecoration(
                            labelText: 'Player ${index + 1}',

                            errorText: _controller.nameErrors[index],
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.person),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    // Expanded makes the first button take up half the space
                    Expanded(
                      child: PrimaryButton(
                        text: 'Go Back', // Shortened so it doesn't overflow
                        icon: Icons.home,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),

                    const SizedBox(
                      width: 12,
                    ), // Adds a horizontal gap between them
                    // Expanded makes the second button take up the other half
                    Expanded(
                      child: PrimaryButton(
                        text: 'Start', // Shortened so it doesn't overflow
                        icon: Icons.play_arrow,
                        onPressed: _controller.hasErrors
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please fix the errors before starting.',
                                    ),
                                  ),
                                );
                              }
                            : () {
                                //  Generate the raw list of players
                                final activePlayers = _controller
                                    .generatePlayers();

                                //  NEW: Wrap them in your GameSession model
                                final newSession = GameSession(
                                  players: activePlayers,
                                );

                                // Push to the reveal screen, passing the entire session
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RoleRevealScreen(session: newSession),
                                  ),
                                );
                              },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
