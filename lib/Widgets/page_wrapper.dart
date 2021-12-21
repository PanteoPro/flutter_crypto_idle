import 'package:crypto_idle/Widgets/old_game_over_modal.dart';
import 'package:crypto_idle/domain/repositories/message_manager.dart';
import 'package:crypto_idle/ui/widgets/game/view_models/message_stream_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageWrapperWidget extends StatelessWidget {
  const PageWrapperWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const _MessageBlockWidget(),
        const GameOverModalWidget(),
      ],
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
        children.add(SizedBox(height: 8));
      }
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
      child: ColoredBox(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageBlockItemWidget extends StatelessWidget {
  const _MessageBlockItemWidget({Key? key, required this.message}) : super(key: key);

  final AppMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: message.color, width: 2),
      ),
      child: Text(message.text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}
