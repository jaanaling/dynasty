enum IconProvider {
  home(imageName: 'home.svg'),
  lessons(imageName: 'lessons.svg'),
  quiz(imageName: 'quiz.svg'),
  tips(imageName: 'tips.svg'),
  logo(imageName: 'logo.png'),
  historicalFigure(imageName: 'historical_figure.png'),
  places(imageName: 'places.png'),
  culture(imageName: 'culture.png'),
  dynasties(imageName: 'dynasties.png'),

  unknown(imageName: '');

  const IconProvider({
    required this.imageName,
  });

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
