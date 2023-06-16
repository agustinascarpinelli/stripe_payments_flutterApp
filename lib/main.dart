import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_pay/bloc/payment/payment_bloc.dart';
import 'package:stripe_pay/pages/addCard.dart';
import 'package:stripe_pay/pages/card_page.dart';
import 'package:stripe_pay/pages/home_page.dart';
import 'package:stripe_pay/pages/pay_page.dart';
import 'package:stripe_pay/services/stripe_services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
 final stripeService=StripeService();
 stripeService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle textFont=GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w400);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => PaymentBloc())],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'home',
          routes: {
            'home': (_) => HomeScreen(),
            'card': (_) => const CardScreen(),
            'addCard': (_) => AddCard(),
            'pay': (_) => const PayScreen()
          },
          theme: ThemeData.light().copyWith(
             
              primaryColor: const Color(0xff54535a),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
              appBarTheme: AppBarTheme(color: const Color(0xff54535A),centerTitle:true,titleTextStyle: textFont.copyWith(fontSize: 20)),
              scaffoldBackgroundColor: const Color(0xff21232A))),
    );
  }
}
