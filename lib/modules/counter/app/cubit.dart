
import 'package:flutter_bloc/flutter_bloc.dart';
import 'state.dart';



class CounterCubit extends Cubit<CounterState>
{
  CounterCubit(): super(CounterIntialState());

  static  CounterCubit get(context) => BlocProvider.of(context);
  int counter = 1;
  void minus()
  {
    counter--;
    emit(CounterMinusState(counter));
  }
  void plus()
  {
    counter++;
    emit(CounterPlusState(counter));
  }
}