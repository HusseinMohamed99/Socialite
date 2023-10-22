import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialite/image_assets.dart';
import 'package:socialite/shared/utils/color_manager.dart';

class ImageWithShimmer extends StatelessWidget {
  const ImageWithShimmer({
    super.key,
    required this.imageUrl,
    required this.width,
    this.height,
    this.boxFit,
    this.radius,
  });

  final String imageUrl;
  final double? height;
  final double width;
  final BoxFit? boxFit;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: height,
      width: width,
      fit: boxFit ?? BoxFit.fill,
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          height: height,
          color: ColorManager.greyColor,
        ),
      ),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit ?? BoxFit.fill,
            ),
          ),
        );
      },
      errorWidget: (_, __, ___) => SvgPicture.asset(Assets.imagesError),
    );
  }
}
