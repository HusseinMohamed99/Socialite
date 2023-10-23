import 'package:flutter/material.dart';
import 'package:socialite/model/comment_model.dart';
import 'package:socialite/shared/components/constants.dart';
import 'package:socialite/shared/components/image_with_shimmer.dart';
import 'package:socialite/shared/utils/value_manager.dart';

class BuildCommentsItem extends StatelessWidget {
  const BuildCommentsItem({super.key, required this.comment});
  final CommentModel comment;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30,
              child: ImageWithShimmer(
                imageUrl: '${comment.userImage}',
                width: 60,
                height: 60,
                boxFit: BoxFit.fill,
                radius: 30,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                comment.commentText != null && comment.commentImage != null
                    ?

                    /// If its (Text & Image) Comment
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppPadding.p12,
                                  right: AppPadding.p12,
                                  left: AppPadding.p12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${comment.name}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '${comment.commentText}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Container(
                            width: intToDouble(
                                comment.commentImage?['width'] ?? 300),
                            height: intToDouble(
                                comment.commentImage?['height'] ?? 220),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: imageWithShimmer(
                              comment.commentImage!['image'],
                              radius: 25,
                            ),
                          ),
                        ],
                      )
                    : comment.commentImage != null
                        ?

                        /// If its (Image) Comment
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${comment.name}',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              Container(
                                width: intToDouble(
                                    comment.commentImage?['width'] ?? 300),
                                height: intToDouble(
                                    comment.commentImage?['height'] ?? 220),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: imageWithShimmer(
                                  comment.commentImage!['image'],
                                  radius: 25,
                                ),
                              ),
                            ],
                          )
                        : comment.commentText != null
                            ?

                            /// If its (Text) Comment
                            ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: AppPadding.p12,
                                      right: AppPadding.p12,
                                      left: AppPadding.p12,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${comment.name}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${comment.commentText}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    '${comment.dateTime}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.end,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
