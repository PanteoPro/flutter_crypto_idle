import 'package:crypto_idle/Theme/app_colors.dart';
import 'package:crypto_idle/Theme/app_fonts.dart';
import 'package:crypto_idle/Widgets/game_over_widget.dart';
import 'package:crypto_idle/Widgets/settings_modal_widget.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/ui/widgets/game/view/general/game_app_bar_widget.dart';
import 'package:crypto_idle/ui/widgets/game/view/general/game_footer_widget.dart';
import 'package:crypto_idle/ui/widgets/game/view/general/game_header_balance_widget.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/global/message_stream_view_model.dart';
import 'package:crypto_idle/ui/widgets/main_app_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageWrapperWidget extends StatelessWidget {
  const PageWrapperWidget({Key? key, required this.child, this.modalWindows, this.isShowBackArrow = true})
      : super(key: key);

  final Widget child;
  final List<Widget>? modalWindows;
  final bool isShowBackArrow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GameAppBarWidget(isShowBackArrow: isShowBackArrow),
      body: Stack(
        children: [
          Column(
            children: [
              const GameHeaderWidget(),
              Expanded(child: child),
              const GameFooterWidget(),
            ],
          ),
          const _MessageBlockWidget(),
          const SettingsModalWidget(),
          if (modalWindows != null) ...?modalWindows,
          const ModalGameOverWidget(),
        ],
      ),
    );
  }
}

class _MessageBlockWidget extends StatelessWidget {
  const _MessageBlockWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mvm = context.watch<MessageStreamViewModel>();
    if (mvm.messages.isEmpty) return const SizedBox();
    final messagesWidgets =
        mvm.messages.map((AppMessage message) => _MessageBlockItemWidget(message: message)).toList();
    final children = <Widget>[];

    for (final widget in messagesWidgets) {
      children.add(widget);
      if (messagesWidgets.indexOf(widget) != messagesWidgets.length - 1) {
        children.add(const SizedBox(height: 12));
      }
    }
    final width = MediaQuery.of(context).size.width * 0.5;
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...children,
          ],
        ),
      ),
    );
  }
}

class _MessageBlockItemWidget extends StatefulWidget {
  const _MessageBlockItemWidget({Key? key, required this.message}) : super(key: key);

  final AppMessage message;

  @override
  State<_MessageBlockItemWidget> createState() => _MessageBlockItemWidgetState();
}

class _MessageBlockItemWidgetState extends State<_MessageBlockItemWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageCode = context.read<MainAppViewModel>().locale.languageCode;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: widget.message.color,
        borderRadius: const BorderRadius.only(bottomRight: Radius.elliptical(50, 50)),
      ),
      child: Text(
        languageCode == 'ru' ? widget.message.text : widget.message.textENG,
        textAlign: TextAlign.left,
        style: AppFonts.body.copyWith(color: AppColors.white),
      ),
    );
  }
}
