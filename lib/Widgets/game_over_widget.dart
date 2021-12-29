import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/game_button_widget.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/resources/resources.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/game_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class ModalGameOverWidget extends StatelessWidget {
  const ModalGameOverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gameOver = context.select((GameViewModel vm) => vm.state.gameOver);
    final isModalGameOverClose = context.select((GameViewModel vm) => vm.state.isModalGameOverClose);
    final vm = context.read<GameViewModel>();
    if (gameOver && !isModalGameOverClose) {
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ColoredBox(
          color: AppColors.black50,
          child: Center(
            child: SizedBox(
              height: 200,
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.black,
                  border: Border.all(color: AppColors.green),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: Stack(
                    children: [
                      Image.asset(
                        AppBackgroundImages.gameOverScreen,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              S.of(context).game_global_modal_game_over_title,
                              textAlign: TextAlign.center,
                              style: AppFonts.clicker.copyWith(color: AppColors.white),
                            ),
                            const SizedBox(height: 16),
                            GameButtonWidget.white(
                              text: S.of(context).game_global_modal_game_over_return,
                              onPressed: () => vm.onExitGameOverPressed(context),
                            ),
                            const SizedBox(height: 16),
                            GameButtonWidget.white(
                              text: S.of(context).game_global_modal_game_over_statistic,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
