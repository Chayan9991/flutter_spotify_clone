import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'internet_conn_state.dart';

class InternetConnCubit extends Cubit<InternetConnState> {
  InternetConnCubit() : super(InternetConnInitial());
}
