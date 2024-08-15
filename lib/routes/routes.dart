import 'package:get/get.dart';
import 'package:quotes2/screens/home_screen.dart';
import 'package:quotes2/screens/login_screen.dart';
import 'package:quotes2/screens/onboarding_screen.dart';
import 'package:quotes2/screens/profile_screen.dart';
import 'package:quotes2/screens/register_screen.dart';
import 'package:quotes2/screens/splash_screen.dart';



class AppRoutes {
  static final routes = [
    GetPage(name: '/splash', page: () => const SplashScreen()),
    GetPage(name: '/onboarding', page: () => OnboardingScreen()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/register', page: () => const RegisterScreen()),
    GetPage(name: '/home', page: () => HomeScreen()), 
    GetPage(name: '/profile', page: () => const ProfileScreen()),
  ];
}
