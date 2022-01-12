import 'package:crypto_tycoon/Theme/app_colors.dart';
import 'package:crypto_tycoon/Theme/app_fonts.dart';
import 'package:crypto_tycoon/Widgets/game_over_widget.dart';
import 'package:crypto_tycoon/Widgets/settings_modal_widget.dart';
import 'package:crypto_tycoon/domain/repositories/message_manager.dart';
import 'package:crypto_tycoon/resources/resources.dart';
import 'package:crypto_tycoon/ui/widgets/game/view/general/game_app_bar_widget.dart';
import 'package:crypto_tycoon/ui/widgets/game/view/general/game_footer_widget.dart';
import 'package:crypto_tycoon/ui/widgets/game/view/general/game_header_balance_widget.dart';
import 'package:crypto_tycoon/ui/widgets/game/view_models/global/message_stream_view_model.dart';
import 'package:crypto_tycoon/ui/widgets/main_app_view_model.dart';
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
        padding: const EdgeInsets.only(top: kToolbarHeight * 2 + 10),
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

    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.message.color,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.elliptical(15, 20),
          topRight: Radius.elliptical(15, 20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 4),
          Image.asset(widget.message.image, width: 16, height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 4, right: 10, top: 5, bottom: 5),
              child: languageCode == 'ru' ? widget.message.text : widget.message.textENG,
            ),
          ),
        ],
      ),
    );
  }
}
