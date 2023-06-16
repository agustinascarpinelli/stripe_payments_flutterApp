import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_pay/bloc/payment/payment_bloc.dart';
import 'package:stripe_pay/services/stripe_services.dart';

import '../helpers/helpers.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({super.key});

  @override
  Widget build(BuildContext context) {
    final payBloc = BlocProvider.of<PaymentBloc>(context).state;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100,
      decoration: const BoxDecoration(
          color: Color(0xff54535a),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      'Total :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text('${payBloc.amountToPay} ${payBloc.currency}',
                        style: const TextStyle(fontSize: 20))
                  ],
                ),
              ],
            ),
            BlocBuilder<PaymentBloc, PaymentState>(builder: ((context, state) {
              return _Button(state: state);
            })),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final PaymentState state;

  const _Button({super.key, required this.state});
  @override
  Widget build(BuildContext context) {
    return state.activeCard
        ? buildButtonCard(context)
        : buildAppleAndGooglePay(context);
  }

  Widget buildButtonCard(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        showLoading(context);
        final payBloc = BlocProvider.of<PaymentBloc>(context).state;
        final stripeService = StripeService();
        int expMonth =
            int.parse(payBloc.cardSelected!.expiracyDate.substring(0, 2));
        int expYear = int.parse(payBloc.cardSelected!.expiracyDate
            .substring(payBloc.cardSelected!.expiracyDate.length - 2));
        final res = await stripeService.payWithExistCard(
            payBloc.amountToPay,
            payBloc.currency,
            payBloc.cardSelected!.cardNumber,
            expMonth,
            expYear,
            payBloc.cardSelected!.cvv);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        if (res.ok) {
          showCustomAlert(context, 'Successfull payment', '');
        } else {
          print(res.msg);
          showCustomAlert(context, 'Something went wrong', res.msg!);
        }
      },
      height: 45,
      minWidth: 100,
      shape: const StadiumBorder(),
      elevation: 0,
      color: const Color(0xff191A20),
      child: const Row(children: [
        Icon(
          FontAwesomeIcons.solidCreditCard,
          color: Colors.white,
        ),
        Text(
          '  Pay',
          style: TextStyle(color: Colors.white, fontSize: 22),
        )
      ]),
    );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      onPressed: () async {
        final stripeService = StripeService();
        final payBloc = BlocProvider.of<PaymentBloc>(context).state;
        final res = await stripeService.payWithApplePayOrGooglePay(
            amount: payBloc.amountToPay, currency: payBloc.currency);
        if (res.ok) {
          return;
        } else {
          showCustomAlert(context, 'Something went wrong', res.msg!);
        }
      },
      height: 45,
      minWidth: 100,
      shape: const StadiumBorder(),
      elevation: 0,
      color: const Color(0xff191A20),
      child: Row(children: [
        Icon(
          Platform.isAndroid ? FontAwesomeIcons.google : FontAwesomeIcons.apple,
          color: Colors.white,
        ),
        const Text(
          ' Pay',
          style: TextStyle(color: Colors.white, fontSize: 22),
        )
      ]),
    );
  }
}
