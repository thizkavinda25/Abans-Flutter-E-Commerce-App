import 'package:abans_online/controllers/auth_controller.dart';
import 'package:abans_online/providers/user_provider.dart';
import 'package:abans_online/screens/admin/product_add_screen.dart';
import 'package:abans_online/utils/custom_colors.dart';
import 'package:abans_online/utils/navigator_manage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userData, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            NavigatorManage.goTo(context, ProductAddScreen());
                          },
                          icon: Icon(Icons.menu, size: 25),
                        ),
                        Image.asset('assets/images/text_logo.png', height: 25),
                        IconButton(
                          onPressed: () async {
                            EasyLoading.show(status: 'Signing Out');
                            await AuthController().signOut(context);
                            EasyLoading.dismiss();
                          },
                          icon: Icon(Icons.more_vert, size: 25),
                        ),
                      ],
                    ),
                  ),
                ),

                CarouselSlider(
                  options: CarouselOptions(
                    height: 170.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                  ),
                  items:
                      [
                        'https://buyabans.com/cdn-cgi/imagedelivery/OgVIyabXh1YHxwM0lBwqgA/home_banner_images/1kpFoox5aAeTcQGqVG4t90obutoTXmKscfvK7U8I.webp/public',
                        'https://buyabans.com/cdn-cgi/imagedelivery/OgVIyabXh1YHxwM0lBwqgA/home_banner_images/ARUOdiA1W0T1rdwnxpPlOunUXneJfLzhiCkZZnpV.webp/public',
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(i),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
                SizedBox(height: 30),
                RichText(
                  text: TextSpan(
                    text: 'Hello ${userData.user?.name},',
                    style: TextStyle(
                      color: CustomColors.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),

                    children: [
                      TextSpan(
                        text: ' What are you\nlooking for',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.grey.shade900,
                        ),
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
}
