import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stripe_pay/models/credit_card_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState()) {
 
 on<OnSelectCard>((event, emit) {
  emit(state.copyWith(activeCard: true,cardSelected: event.cardSelected));
 },);

 on<OnDisableCard>(((event, emit) {
  emit(state.copyWith(activeCard: false));
 }));


  }
}
