import 'package:flutter/material.dart';
import 'package:list_it/provider/item_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:list_it/screen/login_page.dart';
import 'package:list_it/screen/sign_up_page.dart';
import '../theme/theme.dart';
import 'screen/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ItemListProvider()),
      ],
      child: MaterialApp(
        theme: AppTheme.getThemeData(),
        initialRoute: Routes.loginScreen.route,
        onGenerateRoute: _onGenerateRoute,
      )
    );
  }
}

Route<dynamic> _onGenerateRoute(RouteSettings settings) {
  switch (Routes.fromString(settings.name)) {
    case Routes.loginScreen:  return MaterialPageRoute(builder: (_) => const LoginPage());
    case Routes.signupScreen: return MaterialPageRoute(builder: (_) => const SignUpPage());
    case Routes.homeScreen:   return MaterialPageRoute(builder: (_) => const HomePage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}

enum Routes {
  loginScreen('/login'),
  signupScreen('signup'),
  homeScreen('/home'),
  undefinedRoute('/');

  final String route;

  const Routes(this.route);

  static Routes fromString(String? routeName) {
    if (routeName == null) return Routes.undefinedRoute;
    return Routes.values.firstWhere(
      (routeEnum) => routeEnum.route == routeName,
      orElse: () => Routes.undefinedRoute,
    );
  }
}