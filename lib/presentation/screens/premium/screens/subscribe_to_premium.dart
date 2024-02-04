// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/constants/image.list.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/premium/screens/payment_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class SubscribeToPremiumPage extends StatelessWidget {
  const SubscribeToPremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //CAROUSEL
                _carousel(context),


                //DESCRIPTION TEXT
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  child: Text(
                    '₹699 for LifeTime PRO status',
                    style: MyTextStyle.mediumBlackText,
                  ),
                ),

                //PAY BUTTON
                _googlePayButton(context)
              ],
            ),
          ),
        ));
  }

  //Button for payment
  Widget _googlePayButton(BuildContext context) {
    return Center(
        child: PhysicalModel(
          color: Colors.black,
          borderRadius: BorderRadius.circular(30),
          elevation: 5,
          child: GooglePayButton(
                paymentConfigurationAsset: 'payments/gpay.json',
                paymentItems: const [
          PaymentItem(
              label: 'Connected Premium',
              amount: '699',
              status: PaymentItemStatus.final_price)
                ],
                type: GooglePayButtonType.pay,
                onPaymentResult: (result) async{
          log('$result');
          if(result.isNotEmpty){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>const PaymentSuccessScreen()));
            await UserDbFunctions().subscribeToPremium();
          }
                },
                loadingIndicator: const Center(
          child: CircularProgressIndicator(),
                ),
              ),
        ));
  }

  //display carousel
  Widget _carousel(BuildContext context) {
    return FlutterCarousel(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 2),
        enableInfiniteScroll: true,
        autoPlay: true,
        aspectRatio: 1,
        height: MediaQueryCustom.carouselHeight(context),
        showIndicator: true,
        slideIndicator: const CircularSlideIndicator(
            currentIndicatorColor: Colors.grey,
            indicatorBackgroundColor: Color.fromARGB(255, 210, 209, 209)),
      ),
      items: ImageList.carouselImages.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255)),
                child: Image.asset(i));
          },
        );
      }).toList(),
    );
  }
}
