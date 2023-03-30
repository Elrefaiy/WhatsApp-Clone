import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../../authentication/presentation/cubit/authentication_cubit.dart';
import 'web_layout.dart';
import 'mobile_layout.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        if (kIsWeb) {
          return const WebLayout();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
