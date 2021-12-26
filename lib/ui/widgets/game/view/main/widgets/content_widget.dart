part of '../main_game_page.dart';

class _ContentWidget extends StatelessWidget {
  const _ContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ColoredBox(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: [
            const _ContentBackgroundImageWidget(),
            Column(
              children: const [
                SizedBox(height: 20),
                _ClickerWidget(),
                SizedBox(height: 30),
                _ActionsWidget(),
                SizedBox(height: 30),
                Spacer(),
                _ComputersWidget(),
              ],
            ),
            const _NewsOlderNewsWidget(),
          ],
        ),
      ),
    );
  }
}
