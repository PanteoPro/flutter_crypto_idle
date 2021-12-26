part of '../../main_game_page.dart';

class _ContentBackgroundImageWidget extends StatelessWidget {
  const _ContentBackgroundImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flat = context.select((MainGameViewModel vm) => vm.state.flat);
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            AppImages.getFlatPathByName(flat.name),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColoredBox(
            color: AppColors.mainGrey.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
