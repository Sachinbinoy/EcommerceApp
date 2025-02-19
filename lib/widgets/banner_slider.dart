import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:testapp/viewmodels/banner_viewmodel.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BannerViewModel()..fetchBanners(),
      child: const BannerSliderContent(),
    );
  }
}

class BannerSliderContent extends StatelessWidget {
  const BannerSliderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.banners.isEmpty) {
          return const SizedBox();
        }

        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  viewModel.updateCurrentIndex(index);
                },
              ),
              items:
                  viewModel.banners.map((banner) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(banner.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 10), // Add some spacing

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  viewModel.banners.asMap().entries.map((entry) {
                    return Container(
                      width: viewModel.currentIndex == entry.key ? 24.0 : 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      decoration: BoxDecoration(
                        color:
                            viewModel.currentIndex == entry.key
                                ? Color.fromRGBO(43, 66, 72, 1)
                                : Color.fromRGBO(43, 66, 72, 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
