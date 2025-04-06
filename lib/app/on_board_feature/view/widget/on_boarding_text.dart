part of '../on_boarding_view.dart';

class _OnBoardingText extends StatelessWidget {
  const _OnBoardingText({
    required this.title,
    required this.subtitle,
    required this.description,
  });
  final String title;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(flex: 1),
          FittedBox(
            child: Text(
              title,
              style: AppTextStyles.bold28().copyWith(
                color: ColorsBox.brightBlue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          16.ph,

          // Subtitle
          FittedBox(
            child: Text(
              subtitle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: AppTextStyles.semiBold18().copyWith(
                color: ColorsBox.brightBlue,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          16.ph,

          // Description
          Expanded(
            flex: 9,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 7,
                style: AppTextStyles.medium16().copyWith(
                  color: ColorsBox.blueGrey,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
