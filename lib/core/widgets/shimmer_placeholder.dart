import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Wraps [child] — solid-colored skeleton shapes — in a shimmering loading
/// animation themed off the current [ColorScheme].
class ShimmerPlaceholder extends StatelessWidget {
  const ShimmerPlaceholder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Shimmer.fromColors(
      baseColor: colorScheme.surfaceContainerHighest,
      highlightColor: colorScheme.surface,
      child: child,
    );
  }
}

/// A single shimmering skeleton bar — the basic building block for
/// text/button-shaped loading placeholders.
class ShimmerBar extends StatelessWidget {
  const ShimmerBar({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 4,
  });

  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
