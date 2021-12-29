import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/game_button_widget.dart';
import 'package:crypto_idle/Widgets/page_wrapper.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/resources/app_images.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/game_market_flat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

part 'widgets/flats_widget.dart';

class MarketFlatPage extends StatelessWidget {
  const MarketFlatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapperWidget(
      child: ColoredBox(
        color: AppColors.mainGrey,
        child: Column(
          children: const [
            _TitleWidget(),
            Expanded(child: _FlatsWidget()),
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
        S.of(context).game_market_flat_title,
        style: AppFonts.main.copyWith(color: AppColors.white),
      ),
    );
  }
}
