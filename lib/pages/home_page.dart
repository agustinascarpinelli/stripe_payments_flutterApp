import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_pay/bloc/payment/payment_bloc.dart';
import 'package:stripe_pay/data/card_data.dart';
import 'package:stripe_pay/helpers/helpers.dart';
import 'package:stripe_pay/pages/card_page.dart';
import 'package:stripe_pay/services/stripe_services.dart';
import 'package:stripe_pay/widgets/total_pay_button.dart';
import 'package:stripe_pay/helpers/helpers.dart';
class HomeScreen extends StatelessWidget {
  final stripeService = StripeService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final blocPayment = BlocProvider.of<PaymentBloc>(context);
    bool isPortraitOrientation() {
      final orientation =
          MediaQueryData.fromWindow(WidgetsBinding.instance.window).orientation;
      return orientation == Orientation.portrait;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pay'),
          centerTitle: true,
          actions: [
            IconButton(
             splashColor: Colors.transparent,
                onPressed: ()async {
                final stripeService=StripeService();
                final payBloc=BlocProvider.of<PaymentBloc>(context).state;
                await stripeService.payWithNewCard(payBloc.amountToPay, payBloc.currency);

                },

               
                icon: const Icon(Icons.add))
                
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              width: size.width,
              height: size.height,
              top: isPortraitOrientation() ? 200 : 0,
              child: PageView.builder(
                  controller: PageController(viewportFraction: 0.9),
                  physics: const BouncingScrollPhysics(),
                  itemCount: cards.length,
                  itemBuilder: (_, i) {
                    final card = cards[i];
                    return GestureDetector(
                      onTap: () {
                        final paymentBloc =
                            BlocProvider.of<PaymentBloc>(context);
                        paymentBloc.add(OnSelectCard(card));
                        Navigator.push(context,
                            navigationFadeIn(context, const CardScreen()));
                      },
                      child: Hero(
                        tag: card.cardNumber,
                        child: CreditCardWidget(
                          cardBgColor: Colors.black,
                          cardNumber: card.cardNumberHidden,
                          expiryDate: card.expiracyDate,
                          cardHolderName: card.cardHolderName,
                          cvvCode: card.cvv,
                          showBackView: false,
                          onCreditCardWidgetChange: (CreditCardBrand) {},
                        ),
                      ),
                    );
                  }),
            ),
            const Positioned(bottom: 0, child: TotalPayButton())
          ],
        ));
  }
}
