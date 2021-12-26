import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/buttons/game_button_widget.dart';
import 'package:crypto_idle/Widgets/page_wrapper.dart';
import 'package:crypto_idle/domain/entities/pc.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_pc_view_model.dart';
import 'package:crypto_idle/ui/widgets/music_view_model.dart';
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
            _TitlePage(),
            Expanded(child: _PCsWidget()),
          ],
        ),
      ),
    );
  }
}

class _TitlePage extends StatelessWidget {
  const _TitlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        'Покупка установок',
        style: AppFonts.main.copyWith(color: AppColors.white),
      ),
    );
  }
}
