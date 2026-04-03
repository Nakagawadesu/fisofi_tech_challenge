import 'package:fisofi_tech_challenge/screens/player_setup_screen.dart';
import 'package:fisofi_tech_challenge/widgets/game_result_dialog.dart';
import 'package:flutter/material.dart';
import '../models/player.dart';
import '../models/game_session.dart';
import '../controllers/game_session_controller.dart';
import '../widgets/primary_button.dart';

class VotingScreen extends StatefulWidget {
  final GameSession session;

  const VotingScreen({super.key, required this.session});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  late final GameSessionController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GameSessionController(widget.session);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showResultDialog(Player? eliminatedPlayer) {
    // 1. Check if the game is over!
    final winner = _controller.checkWinCondition();

    showDialog(
      context: context,
      barrierDismissible: false, // Force them to click a button
      builder: (BuildContext context) {
        // SCENARIO A: GAME OVER
        if (winner != GameWinner.none) {
          final isCitizensWin = winner == GameWinner.citizens;

          return GameResultDialog(
            title: isCitizensWin ? 'Citizens Win!' : 'Undercovers Win!',
            icon: Icons.emoji_events,
            iconColor: Colors.amber,
            content: Column(
              children: [
                Text(
                  isCitizensWin
                      ? 'All Undercovers have been eliminated!'
                      : 'The Undercovers have taken over!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Game Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                // A compact list of everyone's true identities
                ..._controller.session.players.map(
                  (p) => Text(
                    '${p.name}: ${p.role.name.toUpperCase()} (${p.secretWord})',
                    style: TextStyle(
                      color: p.role == Role.undercover
                          ? Colors.red
                          : Colors.green,
                      decoration: p.isEliminated
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              PrimaryButton(
                text: 'New Game',
                icon: Icons.replay,
                onPressed: () {
                  // This completely flushes the routing stack and starts fresh!
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PlayerSetupScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          );
        }

        // SCENARIO B: NO WINNER YET - IT WAS A TIE
        if (eliminatedPlayer == null) {
          return GameResultDialog(
            title: 'It\'s a Tie!',
            icon: Icons.balance,
            iconColor: Colors.orange,
            content: const Text(
              'The votes were tied. No one is eliminated this round!',
              textAlign: TextAlign.center,
            ),
            actions: [
              PrimaryButton(
                text: 'Next Round',
                icon: Icons.arrow_forward,
                onPressed: () {
                  Navigator.pop(context);
                  _controller.startNextRound();
                },
              ),
            ],
          );
        }

        // SCENARIO C: NO WINNER YET - SOMEONE WAS ELIMINATED
        return GameResultDialog(
          title: 'Player Eliminated',
          icon: Icons.person_remove,
          iconColor: Colors.redAccent,
          content: Column(
            children: [
              Text(
                eliminatedPlayer.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Their role was: ${eliminatedPlayer.role.name.toUpperCase()}',
              ),
            ],
          ),
          actions: [
            PrimaryButton(
              text: 'Next Round',
              icon: Icons.arrow_forward,
              onPressed: () {
                Navigator.pop(context);
                _controller.startNextRound();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round ${_controller.session.roundNumber} Voting'),
        automaticallyImplyLeading: false,
      ),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 1. The Instruction Banner
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Discuss your words! Once everyone has spoken, cast your votes below.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),

                // Vote Counter Tracker
                Text(
                  'Votes Cast: ${_controller.totalVotesCast} / ${_controller.session.activePlayers.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),

                // 2. The Active Player List
                Expanded(
                  child: ListView.builder(
                    itemCount: _controller.session.activePlayers.length,
                    itemBuilder: (context, index) {
                      final player = _controller.session.activePlayers[index];
                      final votesForPlayer = _controller.votes[player] ?? 0;

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            player.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Votes: $votesForPlayer'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                color: Colors.red,
                                onPressed: () => _controller.removeVote(player),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                color: Colors.green,
                                onPressed: () => _controller.addVote(player),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // 3. The Tally Button
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    text: 'Tally Votes',
                    icon: Icons.how_to_vote,
                    // Disable button if not everyone has voted
                    onPressed: _controller.allVotesCast
                        ? () {
                            final eliminated = _controller
                                .tallyVotesAndEliminate();
                            _showResultDialog(eliminated);
                          }
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Not all votes have been cast yet!',
                                ),
                              ),
                            );
                          },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
