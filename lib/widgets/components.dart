
import 'package:flutter/material.dart';
import '../app.dart';
import '../models/models.dart';

class Responsive extends StatelessWidget {
  final Widget Function(BuildContext context, int columns, double width) builder;

  const Responsive({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columns = width >= 1180
            ? 4
            : width >= 820
                ? 3
                : width >= 540
                    ? 2
                    : 1;

        return builder(context, columns, width);
      },
    );
  }
}

class PageContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const PageContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontal = constraints.maxWidth < 540
            ? 16.0
            : constraints.maxWidth < 900
                ? 24.0
                : 32.0;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1220),
            child: Padding(
              padding: padding ??
                  EdgeInsets.symmetric(horizontal: horizontal),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class AppHeader extends StatelessWidget {
  final String active;

  const AppHeader({
    super.key,
    this.active = 'Home',
  });

  static const links = [
    ('Home', '/'),
    ('Categories', '/categories'),
    ('Products', '/products'),
    ('About', '/about'),
    ('Contact', '/contact'),

  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Color(0xFFEAF0EC)),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 11,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 1080;
                final showName = constraints.maxWidth >= 410;

                return Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/',
                          (_) => false,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/logo/makkah_superstore_logo.jpg',
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const ColoredBox(
                                  color: AppColors.mint,
                                  child: SizedBox(
                                    width: 42,
                                    height: 42,
                                    child: Icon(
                                      Icons.storefront_rounded,
                                      color: AppColors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (showName) ...[
                              const SizedBox(width: 9),
                              const Flexible(
                                child: Text(
                                  'Makkah Superstore',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    if (!compact)
                      Flexible(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Wrap(
                            alignment: WrapAlignment.end,
                            spacing: 4,
                            children: links.map((link) {
                              final selected = active == link.$1;
                              return TextButton(
                                onPressed: () =>
                                    Navigator.pushNamed(context, link.$2),
                                style: TextButton.styleFrom(
                                  foregroundColor: selected
                                      ? AppColors.green
                                      : AppColors.muted,
                                  backgroundColor: selected
                                      ? AppColors.mint
                                      : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  link.$1,
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: selected
                                        ? FontWeight.w800
                                        : FontWeight.w600,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    else
                      IconButton(
                        tooltip: 'Open menu',
                        onPressed: () => _showMenu(context),
                        icon: const Icon(
                          Icons.menu_rounded,
                          color: AppColors.ink,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 42,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCE7E0),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Explore Makkah Superstore',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.pop(sheetContext),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const Divider(height: 8),
                ...links.map(
                  (link) => ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    leading: Icon(
                      _iconFor(link.$1),
                      color: active == link.$1
                          ? AppColors.green
                          : AppColors.muted,
                    ),
                    title: Text(
                      link.$1,
                      style: TextStyle(
                        fontWeight: active == link.$1
                            ? FontWeight.w800
                            : FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: Color(0xFF9AA9A0),
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);
                      Navigator.pushNamed(context, link.$2);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String name) => switch (name) {
        'Home' => Icons.home_outlined,
        'Categories' => Icons.grid_view_rounded,
        'Products' => Icons.shopping_basket_outlined,

        'About' => Icons.info_outline_rounded,
        'Contact' => Icons.phone_outlined,

        _ => Icons.chevron_right_rounded,
      };
}

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGreen,
      padding: const EdgeInsets.symmetric(vertical: 46, horizontal: 16),
      child: PageContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 700;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (narrow)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _footerBlocks(),
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _footerBlocks()
                        .map(
                          (child) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 28),
                              child: child,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                const SizedBox(height: 36),
                const Divider(color: Color(0x335F9675), height: 1),
                const SizedBox(height: 18),
                if (narrow)
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FooterCopyright(),
                      SizedBox(height: 12),
                      _FooterSocials(),
                    ],
                  )
                else
                  const Row(
                    children: [
                      Expanded(child: _FooterCopyright()),
                      _FooterSocials(),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _footerBlocks() {
    return const [
      SizedBox(
        width: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _FooterBrand(),
            SizedBox(height: 14),
            Text(
              'Fresh choices, trusted brands, and everyday essentials for your family.',
              style: TextStyle(
                color: Color(0xFFBBD5C5),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
      _FooterColumn(
        title: 'Shop',
        items: [
          ('Categories', '/categories'),
          ('Products', '/products'),
        ],
      ),
      _FooterColumn(
        title: 'Company',
        items: [
          ('About us', '/about'),
          ('Contact', '/contact '),
        ],
      ),
      SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Visit us',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 14),
            Text(
              'Abdul Latif Tower\nNear Amtola Jame Masjid Main Road\nNorth Shahjahanpur, Dhaka 1217\n+8801313921078',
              style: TextStyle(
                color: Color(0xFFBBD5C5),
                height: 1.8,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    ];
  }
}

class _FooterBrand extends StatelessWidget {
  const _FooterBrand();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Image.asset(
            'assets/logo/makkah_superstore_logo.jpg',
            width: 38,
            height: 38,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 10),
        const Flexible(
          child: Text(
            'Makkah Superstore',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

class _FooterCopyright extends StatelessWidget {
  const _FooterCopyright();

  @override
  Widget build(BuildContext context) {
    return const Text(
      '© 2026 Makkah Superstore. All rights reserved.',
      style: TextStyle(
        color: Color(0xFFBBD5C5),
        fontSize: 12,
      ),
    );
  }
}

class _FooterSocials extends StatelessWidget {
  const _FooterSocials();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _SocialIcon(icon: Icons.facebook),
        _SocialIcon(icon: Icons.camera_alt_outlined),
        _SocialIcon(icon: Icons.phone_outlined),
      ],
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<(String, String)> items;

  const _FooterColumn({
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          ...items.map(
            (item) => TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, item.$2),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                foregroundColor: const Color(0xFFBBD5C5),
              ),
              child: Text(item.$1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;

  const _SocialIcon({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0x557BA58D),
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFBBD5C5),
          size: 16,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;
  final Widget? action;

  const SectionTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 680;

        final text = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              eyebrow.toUpperCase(),
              style: const TextStyle(
                color: AppColors.green,
                fontSize: 10.5,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: constraints.maxWidth < 420 ? 23 : 26,
                  ),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 7),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        );

        if (narrow && action != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text,
              const SizedBox(height: 8),
              action!,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: text),
            if (action != null) ...[
              const SizedBox(width: 16),
              action!,
            ],
          ],
        );
      },
    );
  }
}

class HeroBanner extends StatelessWidget {
  final VoidCallback onExplore;

  const HeroBanner({
    super.key,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final mobile = width < 600;
        final tablet = width >= 600 && width < 1000;

        // The supplied artwork is 2:1. Keep that same horizontal feel
        // everywhere while limiting desktop height for comfortable viewing.
        final height = (width / 2).clamp(170.0, 475.0).toDouble();

        return Container(
          width: double.infinity,
          height: height,
          margin: const EdgeInsets.only(bottom: 20),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mobile ? 16 : 24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x120E3C22),
                blurRadius: 24,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: (){
              onExplore();
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/catalog/heroBanner.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xD90C3828),
                        Color(0x4D123626),
                        Color(0x08123626),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2ECE6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x080E3C22),
                blurRadius: 18,
                offset: Offset(0, 7),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final compact = width < 220;
              final imageHeight = (width * 0.58)
                  .clamp(105.0, 190.0)
                  .toDouble();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: imageHeight,
                    width: double.infinity,
                    child: ColoredBox(
                      color: AppColors.pale,
                      child: Image.asset(
                        category.image,
                        fit: BoxFit.fitHeight,
                        errorBuilder: (_, __, ___) => const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: AppColors.muted,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 12 : 15,
                      12,
                      compact ? 12 : 15,
                      13,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: compact ? 14 : 16,
                            height: 1.15,
                            color: AppColors.ink,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          category.description,
                          maxLines: compact ? 2 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: compact ? 10.5 : 12,
                            height: 1.35,
                            color: AppColors.muted,
                          ),
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'View catalogue',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: AppColors.green,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class CataloguePageCard extends StatelessWidget {
  final CataloguePage page;
  final VoidCallback? onTap;

  const CataloguePageCard({
    super.key,
    required this.page,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2ECE6)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x080E3C22),
                blurRadius: 18,
                offset: Offset(0, 7),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 0.92,
                child: ColoredBox(
                  color: AppColors.pale,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Image.asset(
                      page.image,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      page.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                        color: AppColors.ink,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.sell_outlined,
                          size: 13,
                          color: AppColors.green,
                        ),
                        const SizedBox(width: 5),
                        const Expanded(
                          child: Text(
                            'Prices shown on flyer',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10.5,
                              color: AppColors.muted,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.open_in_full_rounded,
                          size: 14,
                          color: AppColors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE6EEE9),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x080E3C22),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1.15,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return const ColoredBox(
                        color: AppColors.mint,
                        child: Icon(
                          Icons.image_not_supported_outlined,
                        ),
                      );
                    },
                  ),
                ),
                if (product.oldPrice != null)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'OFFER',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                if (product.isNew)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'NEW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                15,
                14,
                15,
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.green,
                      fontSize: 10,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    children: [
                      Text(
                        '৳${product.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        product.unit,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.muted,
                        ),
                      ),
                      if (product.oldPrice != null) ...[
                        const Spacer(),
                        Text(
                          '৳${product.oldPrice!.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.muted,
                            decoration:
                                TextDecoration.lineThrough,
                          ),
                        ),
                      ],
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

class OfferCard extends StatelessWidget {
  final Offer offer;
  final VoidCallback onTap;

  const OfferCard({
    super.key,
    required this.offer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 285,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        image: DecorationImage(
          image: AssetImage(offer.image),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xDB103D2A),
              Color(0x14244532),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              offer.discount,
              style: const TextStyle(
                color: Color(0xFFC7F2D5),
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              offer.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              offer.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFFD7EBDE),
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(
                  color: Color(0x99FFFFFF),
                ),
              ),
              child: const Text('View products'),
            ),
          ],
        ),
      ),
    );
  }
}

class BrandCard extends StatelessWidget {
  final Brand brand;
  final VoidCallback onTap;

  const BrandCard({
    super.key,
    required this.brand,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE4EEE7),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 62,
              height: 62,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.mint,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                brand.logo,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 13),
            Text(
              brand.name,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BranchCard extends StatelessWidget {
  final Branch branch;
  final VoidCallback onTap;

  const BranchCard({
    super.key,
    required this.branch,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE4EEE7),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 2.2,
            child: Image.asset(
              branch.image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return const ColoredBox(
                  color: AppColors.mint,
                  child: Icon(
                    Icons.storefront_outlined,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  branch.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  branch.address,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  branch.openingHours,
                  style: const TextStyle(
                    color: AppColors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                TextButton.icon(
                  onPressed: onTap,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    foregroundColor: AppColors.green,
                  ),
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 15,
                  ),
                  label: const Text('View details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}