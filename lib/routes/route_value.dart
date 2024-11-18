enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
    facts(
    path: 'facts',
  ),
  sections(
    path: '/sections',
  ),
  lessons(
    path: 'lessons',
  ),
  lesson(
    path: 'lesson',
  ),
  quizess(
    path: '/quizess',
  ),
  quiz(
    path: 'quiz',
  ),
  quizResult(
    path: 'quizResult',
  ),
  notions(
    path: '/notions',
  ),

  unknown(
    path: '',
  );

  final String path;

  const RouteValue({
    required this.path,
  });
}
