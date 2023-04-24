import 'package:flutter/material.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton(
      {super.key,
      required this.size,
      required this.iconUrl,
      required this.onPressed});
  final double size;
  final String iconUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: SizedBox(
          width: size,
          height: size,
          child: Image.network(iconUrl, fit: BoxFit.contain)),
    );
  }
}
