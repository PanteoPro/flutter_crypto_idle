import 'package:crypto_idle/Widgets/buttons.dart';
import 'package:crypto_idle/generated/l10n.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuSettingsPage extends StatelessWidget {
  const MenuSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.select((MainAppViewModel vm) => vm.locale);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).menu_settings_title,
          style: const TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: const [
            _BackgroundWidget(),
            _ContentWidget(),
          ],
        ),
      ),
    );
  }
}

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainAppViewModel>();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: MyButton(
                color: Theme.of(context).splashColor,
                onPressed: vm.setLocaleRu,
                title: S.of(context).menu_settings_swap_ru_button_title,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: MyButton(
                color: Theme.of(context).splashColor,
                onPressed: vm.setLocaleEn,
                title: S.of(context).menu_settings_swap_en_button_title,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackgroundWidget extends StatelessWidget {
  const _BackgroundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
    );
  }
}
