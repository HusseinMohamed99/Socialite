import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/pages/login/login_screen.dart';
import 'package:socialite/shared/components/indicator.dart';
import 'package:socialite/shared/cubit/Internet/internet_bloc.dart';
import 'package:socialite/shared/enum/enum.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        body: Center(
          child: BlocConsumer<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state == InternetState.gained) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Connected'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else if (state == InternetState.lost) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Not Connected'),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state == InternetState.gained) {
                // Show your information when connected
                return const LoginScreen();
              } else if (state == InternetState.lost) {
                return SvgPicture.asset(Assets.imagesErrorNetwork);
              } else {
                return const AdaptiveIndicator(); // Loading indicator
              }
            },
          ),
        ),
      ),
    );
  }
}
