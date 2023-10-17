class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      title: 'Pray for Palestine',
      image: 'assets/images/1.png',
      description:
          "Don't stop talking about Palestine, Our people in Palestine are suffering."),
  OnboardingContent(
      title: 'Pray for Palestine',
      image: 'assets/images/2.png',
      description:
          "Inform everyone about the truth,talk\nabout the crimes of the Zionist entity, "),
  OnboardingContent(
      title: 'Pray for Palestine',
      image: 'assets/images/3.png',
      description:
          "Pass on the cause to your children\n and be a voice for the voiceless."),
];
