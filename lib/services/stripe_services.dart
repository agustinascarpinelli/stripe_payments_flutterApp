import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_pay/models/stripe_intent_response.dart';
import 'package:stripe_pay/models/stripe_response_model.dart';

class StripeService {
//Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() {
    return _instance;
  }
  String _urlPaymentMethods = 'https://api.stripe.com/v1/payment_methods';
  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  String _apiKey =
      'pk_test_51N6b34KMZoHhFbnjTNrs3UxpF38Ehq9KQG91gWAd2Rknk6Ej0xSjUD8qa3X7vOM4zoHL2VyRUE5NA0s7UiecB4cc002vfo9Z2B';
  String _secretKey =
      'sk_test_51N6b34KMZoHhFbnjP6te0GgFsfj7JUvHgBA3A0JECAmwM3H3uV7Q1icnYE8W4t2WEnaIsCGjffXp8ki7i2BK7fYO00cl1IphCt';

  void init() {
    Stripe.publishableKey = _apiKey;
  }

  Future payWithExistentCard({
    required String amount,
    required String currency,
    required Card card,
  }) async {}

  Future<StripeResponse> addNewCard(String amount, String currency,
      String cardNumber, int expMonth, int expYear, String cvc) async {
    final apiKey = _apiKey; // Reemplaza con tu propia API key de Stripe
    final url = _paymentApiUrl;
    final dio = Dio();
    final headerOption =
        Options(contentType: Headers.formUrlEncodedContentType, headers: {
      'Authorization': 'Bearer $_apiKey',
    });

    try {
      final response =await dio.post(
        _urlPaymentMethods,
        options: headerOption,
        data: {
          'type': 'card',
          'card[number]': cardNumber,
          'card[exp_month]': expMonth.toString(),
          'card[exp_year]': expYear.toString(),
          'card[cvc]': cvc,
        },
      );

     if(response.statusCode ==200){
      
final paymentMethodId = response.data['id'];
      
      final resp=await _createPaymen(amount, currency,paymentMethodId);
      return resp;
   
     }else{
      return StripeResponse(ok: false,msg:'Error creating payment method: ${response.statusCode}');
     }


     
    
    } catch (e) {
      final error = e.toString();
      return StripeResponse(ok: false, msg: error);
    }
  }

  Future payWithApplePayOrGooglePay(
      {required amount, required currency}) async {}

  Future<StripeIntentResponse> _createPaymentIntent({
    required amount,
    required currency,
  }) async {
    try {
      final dio = Dio();
      final headerOption =
          Options(contentType: Headers.formUrlEncodedContentType, headers: {
        'Authorization': 'Bearer $_secretKey',
      });
      final data = {'amount': amount, 'currency': currency};

      final resp =
          await dio.post(_paymentApiUrl, data: data, options: headerOption);
           final jsonStr = jsonEncode(resp.data);

     final res= StripeIntentResponse.fromJson(jsonStr);
   print(res.id);
     return res;

    } catch (e) {
      print(e.toString());
      return StripeIntentResponse(status: '404');
    }
  }

  Future<StripeResponse> _createPayment(String amount, String currency,PaymentMethod paymentMethod) async {
    try {
      final resp =
          await _createPaymentIntent(amount: amount, currency: currency);

          final paymentConfirmation=await Stripe.instance.confirmPayment(paymentIntentClientSecret: resp.clientSecret!);
          if(paymentConfirmation.status=='succeeded'){
            return StripeResponse(ok: true);
          }else{
            return StripeResponse(ok: false,msg: 'Failed: ${paymentConfirmation.status}');
          }
      
    } catch (e) {
      return StripeResponse(ok: false, msg: e.toString());
    }
  }



  Future <StripeResponse> _createPaymen(String amount, String currency,String paymentMethod)async{
  try{
      final apiKey = _apiKey; // Reemplaza con tu propia API key de Stripe
    final url = _paymentApiUrl;
    final dio = Dio();
    final headerOption =
        Options(contentType: Headers.formUrlEncodedContentType, headers: {
      'Authorization': 'Bearer $_secretKey',
    });
    final resp =
          await _createPaymentIntent(amount: amount, currency: currency);
 final paymentIntentId=resp.id;

 final data={'payment_method':paymentMethod};
final confirmResponse = await dio.post(
      'https://api.stripe.com/v1/payment_intents/$paymentIntentId/confirm',
      options: headerOption,
      data: data
    );
    

      return StripeResponse(ok: true);
    

  }catch(e){
   if (e is DioError) {
    final errorResponse = e.response;
    if (errorResponse != null) {
      final errorData = errorResponse.data['error'];
      final errorMessage = errorData['message'];
      print(errorMessage);
     return StripeResponse(ok: false,msg:errorMessage);
    } 

      

  }
  return StripeResponse(ok: false,msg:e.toString());
    
}
}}

