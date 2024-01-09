import 'package:flutter/material.dart';

class BannerDetailScreen extends StatelessWidget {
  BannerDetailScreen({Key? key,required this.bannerImage}) : super(key: key);

  String bannerImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/images/background4.png'),
              colorFilter:  ColorFilter.mode(Colors.white.withOpacity(0.9), BlendMode.dstATop),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body:  Center(
          child:  Image(
            image: NetworkImage(bannerImage),
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
