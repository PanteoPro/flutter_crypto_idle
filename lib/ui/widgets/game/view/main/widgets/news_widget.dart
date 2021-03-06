part of '../main_game_page.dart';

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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: _NewsLeftRowWidget()),
                  Expanded(
                    flex: 4,
                    child: _NewsFirstNewsWidget(),
                  ),
                ],
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
              S.of(context).game_main_news,
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
    final locale = context.read<MainAppViewModel>().locale;

    final newsText = news.isEmpty
        ? ''
        : locale.languageCode == 'ru'
            ? news.first.text
            : news.first.textENG;
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AnimatedSwitcher(
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
                  style: AppFonts.news.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
