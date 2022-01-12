import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/page_wrapper.dart';
import 'package:crypto_tycoon/generated/l10n.dart';
import 'package:crypto_tycoon/resources/app_images.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/game_crypto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

part 'widgets/circle_assets_widget.dart';
part 'widgets/wallet_widget.dart';

class WalletTokensPage extends StatelessWidget {
  const WalletTokensPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageWrapperWidget(
      child: ColoredBox(
        color: AppColors.mainGrey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: const [
              SizedBox(height: 8),
              _CircleAssetsWidget(),
              SizedBox(height: 20),
              Expanded(child: _WalletWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
