import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startPageViewAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startPageViewAutoScroll() {
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBarRow(),
            _buildPageView(),
            _buildSmallProductCardsRow(), // Added small cards row
            _buildProductList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
      ),
    );
  }

  Widget _buildSearchBarRow() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: _buildSearchBar(),
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Add your shopping cart action here
            },
          ),
          SizedBox(width: 16.0),
          IconButton(
            icon: Icon(Icons.mail),
            onPressed: () {
              // Add your mail action here
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return Stack(
      children: [
        Container(
          height: 200.0,
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              _buildPageContainer('assets/page1.jpg'),
              _buildPageContainer('assets/page2.jpg'),
              _buildPageContainer('assets/page3.jpg'),
            ],
          ),
        ),
        Positioned(
          left: 8.0,
          top: 80.0,
          child: InkWell(
            onTap: () {
              _pageController.previousPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
              child: Icon(Icons.arrow_back, color: Colors.black.withOpacity(0.7)),
            ),
          ),
        ),
        Positioned(
          right: 8.0,
          top: 80.0,
          child: InkWell(
            onTap: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
              child: Icon(Icons.arrow_forward, color: Colors.black.withOpacity(0.7)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageContainer(String imagePath) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imagePath,
            height: 200.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSmallProductCard(String imagePath) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSmallProductCardsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSmallProductCard('assets/small_product1.jpg'),
        _buildSmallProductCard('assets/small_product2.jpg'),
        _buildSmallProductCard('assets/small_product3.jpg'),
        _buildSmallProductCard('assets/small_product4.jpg'),
        _buildSmallProductCard('assets/small_product5.jpg'),
      ],
    );
  }

  Widget _buildProductList() {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildProductRow(
          _buildLargeProductItem('SSD NVMe 512 GB', 'Rp1.599.000', 'assets/product4.jpg'),
          _buildLargeProductItem('Logitech MX Master 3S Performance Mouse Wireless Bluetooth', 'Rp1.581.000', 'assets/product5.jpg'),
        ),
        SizedBox(height: 16.0),
        _buildProductRow(
          _buildLargeProductItem('Kingston Fury Beast DDR5 RGB 16GB (2x8GB) 6000Mhz', 'Rp1.295.000', 'assets/product6.jpg'),
          _buildLargeProductItem('Rexus Headset Gaming Thundervox Stream HX20 - Putih', 'Rp419.000', 'assets/product7.jpg'),
        ),
        SizedBox(height: 16.0),
        _buildProductRow(
          _buildLargeProductItem('ASUS ROG Falchion Ace Compact Gaming Mechanical Keyboard', 'Rp1.529.000', 'assets/product8.jpg'),
          _buildLargeProductItem('ONEX GX1 Premium Quality Gaming Chair Kursi - Black', 'Rp1.298.000', 'assets/product9.jpg'),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildProductRow(Widget product1, Widget product2) {
    return Row(
      children: [
        Expanded(child: product1),
        SizedBox(width: 16.0),
        Expanded(child: product2),
      ],
    );
  }

  Widget _buildLargeProductItem(String title, String subtitle, String imagePath) {
    return Container(
      height: 350.0,
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: title.contains('Logitech') ? 10.0 : 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
