import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:intl/intl.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/utils/app_string.dart';
import 'package:url_launcher/url_launcher.dart';

String daysBetween(DateTime postDate) {
  if ((DateTime.now().difference(postDate).inHours / 24).round() == 0) {
    if (DateTime.now().difference(postDate).inHours == 0) {
      if (DateTime.now().difference(postDate).inMinutes == 0) {
        return 'now';
      } else {
        return '${DateTime.now().difference(postDate).inMinutes.toString()} minutes';
      }
    } else {
      return '${DateTime.now().difference(postDate).inHours.toString()} hours';
    }
  } else {
    return (' ${(DateTime.now().difference(postDate).inHours / 24).round().toString()} days');
  }
}

String getDate(DateTime dateTime) {
  DateTime dateTime = DateTime.now();
  String date = DateFormat.yMMMd().format(dateTime);
  return date;
}

String? uId = '';

Widget imageWithShimmer(
  String? image, {
  double? height,
  double? width,
  double? radius,
}) {
  return FullScreenWidget(
    child: Center(
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: ImageWithShimmer(
          imageUrl: '$image',
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          boxFit: BoxFit.fitWidth,
        ),
      ),
    ),
  );
}

Widget imagePreview(String? image, {double? height}) {
  return FullScreenWidget(
    child: Center(
      child: ImageWithShimmer(
        boxFit: BoxFit.fitWidth,
        width: double.infinity,
        imageUrl: "$image",
        height: height,
      ),
    ),
  );
}

Widget imagePostPreview(String? image) {
  return FullScreenWidget(
    child: Center(
      child: Image.network(
        fit: BoxFit.fitWidth,
        width: double.infinity,
        "$image",
        alignment: AlignmentDirectional.topCenter,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: SvgPicture.asset(Assets.images404error),
          );
        },
      ),
    ),
  );
}

double intToDouble(int num) {
  double doubleNum = num.toDouble();
  return doubleNum;
}

Future<void> urlLauncher(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('${AppString.notLaunch}$url');
  }
}
