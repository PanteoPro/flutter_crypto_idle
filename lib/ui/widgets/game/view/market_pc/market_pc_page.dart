import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/game_button_widget.dart';
import 'package:crypto_tycoon/Widgets/page_wrapper.dart';
import 'package:crypto_tycoon/domain/entities/pc.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/resources/app_images.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/music_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

part 'widgets/pcs_widget.dart';

class MarketPCPage extends StatelessWidget {
  const MarketPCPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapperWidget(
      child: ColoredBox(
        color: AppColors.mainGrey,
        child: Column(
          children: const [
            _TitleWidget(),
            Expanded(child: _PCsWidget()),
          ],
        ),
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        S.of(context).game_market_pc_title,
        style: AppFonts.main.copyWith(color: AppColors.white),
      ),
    );
  }
}
