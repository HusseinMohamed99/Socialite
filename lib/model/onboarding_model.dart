import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/utils/app_string.dart';

class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
    title: AppString.prayForPalestine,
    image: Assets.imagesPalestine1,
    description: AppString.descriptionPalestine1,
  ),
  OnboardingContent(
    title: AppString.prayForPalestine,
    image: Assets.imagesPalestine2,
    description: AppString.descriptionPalestine2,
  ),
  OnboardingContent(
    title: AppString.prayForPalestine,
    image: Assets.imagesPalestine3,
    description: AppString.descriptionPalestine3,
  ),
];
