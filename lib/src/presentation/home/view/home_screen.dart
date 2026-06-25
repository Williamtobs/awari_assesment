import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../data/models/product.dart';
import '../../../data/repositories/product_repository.dart';
import '../widgets/category_filter_bar.dart';
import '../widgets/home_bottom_nav.dart';
import '../widgets/home_search_field.dart';
import '../widgets/home_top_bar.dart';
import '../widgets/product_masonry_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.repository = const ProductRepository()});

  final ProductRepository repository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final List<String> _categories = widget.repository.categories();
  late List<Product> _products = widget.repository.products();

  late String _selectedCategory = _categories.first;
  int _navIndex = 0;
  String _query = '';

  late final AnimationController _introController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  late final Animation<Offset> _headerSlide = _slide(const Offset(0, -0.35));

  late final Animation<Offset> _bodySlide = _slide(const Offset(0, 0.18));

  late final Animation<Offset> _bottomNavSlide = _slide(const Offset(0, 1));

  late final Animation<double> _fade = CurvedAnimation(
    parent: _introController,
    curve: const Interval(0, 0.7, curve: Curves.easeOut),
  );

  Animation<Offset> _slide(Offset begin) {
    return Tween<Offset>(begin: begin, end: Offset.zero).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void initState() {
    super.initState();
    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    super.dispose();
  }

  List<Product> get _visibleProducts {
    return _products.where((p) {
      final matchesCategory =
          _selectedCategory == 'Trending' || p.category == _selectedCategory;
      final matchesQuery =
          _query.isEmpty || p.name.toLowerCase().contains(_query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _toggleFavorite(Product product) {
    setState(() {
      _products = [
        for (final p in _products)
          p.id == product.id ? p.copyWith(isFavorite: !p.isFavorite) : p,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      bottomNavigationBar: HomeBottomNav(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
        contentSlide: _bottomNavSlide,
      ),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: AppDimensions.spaceXs),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: AppDimensions.spaceLg),
              decoration: BoxDecoration(
                color: AppColors.foregroundColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
              ),
              child: SlideTransition(
                position: _bodySlide,
                child: FadeTransition(
                  opacity: _fade,
                  child: Column(
                    children: [
                      _centered(
                        CategoryFilterBar(
                          categories: _categories,
                          selected: _selectedCategory,
                          onSelected: (c) =>
                              setState(() => _selectedCategory = c),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      Expanded(child: _buildGrid()),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.foregroundColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppDimensions.radiusHeader),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(
        AppDimensions.screenPadding,
        topInset + AppDimensions.spaceSm,
        AppDimensions.screenPadding,
        AppDimensions.spaceLg,
      ),
      child: SlideTransition(
        position: _headerSlide,
        child: FadeTransition(
          opacity: _fade,
          child: _centered(
            Column(
              children: [
                const HomeTopBar(),
                const SizedBox(height: AppDimensions.spaceMd),
                HomeSearchField(
                  onChanged: (value) => setState(() => _query = value),
                ),
              ],
            ),
            applyHorizontalPadding: false,
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    final products = _visibleProducts;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.screenPadding,
        0,
        AppDimensions.screenPadding,
        AppDimensions.spaceLg,
      ),
      children: [
        _centered(
          products.isEmpty
              ? const _EmptyState()
              : ProductMasonryGrid(
                  products: products,
                  onFavoriteToggle: _toggleFavorite,
                ),
          applyHorizontalPadding: false,
        ),
      ],
    );
  }

  Widget _centered(Widget child, {bool applyHorizontalPadding = true}) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: applyHorizontalPadding
            ? Padding(padding: const EdgeInsets.symmetric(), child: child)
            : child,
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 48,
            color: AppColors.ink.withValues(alpha: 0.3),
          ),
          const SizedBox(height: AppDimensions.spaceMd),
          const Text(
            'No products found',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Try a different category or search term.',
            style: TextStyle(fontSize: 13.5, color: AppColors.inkMuted),
          ),
        ],
      ),
    );
  }
}
