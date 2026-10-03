import 'package:flutter/material.dart';

import '../app.dart';
import '../data/store_data.dart';
import '../models/models.dart';
import '../widgets/components.dart';

void openProduct(BuildContext context, Product product) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProductDetailsScreen(product: product),
    ),
  );
}

void openBranch(BuildContext context, Branch branch) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => BranchDetailsScreen(branch: branch),
    ),
  );
}

void openCataloguePage(BuildContext context, CataloguePage page) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black87,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900, maxHeight: 900),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 8, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        page.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4,
                  child: Center(
                    child: Image.asset(
                      page.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: AppColors.pale,
                child: const Text(
                  'Promotional prices and pack details are shown on the original catalogue artwork.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.muted,
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

// ============================================================
// SHELL
// ============================================================

class Shell extends StatelessWidget {
  final String active;
  final Widget child;

  const Shell({
    super.key,
    required this.active,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(active: active),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// ============================================================
// HOME SCREEN
// ============================================================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Home Delivery Available'),
              content: const Text(
                'Call: 01313921708',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        },
        backgroundColor: const Color(0xFF0C3828),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.delivery_dining),
        label: const Text(
          'Home Delivery',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: AppHeader(),
          ),

          SliverToBoxAdapter(
            child: PageContainer(
              child: HeroBanner(
                onExplore: () {
                  Navigator.pushNamed(context, '/products');
                },
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: _HomeCategories(),
          ),



          const SliverToBoxAdapter(
            child: _HomeProducts(),
          ),

          const SliverToBoxAdapter(
            child: _FreshEveryday(),
          ),

          const SliverToBoxAdapter(
            child: _CategoryProducts(),
          ),




          const SliverToBoxAdapter(
            child: _AboutPreview(),
          ),



          const SliverToBoxAdapter(
            child: _ContactPreview(),
          ),

          const SliverToBoxAdapter(
            child: AppFooter(),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME - CATEGORIES
// ============================================================

class _HomeCategories extends StatelessWidget {
  const _HomeCategories();

  @override
  Widget build(BuildContext context) {
    return _SectionWrap(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         // SizedBox(height: 0,),
          SectionTitle(
            eyebrow: 'Explore the aisle',
            title: 'Shop by category',
            subtitle:
                'Everything you need for a fresher everyday life.',
            action: _SeeAll(
              text: 'All categories',
              route: '/categories',
            ),
          ),

          const SizedBox(height: 8),

          Responsive(
            builder: (context, columns, _) {
              // If Responsive returns 1 for mobile, override it to 2
              final effectiveColumns = columns == 1 ? 2 : columns;


              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: effectiveColumns,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  // Map childAspectRatio directly to effectiveColumns
                  childAspectRatio: effectiveColumns == 2
                      ? 0.75
                      : effectiveColumns == 3
                      ? 0.82
                      : 0.90,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return CategoryCard(
                    category: category,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                            category: category,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

// ============================================================
// HOME - OFFERS
// ============================================================


class _HomeProducts extends StatelessWidget {
  const _HomeProducts();

  @override
  Widget build(BuildContext context) {
    final pages = cataloguePages.take(6).toList();

    return _SectionWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(
            eyebrow: 'Current catalogue',
            title: 'Real promotions from Makkah',
            subtitle:
                'Browse the supplied promotional pages. Prices are shown exactly on each flyer.',
            action: const _SeeAll(
              text: 'View catalogue',
              route: '/products',
            ),
          ),
          const SizedBox(height: 25),
          Responsive(
            builder: (context, columns, width) {
              final mobile = width < 600;
              // Force 2 columns on mobile screens
              final effectiveColumns = mobile || columns == 1 ? 2 : columns;

              final itemCount = mobile ? 4 : pages.length;
              final shown = pages.take(itemCount).toList();

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shown.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: effectiveColumns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: mobile ? 0.66 : 0.72,
                ),
                itemBuilder: (context, index) {
                  final page = shown[index];
                  return CataloguePageCard(
                    page: page,
                    onTap: () => openCataloguePage(context, page),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

// ============================================================
// FRESH EVERYDAY
// ============================================================

class _FreshEveryday extends StatelessWidget {
  const _FreshEveryday();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mint,
      padding: const EdgeInsets.symmetric(
        vertical: 54,
        horizontal: 16,
      ),
      child: PageContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final vertical = constraints.maxWidth < 700;

            final image = ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: AspectRatio(
                aspectRatio: vertical ? 1.6 : 1.08,
                child: Image.asset(
                  'assets/catalog/catalog_19.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            );

            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'FRESH EVERY DAY',
                  style: TextStyle(
                    color: AppColors.green,
                    letterSpacing: 1.5,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 13),

                const Text(
                  'Good food starts\nwith good ingredients.',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                    height: 1.12,
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'From crisp vegetables to fresh fish and creamy dairy, '
                  'our teams choose quality every morning so you can '
                  'bring home food you feel good about.',
                  style: TextStyle(
                    color: AppColors.muted,
                    height: 1.65,
                  ),
                ),

                const SizedBox(height: 21),

                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/categories',
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 16,
                  ),
                  label: const Text(
                    'Discover fresh picks',
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.green,
                    side: const BorderSide(
                      color: AppColors.green,
                    ),
                  ),
                ),
              ],
            );

            return Flex(
              direction: vertical
                  ? Axis.vertical
                  : Axis.horizontal,
              crossAxisAlignment:
                  CrossAxisAlignment.center,
              children: [
                if (vertical)
                  image
                else
                  Expanded(
                    flex: 5,
                    child: image,
                  ),

                SizedBox(
                  width: vertical ? 0 : 65,
                  height: vertical ? 30 : 0,
                ),

                if (vertical)
                  copy
                else
                  Expanded(
                    flex: 5,
                    child: copy,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORY PRODUCTS
// ============================================================

class _CategoryProducts extends StatelessWidget {
  const _CategoryProducts();

  @override
  Widget build(BuildContext context) {
    final featured = categories.take(4).toList();

    return _SectionWrap(
      child: Column(
        children: [
          const SectionTitle(
            eyebrow: 'Browse the collection',
            title: 'Explore the real catalogue',
            subtitle:
                'Open a category to see the original promotional pages and printed prices.',
          ),
          const SizedBox(height: 28),
          Responsive(
            builder: (context, columns, width) {
              final mobile = width < 600;
              // Force 2 columns on mobile screens
              final effectiveColumns = mobile || columns == 1 ? 2 : columns;

              final shown = mobile ? featured.take(2).toList() : featured;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: shown.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: effectiveColumns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: width < 520 ? 0.75 : 0.82,
                ),
                itemBuilder: (context, index) {
                  final category = shown[index];
                  return CategoryCard(
                    category: category,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(category: category),
                        ),
                      );
                    },
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}

// ============================================================
// HOME - BRANDS

// ============================================================

class _HomeBrands extends StatelessWidget {
  const _HomeBrands();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pale,
      padding: const EdgeInsets.symmetric(
        vertical: 52,
        horizontal: 16,
      ),
      child: PageContainer(
        child: Column(
          children: [
            SectionTitle(
              eyebrow: 'Trusted names',
              title: 'Brands you already know',
              action: const _SeeAll(
                text: 'View all brands',
                route: '/brands',
              ),
            ),

            const SizedBox(height: 25),

            Responsive(
              builder: (context, columns, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: brands.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return BrandCard(
                      brand: brands[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/products',
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// WHY US
// ============================================================


// ============================================================
// HOME - BRANCHES
// ============================================================

class _HomeBranches extends StatelessWidget {
  const _HomeBranches();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.pale,
      padding: const EdgeInsets.symmetric(
        vertical: 52,
        horizontal: 16,
      ),
      child: PageContainer(
        child: Column(
          children: [
            SectionTitle(
              eyebrow: 'Come say hello',
              title: 'Find a branch near you',
              subtitle:
                  'Good food is even better when it is close by.',
              action: const _SeeAll(
                text: 'All branches',
                route: '/branches',
              ),
            ),

            const SizedBox(height: 25),

            Responsive(
              builder: (context, columns, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: branches.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio:
                        columns == 2 ? 0.98 : 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final branch = branches[index];

                    return BranchCard(
                      branch: branch,
                      onTap: () {
                        openBranch(
                          context,
                          branch,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// ABOUT PREVIEW
// ============================================================

class _AboutPreview extends StatelessWidget {
  const _AboutPreview();

  @override
  Widget build(BuildContext context) {
    return _SectionWrap(
      child: Container(
        padding: const EdgeInsets.all(34),
        decoration: BoxDecoration(
          color: AppColors.darkGreen,
          borderRadius: BorderRadius.circular(24),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final vertical =
                constraints.maxWidth < 650;

            const heading = Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'ABOUT MAKKAH',
                  style: TextStyle(
                    color: Color(0xFF9DD5AD),
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'A little more care\nin every aisle.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),
              ],
            );

            final copy = Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'We are committed to providing quality everyday '
                  'grocery products in a convenient and trusted '
                  'shopping environment.',
                  style: TextStyle(
                    color: Color(0xFFD0E7D7),
                    height: 1.7,
                  ),
                ),

                const SizedBox(height: 17),

                TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/about',
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                  icon: const Icon(
                    Icons.arrow_forward,
                    size: 16,
                  ),
                  label: const Text('Our story'),
                ),
              ],
            );

            return Flex(
              direction: vertical
                  ? Axis.vertical
                  : Axis.horizontal,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                if (vertical)
                  heading
                else
                  const Expanded(
                    child: heading,
                  ),

                SizedBox(
                  width: vertical ? 0 : 45,
                  height: vertical ? 22 : 0,
                ),

                if (vertical)
                  copy
                else
                  Expanded(
                    child: copy,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// REVIEWS
// ============================================================

class _Reviews extends StatelessWidget {
  const _Reviews();

  @override
  Widget build(BuildContext context) {
    return _SectionWrap(
      child: Column(
        children: [
          SectionTitle(
            eyebrow: 'Kind words',
            title: 'What our customers say',
          ),

          const SizedBox(height: 24),

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final columns = width > 850
                  ? 4
                  : width > 560
                      ? 2
                      : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: reviews.length,
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final review = reviews[index];

                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.pale,
                      borderRadius:
                          BorderRadius.circular(17),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '★★★★★',
                          style: TextStyle(
                            color: AppColors.orange,
                            letterSpacing: 2,
                          ),
                        ),

                        const SizedBox(height: 13),

                        Expanded(
                          child: Text(
                            '“${review.$2}”',
                            style: const TextStyle(
                              color: AppColors.ink,
                              height: 1.5,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor:
                                  AppColors.green,
                              child: Text(
                                review.$3,
                                style:
                                    const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w800,
                                ),
                              ),
                            ),

                            const SizedBox(width: 9),

                            Text(
                              review.$1,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.w800,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CONTACT PREVIEW
// ============================================================

class _ContactPreview extends StatelessWidget {
  const _ContactPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mint,
      padding: const EdgeInsets.symmetric(
        vertical: 48,
        horizontal: 16,
      ),
      child: PageContainer(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const copy = Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'HAVE A QUESTION?',
                  style: TextStyle(
                    color: AppColors.green,
                    letterSpacing: 1.4,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 11),
                Text(
                  'We are here to help.',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Reach out to our team or visit your nearest branch.',
                  style: TextStyle(
                    color: AppColors.muted,
                  ),
                ),
              ],
            );

            final button = ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/contact',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Contact us'),
            );

            if (constraints.maxWidth < 600) {
              return Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  copy,
                  const SizedBox(height: 20),
                  button,
                ],
              );
            }

            return Row(
              children: [
                const Expanded(
                  child: copy,
                ),
                button,
              ],
            );
          },
        ),
      ),
    );
  }
}

// ============================================================
// COMMON SECTION WRAPPER
// ============================================================

class _SectionWrap extends StatelessWidget {
  final Widget child;

  const _SectionWrap({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final vertical = constraints.maxWidth < 600;

        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: vertical ? 42 : 56,
            horizontal: 16,
          ),
          child: PageContainer(
            padding: EdgeInsets.zero,
            child: child,
          ),
        );
      },
    );
  }
}

// ============================================================
// SEE ALL
// ============================================================

class _SeeAll extends StatelessWidget {
  final String text;
  final String route;

  const _SeeAll({
    required this.text,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: TextButton.styleFrom(
        foregroundColor: AppColors.green,
        padding: EdgeInsets.zero,
      ),
      icon: const Icon(
        Icons.arrow_forward,
        size: 15,
      ),
      label: Text(text),
    );
  }
}

// ============================================================
// PAGE HERO
// ============================================================

class PageHero extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String subtitle;
  final String active;

  const PageHero({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeader(active: active),
        Container(
          color: AppColors.pale,
          width: double.infinity,
          child: PageContainer(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: MediaQuery.sizeOf(context).width < 600 ? 34 : 48,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final small = constraints.maxWidth < 600;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eyebrow.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.green,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w800,
                        fontSize: 10.5,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: small ? 30 : 40,
                            height: 1.08,
                          ),
                    ),
                    const SizedBox(height: 9),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 760),
                      child: Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: small ? 14 : 16,
                            ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// STANDARD PAGE
// ============================================================

class StandardPage extends StatelessWidget {
  final String active;
  final Widget body;

  const StandardPage({
    super.key,
    required this.active,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            body,
            const AppFooter(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CATEGORIES SCREEN
// ============================================================

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPage(
      active: 'Categories',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'The collection',
            title: 'Shop by category',
            subtitle:
                'Every category below is built from the real promotional catalogue supplied for Makkah Superstore.',
            active: 'Categories',
          ),
          _SectionWrap(
            child: Responsive(
              builder: (context, columns, width) {
                final mobile = width < 600;
                // Force 2 columns on mobile screens
                final effectiveColumns = mobile || columns == 1 ? 2 : columns;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: effectiveColumns,
                    crossAxisSpacing: mobile ? 12 : 18,
                    mainAxisSpacing: mobile ? 12 : 18,
                    childAspectRatio: mobile ? 0.75 : 0.82,
                  ),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CategoryProductsScreen(category: category),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CATEGORY PRODUCTS SCREEN
// ============================================================

class CategoryProductsScreen extends StatelessWidget {
  final Category category;

  const CategoryProductsScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final list = cataloguePages
        .where((page) => page.category == category.name)
        .toList();

    return StandardPage(
      active: 'Categories',
      body: Column(
        children: [
          PageHero(
            eyebrow: 'Catalogue category',
            title: category.name,
            subtitle: category.description,
            active: 'Categories',
          ),
          _SectionWrap(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${list.length} catalogue pages',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    const Text(
                      'Prices are printed on each flyer',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (list.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 42,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pale,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 38,
                          color: AppColors.green,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No catalogue pages found',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Try a different product, brand or category name.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  )
                else
                  Responsive(
                    builder: (context, columns, width) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: width < 600 ? 0.66 : 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final page = list[index];
                          return CataloguePageCard(
                            page: page,
                            onTap: () => openCataloguePage(context, page),
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PRODUCTS SCREEN
// ============================================================

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final search = query.trim().toLowerCase();
    final list = cataloguePages.where((page) {
      if (search.isEmpty) return true;
      return page.title.toLowerCase().contains(search) ||
          page.category.toLowerCase().contains(search);
    }).toList();

    return StandardPage(
      active: 'Products',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'The catalogue',
            title: 'Current promotional pages',
            subtitle:
                'Search the supplied catalogue and open any page to zoom in and read the printed prices.',
            active: 'Products',
          ),
          _SectionWrap(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => query = value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search categories or catalogue pages...',
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${list.length} catalogue pages',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                    ),
                    if (query.isNotEmpty)
                      TextButton(
                        onPressed: () => setState(() => query = ''),
                        child: const Text('Clear search'),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                if (list.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 42,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pale,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 38,
                          color: AppColors.green,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'No catalogue pages found',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Try a different product, brand or category name.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.muted),
                        ),
                      ],
                    ),
                  )
                else
                  Responsive(
                    builder: (context, columns, width) {
                      // Force 2 columns when width is less than 600
                      final effectiveColumns = width < 600 ? 2 : columns;

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: effectiveColumns,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: width < 600 ? 0.66 : 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final page = list[index];
                          return CataloguePageCard(
                            page: page,
                            onTap: () => openCataloguePage(context, page),
                          );
                        },
                      );
                    },
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PRODUCT DETAILS
// ============================================================

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final related = products
        .where(
          (item) =>
              item.category == product.category &&
              item.id != product.id,
        )
        .take(4)
        .toList();

    final details = Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          product.category.toUpperCase(),
          style: const TextStyle(
            color: AppColors.green,
            letterSpacing: 1.4,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          product.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall,
        ),

        const SizedBox(height: 9),

        Text(
          'Brand: ${product.brand}',
          style: const TextStyle(
            color: AppColors.muted,
          ),
        ),

        const SizedBox(height: 21),

        Row(
          crossAxisAlignment:
              CrossAxisAlignment.end,
          children: [
            Text(
              '৳${product.price.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 30,
                color: AppColors.darkGreen,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(width: 8),

            Padding(
              padding:
                  const EdgeInsets.only(bottom: 5),
              child: Text(
                product.unit,
                style: const TextStyle(
                  color: AppColors.muted,
                ),
              ),
            ),

            if (product.oldPrice != null) ...[
              const SizedBox(width: 15),

              Padding(
                padding:
                    const EdgeInsets.only(bottom: 5),
                child: Text(
                  '৳${product.oldPrice!.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppColors.muted,
                    decoration:
                        TextDecoration.lineThrough,
                  ),
                ),
              ),
            ],
          ],
        ),

        const SizedBox(height: 20),

        Text(
          product.description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge,
        ),

        const SizedBox(height: 25),

        OutlinedButton.icon(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/products',
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 16,
          ),
          label: const Text(
            'Browse more products',
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.green,
          ),
        ),
      ],
    );

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: AspectRatio(
        aspectRatio: 1.15,
        child: Image.asset(
          product.image,
          fit: BoxFit.cover,
        ),
      ),
    );

    return StandardPage(
      active: 'Products',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'Product details',
            title: 'A closer look',
            subtitle:
                'Learn more about what is in your basket.',
            active: 'Products',
          ),

          _SectionWrap(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final vertical =
                        constraints.maxWidth < 700;

                    return Flex(
                      direction: vertical
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        if (vertical)
                          image
                        else
                          Expanded(
                            child: image,
                          ),

                        SizedBox(
                          width:
                              vertical ? 0 : 50,
                          height:
                              vertical ? 28 : 0,
                        ),

                        if (vertical)
                          details
                        else
                          Expanded(
                            child: details,
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 48),

                SectionTitle(
                  eyebrow: 'You may also like',
                  title:
                      'More from ${product.category}',
                ),

                const SizedBox(height: 22),

                Responsive(
                  builder: (context, columns, _) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      itemCount: related.length,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio:
                            columns == 2
                                ? 0.71
                                : 0.75,
                      ),
                      itemBuilder:
                          (context, index) {
                        final item =
                            related[index];

                        return ProductCard(
                          product: item,
                          onTap: () {
                            openProduct(
                              context,
                              item,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// OFFERS
// ============================================================

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPage(
      active: 'Offers',
      body: Column(
        children: [
          const PageHero(
            eyebrow:
                'Good value, thoughtfully chosen',
            title: 'Current offers',
            subtitle:
                'Special picks and seasonal savings, with no complicated checkout.',
            active: 'Offers',
          ),

          _SectionWrap(
            child: Responsive(
              builder: (context, columns, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: offers.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        columns > 2 ? 3 : columns,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17,
                    childAspectRatio: 1.08,
                  ),
                  itemBuilder: (context, index) {
                    return OfferCard(
                      offer: offers[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/products',
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BRANDS
// ============================================================

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPage(
      active: 'Brands',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'Names worth knowing',
            title: 'Trusted brands',
            subtitle:
                'A considered selection of brands we are happy to put on our shelves.',
            active: 'Brands',
          ),

          _SectionWrap(
            child: Responsive(
              builder: (context, columns, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: brands.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17,
                    childAspectRatio: 1.25,
                  ),
                  itemBuilder: (context, index) {
                    return BrandCard(
                      brand: brands[index],
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/products',
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BRANCHES
// ============================================================

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPage(
      active: 'Branches',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'Visit in person',
            title: 'Our branches',
            subtitle:
                'Find fresh choices and a friendly welcome across Sylhet.',
            active: 'Branches',
          ),

          _SectionWrap(
            child: Responsive(
              builder: (context, columns, _) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics:
                      const NeverScrollableScrollPhysics(),
                  itemCount: branches.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        columns > 2 ? 3 : columns,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17,
                    childAspectRatio:
                        columns == 2 ? 0.98 : 1.1,
                  ),
                  itemBuilder: (context, index) {
                    final branch =
                        branches[index];

                    return BranchCard(
                      branch: branch,
                      onTap: () {
                        openBranch(
                          context,
                          branch,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// BRANCH DETAILS
// ============================================================

class BranchDetailsScreen extends StatelessWidget {
  final Branch branch;

  const BranchDetailsScreen({
    super.key,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    final image = ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: AspectRatio(
        aspectRatio: 1.45,
        child: Image.asset(
          branch.image,
          fit: BoxFit.cover,
        ),
      ),
    );

    final details = Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'COME BY ANYTIME',
          style: TextStyle(
            color: AppColors.green,
            letterSpacing: 1.4,
            fontSize: 11,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 15),

        Text(
          branch.description,
          style: Theme.of(context)
              .textTheme
              .bodyLarge,
        ),

        const SizedBox(height: 25),

        _InfoRow(
          icon: Icons.location_on_outlined,
          title: 'Address',
          value: branch.address,
        ),

        _InfoRow(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: branch.phone,
        ),

        _InfoRow(
          icon: Icons.schedule_outlined,
          title: 'Opening hours',
          value: branch.openingHours,
        ),
      ],
    );

    return StandardPage(
      active: 'Branches',
      body: Column(
        children: [
          PageHero(
            eyebrow: 'Branch details',
            title: branch.name,
            subtitle: branch.address,
            active: 'Branches',
          ),

          _SectionWrap(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final vertical =
                    constraints.maxWidth < 700;

                return Flex(
                  direction: vertical
                      ? Axis.vertical
                      : Axis.horizontal,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    if (vertical)
                      image
                    else
                      Expanded(
                        child: image,
                      ),

                    SizedBox(
                      width:
                          vertical ? 0 : 48,
                      height:
                          vertical ? 28 : 0,
                    ),

                    if (vertical)
                      details
                    else
                      Expanded(
                        child: details,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// INFO ROW
// ============================================================

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 17,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.green,
            size: 20,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ABOUT
// ============================================================

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPage(
      active: 'About',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'Our story',
            title: 'A better everyday shop',
            subtitle:
                'Makkah Superstore is built around a simple idea: good food and good service should be easy to find.',
            active: 'About',
          ),

          _SectionWrap(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final image = ClipRRect(
                      borderRadius:
                          BorderRadius.circular(22),
                      child: Image.asset(
                        'assets/catalog/catalog_19.jpg',
                        height: 340,
                        fit: BoxFit.cover,
                      ),
                    );

                    const copy = Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'WHY WE EXIST',
                          style: TextStyle(
                            color: AppColors.green,
                            letterSpacing: 1.4,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          'We make everyday shopping feel a little more considered.',
                          style: TextStyle(
                            fontSize: 28,
                            color: AppColors.ink,
                            fontWeight:
                                FontWeight.w800,
                            height: 1.15,
                          ),
                        ),

                        SizedBox(height: 14),

                        Text(
                          'From our first store to our growing family of branches, '
                          'we have stayed focused on quality, freshness and a warm '
                          'experience for every customer. Our shelves are curated '
                          'for real households and real routines.',
                          style: TextStyle(
                            color: AppColors.muted,
                            height: 1.7,
                          ),
                        ),
                      ],
                    );

                    final vertical =
                        constraints.maxWidth < 700;

                    return Flex(
                      direction: vertical
                          ? Axis.vertical
                          : Axis.horizontal,
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        if (vertical)
                          image
                        else
                          Expanded(
                            child: image,
                          ),

                        SizedBox(
                          width:
                              vertical ? 0 : 45,
                          height:
                              vertical ? 28 : 0,
                        ),

                        if (vertical)
                          copy
                        else
                          const Expanded(
                            child: copy,
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 48),

                const SectionTitle(
                  eyebrow: 'Our values',
                  title:
                      'What guides us every day',
                ),

                const SizedBox(height: 22),

                const _ValueCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VALUE CARDS
// ============================================================

class _ValueCards extends StatelessWidget {
  const _ValueCards();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 17,
      runSpacing: 17,
      children: [
        _ValueCard(
          icon: Icons.flag_outlined,
          title: 'Our mission',
          text:
              'To make quality everyday essentials accessible, simple and pleasant to shop.',
        ),
        _ValueCard(
          icon: Icons.visibility_outlined,
          title: 'Our vision',
          text:
              'To be the most trusted neighbourhood super shop in every community we serve.',
        ),
        _ValueCard(
          icon: Icons.favorite_border,
          title: 'Our commitment',
          text:
              'To keep choosing freshness, fair value and friendly service, one aisle at a time.',
        ),
      ],
    );
  }
}

class _ValueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;

  const _ValueCard({
    required this.icon,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.pale,
          borderRadius:
              BorderRadius.circular(17),
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: AppColors.green,
            ),

            const SizedBox(height: 14),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              text,
              style: const TextStyle(
                color: AppColors.muted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CONTACT
// ============================================================

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() =>
      _ContactScreenState();
}

class _ContactScreenState
    extends State<ContactScreen> {
  final formKey = GlobalKey<FormState>();

  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    final info = Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Let’s talk',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 27,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 13),

        const Text(
          'Our team is available during store hours to help with product questions, '
          'branch information and general feedback.',
          style: TextStyle(
            color: AppColors.muted,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 28),

        const _InfoRow(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: '+8801313921708',
        ),


        const _InfoRow(
          icon: Icons.schedule_outlined,
          title: 'Opening hours',
          value: 'Every day, 8:00 AM – 10:00 PM',
        ),
      ],
    );

    final form = Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            decoration:
                const InputDecoration(
              labelText: 'Your name',
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'Please enter your name';
              }

              return null;
            },
          ),

          const SizedBox(height: 14),

          TextFormField(
            decoration:
                const InputDecoration(
              labelText: 'Email address',
            ),
            validator: (value) {
              if (value == null ||
                  !value.contains('@')) {
                return 'Enter a valid email';
              }

              return null;
            },
          ),

          const SizedBox(height: 14),

          TextFormField(
            minLines: 5,
            maxLines: 7,
            decoration:
                const InputDecoration(
              labelText: 'Message',
              alignLabelWithHint: true,
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty) {
                return 'Please enter a message';
              }

              return null;
            },
          ),

          const SizedBox(height: 17),

          Align(
            alignment:
                Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!
                    .validate()) {
                  setState(() {
                    submitted = true;
                  });
                }
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    AppColors.green,
                foregroundColor:
                    Colors.white,
              ),
              child:
                  const Text('Send message'),
            ),
          ),

          if (submitted)
            const Padding(
              padding:
                  EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: AppColors.green,
                    size: 18,
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      'Thanks — your message has been validated.',
                      style: TextStyle(
                        color:
                            AppColors.green,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );

    return StandardPage(
      active: 'Contact',
      body: Column(
        children: [
          const PageHero(
            eyebrow:
                'We would love to hear from you',
            title: 'Contact us',
            subtitle:
                'Questions, feedback or just want to say hello? Send us a note.',
            active: 'Contact',
          ),

          _SectionWrap(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final vertical =
                    constraints.maxWidth < 750;

                return Flex(
                  direction: vertical
                      ? Axis.vertical
                      : Axis.horizontal,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    if (vertical)
                      info
                    else
                      Expanded(
                        child: info,
                      ),

                    SizedBox(
                      width:
                          vertical ? 0 : 55,
                      height:
                          vertical ? 35 : 0,
                    ),

                    if (vertical)
                      form
                    else
                      Expanded(
                        child: form,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FAQ
// ============================================================

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardPage(
      active: 'FAQ',
      body: Column(
        children: [
          const PageHero(
            eyebrow: 'Need to know',
            title:
                'Frequently asked questions',
            subtitle:
                'A few quick answers about Makkah Superstore and our stores.',
            active: 'FAQ',
          ),

          _SectionWrap(
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(
                maxWidth: 850,
              ),
              child: const Column(
                children: [
                  _Faq(
                    question:
                        'What products do you sell?',
                    answer:
                        'We offer groceries, vegetables, fruits, fish, meat, dairy, beverages, snacks and household products.',
                  ),

                  _Faq(
                    question:
                        'Do you provide online ordering?',
                    answer:
                        'Currently, this website is a product catalogue and store information platform. Please visit one of our branches to shop.',
                  ),

                  _Faq(
                    question:
                        'Where are your branches?',
                    answer:
                        'You can view all branch locations, addresses, phone numbers and opening hours on our Branches page.',
                  ),

                  _Faq(
                    question:
                        'What are your opening hours?',
                    answer:
                        'Most Makkah Superstore branches are open every day from 8:00 AM to 10:00 PM. Please check the branch details for exact hours.',
                  ),

                  _Faq(
                    question:
                        'Can I suggest a product or brand?',
                    answer:
                        'Absolutely. Send us a message through the Contact page and tell us what you would like to see on our shelves.',
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

class _Faq extends StatelessWidget {
  final String question;
  final String answer;

  const _Faq({
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 0,
      color: AppColors.pale,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        iconColor: AppColors.green,
        collapsedIconColor:
            AppColors.muted,
        childrenPadding:
            const EdgeInsets.fromLTRB(
          20,
          0,
          20,
          18,
        ),
        children: [
          Align(
            alignment:
                Alignment.centerLeft,
            child: Text(
              answer,
              style: const TextStyle(
                color: AppColors.muted,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}