import 'package:flutter/material.dart';

Container darkGradientOverlay(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
      );
  }