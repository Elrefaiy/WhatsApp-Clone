import 'package:flutter/material.dart';
import 'package:whatsapp_clone/core/errors/exceptions.dart';
import 'package:whatsapp_clone/layout/layout.dart';
import 'package:whatsapp_clone/models/status.dart';
import 'package:whatsapp_clone/models/user.dart';
import 'package:whatsapp_clone/modules/chat/chat_screen.dart';
import 'package:whatsapp_clone/modules/image_view/image_view.dart';
import 'package:whatsapp_clone/modules/login/login.dart';
import 'package:whatsapp_clone/modules/login/profile_info.dart';
import 'package:whatsapp_clone/modules/login/verify.dart';
import 'package:whatsapp_clone/modules/profile/mobile_profile.dart';
import 'package:whatsapp_clone/modules/settings/mobile_settings.dart';
import 'package:whatsapp_clone/modules/status/add_status/add_text_status.dart';
import 'package:whatsapp_clone/modules/status/mobile_status_screen.dart';
import 'package:whatsapp_clone/modules/welcome/welcome.dart';

class Routes {
  static const String welcome = '/';
  static const String home = '/home';
  static const String login = '/login';
  static const String verify = '/verify';
  static const String profileInfo = '/profile_info';
  static const String imageView = '/image_view';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String chat = '/chat';
  static const String status = '/status';
  static const String addTextStatus = '/add_text_status';
}

class AppRoutes {
  static Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(
          builder: (context) {
            return const WelcomeScreen();
          },
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (context) {
            return const Layout();
          },
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case Routes.verify:
        return MaterialPageRoute(
          builder: (context) {
            final phoneNumber = settings.arguments as String;
            return VerifyingScreen(phoneNumber: phoneNumber);
          },
        );
      case Routes.profileInfo:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfileInfoScreen();
          },
        );
      case Routes.imageView:
        return MaterialPageRoute(
          builder: (context) {
            final name = settings.arguments as String;
            final image = settings.arguments as String;
            return ImageViewScreen(name: name, image: image);
          },
        );
      case Routes.profile:
        return MaterialPageRoute(
          builder: (context) {
            return const MobileProfile();
          },
        );
      case Routes.settings:
        return MaterialPageRoute(
          builder: (context) {
            return const MobileSettingsScreen();
          },
        );
      case Routes.chat:
        return MaterialPageRoute(
          builder: (context) {
            final model = settings.arguments as UserModel;
            return ChatScreen(model: model);
          },
        );
      case Routes.status:
        return MaterialPageRoute(
          builder: (context) {
            final models = settings.arguments as List<StatusModel>;
            return MobileStatusScreen(models: models);
          },
        );
      case Routes.addTextStatus:
        return MaterialPageRoute(
          builder: (context) {
            return const AddTextStatusScreen();
          },
        );
      default:
        throw const RoutesException('this route is undefiened!');
    }
  }
}
