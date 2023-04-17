import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.campaignURL,
  });

  final String campaignURL;

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    // var textStyle = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary);
    
    return Card(
      margin: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 162,
        width: 328,
        child: CachedNetworkImage(
          imageUrl: campaignURL,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
      ),
    );
  }
}