part of '../new_main_game_page.dart';

class _ModalExitWidget extends StatelessWidget {
  const _ModalExitWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: ColoredBox(
        color: AppColors.black50,
        child: Center(
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.black,
                border: Border.all(color: AppColors.green),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Вы точно хотите выйти в меню?',
                    style: AppFonts.clicker.copyWith(color: AppColors.white),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 140,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.black),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      child: Text('Да', style: AppFonts.main.copyWith(color: AppColors.white)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 140,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(AppColors.black),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      child: Text('Нет', style: AppFonts.main.copyWith(color: AppColors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
