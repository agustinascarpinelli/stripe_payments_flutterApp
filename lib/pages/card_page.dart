import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import '../bloc/payment/payment_bloc.dart';
import '../models/credit_card_model.dart';
import '../widgets/total_pay_button.dart';

class CardScreen extends StatelessWidget {
   
  const CardScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final card=BlocProvider.of<PaymentBloc>(context).state.cardSelected;
 
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Pay'),
        leading: IconButton(onPressed:(){
            final paymentBloc=BlocProvider.of<PaymentBloc>(context);
                  paymentBloc.add(OnDisableCard());
          Navigator.pop(context);
        },
        splashColor: Colors.transparent,
         icon: const Icon(Icons.arrow_back_ios)),
      ),
      body:Stack(
        children: [
          Container(),
          Hero(
            tag:card!.cardNumber,
            child: CreditCardWidget(
              cardBgColor: Colors.black,
              cardNumber:card.cardNumberHidden,
               expiryDate: card.expiracyDate,
                cardHolderName: card.cardHolderName,
                 cvvCode: card.cvv,
                  showBackView: false,
                   onCreditCardWidgetChange:(CreditCardBrand ) {  }),
          ),


      Positioned(
          bottom: 0,
          child:TotalPayButton()
          )
      ],)
    );
  }
}