part of 'payment_bloc.dart';

@immutable
class PaymentState {
  final double amount;
  final String currency;
  final bool activeCard;
  final CredCard? cardSelected;

  String get amountToPay=>'${(amount *100).floor()}';

  PaymentState(
      {this.amount = 100,
      this.currency = 'USD',
      this.activeCard = false,
      this.cardSelected});

  PaymentState copyWith({
    double? amount,
    String? currency,
    bool? activeCard,
    CredCard? cardSelected,
  }) =>
      PaymentState(
          amount: amount ?? this.amount,
          currency: currency ?? this.currency,
          activeCard: activeCard ?? this.activeCard,
          cardSelected: cardSelected ?? this.cardSelected);
}
