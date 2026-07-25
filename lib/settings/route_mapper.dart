String routeToMenu(String route) {
  switch (route) {
    case '/home':
      return 'Home';
    case '/search':
      return 'Search';
    case '/booking':
      return 'Booking';
    case '/profile':
      return 'Profile';
    default:
      return 'Home';
  }
}
