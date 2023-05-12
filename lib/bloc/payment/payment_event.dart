part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent {}

class OnSelectCard extends PaymentEvent{
  final CredCard cardSelected;

  OnSelectCard(this.cardSelected);
}


class OnDisableCard extends PaymentEvent{
  
}