import 'package:crypto_idle/ui/widgets/game/view_models/game_view_model.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/main_game/main_game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class GameOverModalWidget extends StatelessWidget {
  const GameOverModalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameOver = context.select((GameViewModel vm) => vm.state.gameOver);
    final isModalGameOverClose = context.select((GameViewModel vm) => vm.state.isModalGameOverClose);
    final vm = context.read<GameViewModel>();
    if (gameOver && !isModalGameOverClose) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => vm.onExitGameOverPressed(context),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Вы проиграли!'),
                    Text('У вас закончились деньги!'),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
    return const SizedBox();
  }
}
