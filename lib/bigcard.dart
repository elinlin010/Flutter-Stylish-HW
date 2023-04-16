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
      child: Container(
          height: 162,
          width: 328,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: NetworkImage(campaignURL), fit: BoxFit.fitHeight))),
    );
  }
}