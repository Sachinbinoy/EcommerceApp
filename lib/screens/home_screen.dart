// import 'package:flutter/material.dart';
// import '../widgets/banner_slider.dart';
// import '../widgets/product_grid.dart';
// import 'wishlist_screen.dart';
// import 'profile_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _currentIndex = 0;
//   final _searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Show search bar only for Home tab
//             if (_currentIndex == 0)
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 16,
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   decoration: InputDecoration(
//                     hintText: 'Search',
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(65),
//                       borderSide: BorderSide.none,
//                     ),
//                     suffixIcon: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: Image.asset(
//                         'assets/icons/Search.png',
//                         width: 36,
//                         height: 28,
//                       ),
//                     ),
//                   ),
//                   style: const TextStyle(
//                     fontFamily: "lato",
//                     fontWeight: FontWeight.w400,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//             Expanded(
//               child: IndexedStack(
//                 index: _currentIndex,
//                 children: [
//                   // Home Tab
//                   ListView(
//                     children: const [
//                       BannerSlider(),
//                       Padding(
//                         padding: EdgeInsets.only(left: 6, bottom: 6),
//                         child: Text(
//                           "Popular Product",
//                           style: TextStyle(
//                             fontFamily: "Heebo",
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Color.fromRGBO(29, 35, 72, 1),
//                           ),
//                         ),
//                       ),
//                       ProductGrid(),
//                     ],
//                   ),
//                   // Wishlist Tab
//                   const WishlistScreen(),
//                   // Profile Tab
//                   const ProfileScreen(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 72,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30),
//           boxShadow: [
//             BoxShadow(
//               color: const Color.fromARGB(183, 49, 49, 49).withOpacity(0.18),
//               spreadRadius: 1,
//               blurRadius: 10,
//             ),
//           ],
//         ),
//         margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(
//               icon: Icons.home_outlined,
//               label: 'Home',
//               isSelected: _currentIndex == 0,
//               onTap: () => setState(() => _currentIndex = 0),
//             ),
//             _buildNavItem(
//               icon: Icons.favorite_outline,
//               label: 'Wishlist',
//               isSelected: _currentIndex == 1,
//               onTap: () => setState(() => _currentIndex = 1),
//             ),
//             _buildNavItem(
//               icon: Icons.person_outline,
//               label: 'Profile',
//               isSelected: _currentIndex == 2,
//               onTap: () => setState(() => _currentIndex = 2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem({
//     required IconData icon,
//     required String label,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 56,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
//           borderRadius: BorderRadius.circular(45),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? Colors.white : Colors.grey,
//               size: 24,
//             ),
//             if (isSelected) ...[
//               const SizedBox(width: 8),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/viewmodels/search_viewmodel.dart';
import '../widgets/banner_slider.dart';
import '../widgets/product_grid.dart';
import 'wishlist_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchResults() {
    return Consumer<SearchViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  viewModel.error!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontFamily: "Oxygen",
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => viewModel.searchProducts(_searchController.text),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (viewModel.searchResults != null) {
          if (viewModel.searchResults!.isEmpty) {
            return const Center(
              child: Text(
                'No products found',
                style: TextStyle(
                  fontFamily: "Oxygen",
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.searchResults!.length,
            itemBuilder: (context, index) {
              final product = viewModel.searchResults![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (product.featuredImage != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.featuredImage!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Heebo",
                                color: Color.fromRGBO(29, 35, 72, 1),
                              ),
                            ),
                            if (product.caption != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                product.caption!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Oxygen",
                                  color: Color.fromRGBO(146, 146, 146, 1),
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '₹${product.salePrice ?? product.mrp ?? 0}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF6C63FF),
                                    fontFamily: "Heebo",
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: product.isActive == true
                                        ? const Color(0xFFE8F5E9)
                                        : const Color(0xFFFFEBEE),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    product.isActive == true
                                        ? 'Available'
                                        : 'Unavailable',
                                    style: TextStyle(
                                      color: product.isActive == true
                                          ? Colors.green[700]
                                          : Colors.red[700],
                                      fontSize: 12,
                                      fontFamily: "Oxygen",
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
            },
          );
        }

        return ListView(
          children: const [
            BannerSlider(),
            Padding(
              padding: EdgeInsets.only(left: 6, bottom: 6),
              child: Text(
                "Popular Product",
                style: TextStyle(
                  fontFamily: "Heebo",
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(29, 35, 72, 1),
                ),
              ),
            ),
            ProductGrid(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            if (_currentIndex == 0)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(65),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isSearching)
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _isSearching = false);
                              context.read<SearchViewModel>().searchProducts('');
                            },
                          ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _isSearching = true);
                              context
                                  .read<SearchViewModel>()
                                  .searchProducts(_searchController.text);
                            },
                            child: Image.asset(
                              'assets/icons/Search.png',
                              width: 36,
                              height: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: "lato",
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                  onChanged: (value) {
                    setState(() => _isSearching = value.isNotEmpty);
                    if (value.isEmpty) {
                      context.read<SearchViewModel>().searchProducts('');
                    }
                  },
                  onSubmitted: (value) {
                    setState(() => _isSearching = value.isNotEmpty);
                    context.read<SearchViewModel>().searchProducts(value);
                  },
                ),
              ),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  _buildSearchResults(),
                  const WishlistScreen(),
                  const ProfileScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 72,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(183, 49, 49, 49).withOpacity(0.18),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: _currentIndex == 0,
              onTap: () => setState(() => _currentIndex = 0),
            ),
            _buildNavItem(
              icon: Icons.favorite_outline,
              label: 'Wishlist',
              isSelected: _currentIndex == 1,
              onTap: () => setState(() => _currentIndex = 1),
            ),
            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: _currentIndex == 2,
              onTap: () => setState(() => _currentIndex = 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.transparent,
          borderRadius: BorderRadius.circular(45),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
