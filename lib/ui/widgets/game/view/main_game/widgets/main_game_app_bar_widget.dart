part of '../new_main_game_page.dart';

class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          // _AppBarAnimatedCalendarWidget(),
          // SizedBox(width: 4),
          _DataWidget(),
        ],
      ),
      centerTitle: true,
      actions: [
        _AppBarActionWidget(onTap: () {}, imagePath: AppImages.iconMute),
        const SizedBox(width: 12),
        _AppBarActionWidget(onTap: () {}, imagePath: AppImages.iconSettings),
        const SizedBox(width: 12),
      ],
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(2),
      //   child: Container(
      //     color: Colors.black,
      //     height: 1,
      //   ),
      // ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(32);
}

class _DataWidget extends StatelessWidget {
  const _DataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = context.read<MainAppViewModel>().locale;
    final format = DateFormat.yMd(locale.languageCode);
    final date = context.select((MainGameViewModel vm) => vm.state.date);
    final stringDate = format.format(date);
    return Text(stringDate, style: AppFonts.main.copyWith(color: AppColors.white));
  }
}

class _AppBarAnimatedCalendarWidget extends StatefulWidget {
  const _AppBarAnimatedCalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<_AppBarAnimatedCalendarWidget> createState() => _AppBarAnimatedCalendarWidgetState();
}

class _AppBarAnimatedCalendarWidgetState extends State<_AppBarAnimatedCalendarWidget> with TickerProviderStateMixin {
  late GifController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = GifController(vsync: this);
    // WidgetsBinding.instance!.addPostFrameCallback((_) => _startAnimation());
  }

  void _startAnimation() {
    controller.value = 0;
    controller.animateTo(27, duration: Duration(milliseconds: 900));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _startAnimation(),
      child: GifImage(
        image: const AssetImage(AppImages.iconCalendarGif),
        controller: controller,
        width: 24,
        height: 24,
      ),
    );
  }
}

class _AppBarActionWidget extends StatelessWidget {
  const _AppBarActionWidget({Key? key, required this.imagePath, required this.onTap}) : super(key: key);

  final VoidCallback onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(imagePath, width: 20, height: 20),
    );
  }
}
