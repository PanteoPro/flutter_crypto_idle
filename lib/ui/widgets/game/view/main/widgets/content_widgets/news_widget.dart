part of '../../main_game_page.dart';

class _NewsOlderNewsWidget extends StatelessWidget {
  const _NewsOlderNewsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final news = context.select((DayStreamViewModel vm) => vm.newsListToDisplay);
    final newsToDisplay = news.sublist(min(1, news.length), min(4, news.length));
    final isShowNews = context.select((MainGameViewModel vm) => vm.state.isShowNews);

    return AnimatedSize(
      alignment: isShowNews ? Alignment.center : AlignmentDirectional.topCenter,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      child: ColoredBox(
        color: AppColors.black80,
        child: ConstrainedBox(
          constraints: !isShowNews ? const BoxConstraints(maxHeight: 0) : const BoxConstraints(),
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final news in newsToDisplay) ...[_NewsOlderItemWidget(news: news), const SizedBox(height: 6)],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NewsOlderItemWidget extends StatelessWidget {
  const _NewsOlderItemWidget({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final format = DateFormat.yMd(locale.languageCode);
    final stringDate = format.format(news.date);
    // SchedulerBinding.instance
    //     ?.addPostFrameCallback((_) => context.read<MainGameViewModel>().postFrameCallbackOlderNews(context));
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(double.infinity, 28)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 78,
            child: Padding(
              padding: const EdgeInsets.only(right: 4, top: 2),
              child: Text(
                stringDate,
                textAlign: TextAlign.right,
                style: AppFonts.dataNews.copyWith(color: AppColors.grey),
              ),
            ),
          ),
          Expanded(
            child: Text(
              locale.languageCode == 'ru' ? news.text : news.textENG,
              style: AppFonts.news.copyWith(color: AppColors.lightGrey),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
