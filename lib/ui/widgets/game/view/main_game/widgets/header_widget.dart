part of '../main_game_page.dart';

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GameHeaderWidget(
      childrenInColumn: [
        _NewsWidget(),
      ],
    );
  }
}

class _NewsWidget extends StatelessWidget {
  const _NewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.secondGrey,
      child: SizedBox(
        height: 40,
        child: Column(
          children: [
            ColoredBox(
              color: AppColors.secondGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _NewsLeftRowWidget(),
                    SizedBox(width: 6),
                    Expanded(
                      child: _NewsFirstNewsWidget(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsLeftRowWidget extends StatelessWidget {
  const _NewsLeftRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<MainGameViewModel>();
    final isShowNews = context.select((MainGameViewModel vm) => vm.state.isShowNews);

    return GestureDetector(
      onTap: vm.onShowNewsButtonPressed,
      child: SizedBox(
        height: 40,
        child: Column(
          children: [
            Text(
              'Новости:',
              style: AppFonts.main.copyWith(color: AppColors.green),
            ),
            Expanded(
              child: AnimatedRotation(
                turns: isShowNews ? 0.5 : 0,
                duration: Duration(milliseconds: isShowNews ? 500 : 200),
                child: Image.asset(
                  AppIconsImages.downIcon,
                  width: 19,
                  height: 19,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewsFirstNewsWidget extends StatelessWidget {
  const _NewsFirstNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news = context.select((DayStreamViewModel vm) => vm.newsListToDisplay);
    final newsText = news.isEmpty ? '' : news.first.text;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: SizedBox(
        key: ValueKey(newsText),
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                newsText,
                maxLines: 2,
                style: AppFonts.mainLight.copyWith(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
