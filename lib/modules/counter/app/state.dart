abstract class CounterState{}
class CounterIntialState extends CounterState {}
class CounterPlusState extends CounterState
{
  final int counter;
  CounterPlusState(this.counter);
}
class CounterMinusState extends CounterState
{
  final int counter;

  CounterMinusState(this.counter);
}