import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      'https://example.com/advertisement1.jpg',
      'https://example.com/advertisement2.jpg',
      'https://example.com/advertisement3.jpg',
    ];

    return Scaffold(
      body: Center(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 200,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
          ),
          items: imageList.map((imageUrl) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(imageUrl, fit: BoxFit.cover),
            );
          }).toList(),
        ),
      ),
    );
  }
}
