import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTrendingCard extends StatelessWidget {
  const ShimmerTrendingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isDarkMode ? Colors.grey[800] : Colors.white,
              ),
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    isDarkMode
                        ? Colors.black.withValues(alpha: 0.7)
                        : Colors.black.withValues(alpha: 0.5),
                  ],
                  stops: const [0.7, 1.0],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: double.infinity,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Second line of title
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Author row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Avatar shimmer
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isDarkMode
                                    ? Colors.grey[700]
                                    : Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 8),

                          // Author name shimmer
                          Shimmer.fromColors(
                            baseColor: baseColor,
                            highlightColor: highlightColor,
                            child: Container(
                              width: 80,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: isDarkMode
                                    ? Colors.grey[700]
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Date shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Bottom row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Author title shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 70,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),

                      // Read time shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 50,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),

                      // Trending label shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerNewsList extends StatelessWidget {
  final int itemCount;

  const ShimmerNewsList({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        itemCount,
        (index) => const ShimmerNewsListItem(),
      ),
    );
  }
}

class ShimmerNewsListItem extends StatelessWidget {
  const ShimmerNewsListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    const double imageHeight = 130.0;
    const double imageWidth = 130.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer
            Shimmer.fromColors(
              baseColor: baseColor,
              highlightColor: highlightColor,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: isDarkMode ? Colors.grey[700] : Colors.white,
                ),
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 80,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Title shimmer - line 1
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Title shimmer - line 2
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Author row shimmer
                  Row(
                    children: [
                      // Avatar shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Author name shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),

                      // Dot separator
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? Colors.grey[600]
                              : Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),

                      // Date shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 70,
                          height: 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerNewsDetail extends StatelessWidget {
  const ShimmerNewsDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    final baseColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: colorScheme.surface,
            elevation: 0,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Image shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                    ),
                  ),

                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.8),
                        ],
                        stops: const [0.0, 0.3, 0.7, 1.0],
                      ),
                    ),
                  ),

                  // Content shimmer at bottom
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category badge shimmer
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: 80,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Title shimmer
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: double.infinity,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Title line 2 shimmer
                        Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Info row shimmer
                        Row(
                          children: [
                            // Trending icon shimmer
                            Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                width: 60,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isDarkMode
                                      ? Colors.grey[700]
                                      : Colors.white,
                                ),
                              ),
                            ),

                            _buildShimmerDot(),

                            // Date shimmer
                            Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                width: 80,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isDarkMode
                                      ? Colors.grey[700]
                                      : Colors.white,
                                ),
                              ),
                            ),

                            _buildShimmerDot(),

                            // Read time shimmer
                            Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                width: 60,
                                height: 16,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isDarkMode
                                      ? Colors.grey[700]
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildBlurredIconButton(context),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildBlurredIconButton(context),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _buildBlurredIconButton(context),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author section shimmer
                  Row(
                    children: [
                      // Avatar shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author name shimmer
                            Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                width: 120,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isDarkMode
                                      ? Colors.grey[700]
                                      : Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 4),

                            // Author title shimmer
                            Shimmer.fromColors(
                              baseColor: baseColor,
                              highlightColor: highlightColor,
                              child: Container(
                                width: 80,
                                height: 14,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isDarkMode
                                      ? Colors.grey[700]
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Follow button shimmer
                      Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 70,
                          height: 32,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Tags shimmer
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      3,
                      (index) => Shimmer.fromColors(
                        baseColor: baseColor,
                        highlightColor: highlightColor,
                        child: Container(
                          width: 60,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: isDarkMode ? Colors.grey[700] : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Content paragraph shimmer
                  Column(
                    children: List.generate(12, (index) {
                      // Buat paragraf dengan panjang yang bervariasi
                      final isFirstParagraph = index == 0;
                      final width = isFirstParagraph
                          ? double.infinity
                          : (index % 3 == 0
                                ? MediaQuery.of(context).size.width * 0.7
                                : double.infinity);

                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: isFirstParagraph ? 16.0 : 8.0,
                        ),
                        child: Shimmer.fromColors(
                          baseColor: baseColor,
                          highlightColor: highlightColor,
                          child: Container(
                            width: width,
                            height: isFirstParagraph ? 18.0 : 14.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: isDarkMode
                                  ? Colors.grey[700]
                                  : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Like button shimmer
                          _buildInteractionButtonShimmer(
                            baseColor,
                            highlightColor,
                            isDarkMode,
                          ),

                          const SizedBox(width: 16),

                          // Comment button shimmer
                          _buildInteractionButtonShimmer(
                            baseColor,
                            highlightColor,
                            isDarkMode,
                          ),
                        ],
                      ),

                      // Share button shimmer
                      _buildInteractionButtonShimmer(
                        baseColor,
                        highlightColor,
                        isDarkMode,
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  const Divider(),

                  const SizedBox(height: 24),

                  // Related articles title shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 150,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Related articles shimmer
                  ...List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: _buildRelatedArticleShimmer(
                        baseColor,
                        highlightColor,
                        isDarkMode,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        width: 4,
        height: 4,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildBlurredIconButton(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.white.withValues(alpha: 0.3),
            shape: BoxShape.circle,
            border: Border.all(
              color: isDarkMode
                  ? Colors.white.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
          child: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildInteractionButtonShimmer(
    Color baseColor,
    Color highlightColor,
    bool isDarkMode,
  ) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isDarkMode ? Colors.grey[700] : Colors.white,
        ),
      ),
    );
  }

  Widget _buildRelatedArticleShimmer(
    Color baseColor,
    Color highlightColor,
    bool isDarkMode,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isDarkMode
            ? Colors.grey[850]!.withValues(alpha: 0.3)
            : Colors.grey[200]!.withValues(alpha: 0.3),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image shimmer
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 100,
              height: 100,
              color: isDarkMode ? Colors.grey[700] : Colors.white,
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 60,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Title shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Title line 2 shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 120,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Date shimmer
                  Shimmer.fromColors(
                    baseColor: baseColor,
                    highlightColor: highlightColor,
                    child: Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: isDarkMode ? Colors.grey[700] : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
