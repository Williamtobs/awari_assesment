import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lumi_fashion_mobile/src/data/models/product.dart';
import 'package:lumi_fashion_mobile/src/presentation/home/view/home_screen.dart';
import 'package:lumi_fashion_mobile/src/presentation/home/widgets/category_filter_bar.dart';
import 'package:lumi_fashion_mobile/src/presentation/home/widgets/favorite_button.dart';
import 'package:lumi_fashion_mobile/src/presentation/home/widgets/product_card.dart';

Widget _wrap(Widget child) => MaterialApp(home: child);

void main() {
  testWidgets('renders brand, search and the product catalogue', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const HomeScreen()));
    await tester.pump();

    expect(find.text('Lumière'), findsOneWidget);
    expect(find.text('Search your needs'), findsOneWidget);
    expect(find.text("Men' Pullover Hoodie"), findsOneWidget);
    expect(find.text('\$97'), findsOneWidget);
    expect(find.byType(ProductCard), findsNWidgets(4));
  });

  testWidgets('searching filters the grid down to matches', (tester) async {
    await tester.pumpWidget(_wrap(const HomeScreen()));
    await tester.pump();

    await tester.enterText(find.byType(TextField), 'jersey');
    await tester.pump();

    expect(find.text("Men's Sport Jersey"), findsOneWidget);
    expect(find.text("Men' Pullover Hoodie"), findsNothing);
    expect(find.byType(ProductCard), findsOneWidget);
  });

  testWidgets('selecting a category highlights it and filters products', (
    tester,
  ) async {
    await tester.pumpWidget(_wrap(const HomeScreen()));
    await tester.pump();

    await tester.drag(find.text('Trending'), const Offset(-300, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Shirts'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductCard), findsOneWidget);
    expect(find.text("Men's Sport Jersey"), findsOneWidget);
  });

  testWidgets('tapping the heart toggles favourite state', (tester) async {
    await tester.pumpWidget(_wrap(const HomeScreen()));
    await tester.pump();

    final hoodieCard = find.widgetWithText(ProductCard, "Men' Pullover Hoodie");
    final heart = find.descendant(
      of: hoodieCard,
      matching: find.byType(FavoriteButton),
    );

    expect(
      tester.widget<FavoriteButton>(heart).isFavorite,
      isFalse,
    );

    await tester.tap(heart);
    await tester.pump();

    expect(
      tester.widget<FavoriteButton>(heart).isFavorite,
      isTrue,
    );
  });

  test('Product.formattedPrice renders a whole-dollar string', () {
    const product = Product(
      id: 'x',
      name: 'Test',
      price: 42,
      category: 'Shirts',
      swatch: Color(0xFFEEEEEE),
    );
    expect(product.formattedPrice, '\$42');
  });

  test('CategoryFilterBar is exported and usable', () {
    expect(CategoryFilterBar, isNotNull);
  });
}
