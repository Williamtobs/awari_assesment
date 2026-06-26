import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../data/models/product.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/detail_top_bar.dart';
import '../widgets/product_gallery.dart';
import '../widgets/size_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  int _imageIndex = 0;
  late int _sizeIndex = _defaultSizeIndex();

  late final AnimationController _introController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  late final Animation<Offset> _headerSlide = _slide(const Offset(0, -0.35));
  late final Animation<Offset> _bodySlide = _slide(const Offset(0, 0.18));
  late final Animation<Offset> _bottomSlide = _slide(const Offset(0, 1));

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

  int _defaultSizeIndex() {
    final index = widget.product.sizes.indexOf('M');
    return index == -1 ? 0 : index;
  }

  void _addToCart() {
    final size = widget.product.sizes[_sizeIndex];
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.ink,
          content: Text('${widget.product.name} (size $size) added to cart'),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      bottomNavigationBar: AddToCartButton(
        onPressed: _addToCart,
        contentSlide: _bottomSlide,
      ),
      body: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: AppDimensions.spaceXs),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.foregroundColor,
                borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
              ),
              child: _buildProductGallery(product),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.foregroundColor,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
            ),
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.screenPadding,
              AppDimensions.spaceLg,
              AppDimensions.screenPadding,
              AppDimensions.spaceLg,
            ),
            child: _centered(
              SlideTransition(
                position: _bodySlide,
                child: FadeTransition(
                  opacity: _fade,
                  child: _buildContent(product),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGallery(Product product) {
    return SlideTransition(
      position: _bodySlide,
      child: FadeTransition(
        opacity: _fade,
        child: ProductGallery(
          images: product.images,
          swatch: product.swatch,
          selectedIndex: _imageIndex,
          onSelected: (i) => setState(() => _imageIndex = i),
        ),
      ),
    );
  }

  Widget _buildContent(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                  height: 1.2,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spaceMd),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                'Price: ${product.euroPrice}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        const Text(
          'Select size',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.ink,
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSm),
        SizeSelector(
          sizes: product.sizes,
          selectedIndex: _sizeIndex,
          onSelected: (i) => setState(() => _sizeIndex = i),
        ),
        if (product.description.isNotEmpty) ...[
          const SizedBox(height: AppDimensions.spaceLg),
          Text(
            product.description,
            style: const TextStyle(
              fontSize: 14.5,
              height: 1.5,
              color: AppColors.inkMuted,
            ),
          ),
        ],
      ],
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
      child: _centered(
        SlideTransition(
          position: _headerSlide,
          child: FadeTransition(
            opacity: _fade,
            child: const DetailTopBar(title: 'Product'),
          ),
        ),
      ),
    );
  }

  Widget _centered(Widget child) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: child,
      ),
    );
  }
}
