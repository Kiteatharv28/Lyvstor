import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'product_detail_screen.dart';
import '../models/product_model.dart';
import '../providers/product_provider.dart';
import '../providers/favorites_provider.dart';
import '../utils/responsive.dart';
import '../widgets/skeleton_loader.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    Future.microtask(() {
      final productProvider = context.read<ProductProvider>();
      debugPrint('📱 CategoryScreen: Loading categories and products...');
      productProvider.loadCategories();
      productProvider.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, _) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFFFEF1F1), Color(0xFFFEDFDF), Color(0xFFFED3D3)],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                // Static Header Section
                Container(
                  padding: Responsive.getResponsivePadding(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: Responsive.getResponsiveHeight(context, 3)),
                      // Categories Title
                      Text(
                        'Categories',
                        style: GoogleFonts.poppins(
                          fontSize: Responsive.getFontSize(context, 28),
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF8B4545),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: Responsive.getResponsiveHeight(context, 2)),

                      // Category Tabs
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            productProvider.categories.length,
                            (index) => _buildCategoryTab(
                              productProvider.categories[index],
                              index,
                              productProvider,
                              context,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.getResponsiveHeight(context, 2)),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: Responsive.getResponsiveBorderRadius(context),
                          border: Border.all(color: Colors.grey[300]!, width: 1.5),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) => productProvider.search(value),
                          decoration: InputDecoration(
                            hintText: 'Search products',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: Responsive.getFontSize(context, 14),
                              color: Colors.grey[400],
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                              size: Responsive.getResponsiveIconSize(context),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: Responsive.getResponsiveValue(context, mobile: 16, tablet: 20, desktop: 24),
                              vertical: Responsive.getResponsiveValue(context, mobile: 10, tablet: 12, desktop: 14),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: Responsive.getResponsiveHeight(context, 2)),

                      // Sort Options
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildSortButton('Newest', 'newest', productProvider, context),
                            SizedBox(width: Responsive.getResponsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
                            _buildSortButton('Price: Low to High', 'price_low', productProvider, context),
                            SizedBox(width: Responsive.getResponsiveValue(context, mobile: 8, tablet: 12, desktop: 16)),
                            _buildSortButton('Price: High to Low', 'price_high', productProvider, context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Scrollable Products Grid
                Expanded(
                  child: productProvider.isLoading
                      ? SingleChildScrollView(
                          child: Padding(
                            padding: Responsive.getResponsiveHorizontalPadding(context),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Responsive.getCrossAxisCount(context),
                                crossAxisSpacing: Responsive.getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
                                mainAxisSpacing: Responsive.getResponsiveValue(context, mobile: 14, tablet: 18, desktop: 24),
                                childAspectRatio: Responsive.getGridChildAspectRatio(context),
                              ),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                return const ProductCardSkeleton();
                              },
                            ),
                          ),
                        )
                      : productProvider.error != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline,
                                      size: Responsive.getResponsiveIconSize(context) * 2, color: Colors.red),
                                  SizedBox(height: Responsive.getResponsiveHeight(context, 3)),
                                  Text(
                                    productProvider.error!,
                                    style: GoogleFonts.poppins(
                                      fontSize: Responsive.getFontSize(context, 14),
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(height: Responsive.getResponsiveHeight(context, 3)),
                                  ElevatedButton(
                                    onPressed: () {
                                      productProvider.loadProducts();
                                    },
                                    child: Text(
                                      'Retry',
                                      style: GoogleFonts.poppins(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : productProvider.products.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.shopping_bag_outlined,
                                          size: Responsive.getResponsiveIconSize(context) * 2, color: Colors.grey),
                                      SizedBox(height: Responsive.getResponsiveHeight(context, 3)),
                                      Text(
                                        'No products found',
                                        style: GoogleFonts.poppins(
                                          fontSize: Responsive.getFontSize(context, 14),
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Padding(
                                    padding: Responsive.getResponsiveHorizontalPadding(context),
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: Responsive.getCrossAxisCount(context),
                                        crossAxisSpacing: Responsive.getResponsiveValue(context, mobile: 12, tablet: 16, desktop: 20),
                                        mainAxisSpacing: Responsive.getResponsiveValue(context, mobile: 14, tablet: 18, desktop: 24),
                                        childAspectRatio: Responsive.getGridChildAspectRatio(context),
                                      ),
                                      itemCount: productProvider.products.length,
                                      itemBuilder: (context, index) {
                                        return _buildProductCard(
                                            productProvider.products[index], context);
                                      },
                                    ),
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

  Widget _buildCategoryTab(String label, int index, ProductProvider productProvider, BuildContext context) {
    final isSelected = _selectedCategoryIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
        productProvider.filterByCategory(label);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: Responsive.getResponsiveValue(context, mobile: 60, tablet: 70, desktop: 80),
            height: Responsive.getResponsiveValue(context, mobile: 60, tablet: 70, desktop: 80),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected ? Colors.red : Colors.grey[300]!,
                width: isSelected ? 3 : 2,
              ),
              borderRadius: Responsive.getResponsiveBorderRadius(context),
              image: const DecorationImage(
                image: AssetImage('assets/live image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: Responsive.getResponsiveValue(context, mobile: 4, tablet: 6, desktop: 8)),
          SizedBox(
            width: Responsive.getResponsiveValue(context, mobile: 60, tablet: 70, desktop: 80),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: Responsive.getFontSize(context, 10),
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortButton(String label, String value, ProductProvider productProvider, BuildContext context) {
    final isSelected = productProvider.sortBy == value;
    return GestureDetector(
      onTap: () {
        productProvider.sort(value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.getResponsiveValue(context, mobile: 12, tablet: 14, desktop: 16),
          vertical: Responsive.getResponsiveValue(context, mobile: 6, tablet: 8, desktop: 10),
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey[300]!,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: Responsive.getFontSize(context, 11),
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(Product product, BuildContext context) {
    final heroTag = 'product_${product.id}';
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, _) {
        final isFavorite = favoritesProvider.favorites.contains(product.id);
        
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  title: product.title,
                  price: product.price,
                  originalPrice: product.originalPrice,
                  discount: product.discount,
                  inStock: product.inStock,
                  stockQuantity: product.inStock ? 10 : 0,
                  heroTag: heroTag,
                ),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: heroTag,
                    child: Container(
                      height: Responsive.getResponsiveImageHeight(context),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 3),
                        borderRadius: Responsive.getResponsiveBorderRadius(context),
                        image: DecorationImage(
                          image: AssetImage(product.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Stock Status Badge
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.getResponsiveValue(context, mobile: 8, tablet: 10, desktop: 12),
                        vertical: Responsive.getResponsiveValue(context, mobile: 4, tablet: 5, desktop: 6),
                      ),
                      decoration: BoxDecoration(
                        color: product.inStock ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        product.inStock ? 'In Stock' : 'Out of Stock',
                        style: GoogleFonts.poppins(
                          fontSize: Responsive.getFontSize(context, 9),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Like Button
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        favoritesProvider.toggleFavorite(product.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.getResponsiveValue(context, mobile: 8, tablet: 10, desktop: 12)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 13),
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveValue(context, mobile: 2, tablet: 3, desktop: 4)),
                        Text(
                          product.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 11),
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: Responsive.getResponsiveValue(context, mobile: 2, tablet: 3, desktop: 4)),
                        Text(
                          '₹${product.price}',
                          style: GoogleFonts.poppins(
                            fontSize: Responsive.getFontSize(context, 11),
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
