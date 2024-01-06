import 'package:flutter_bloc/flutter_bloc.dart';

class ProductTypeCubit extends Cubit<int> {
  ProductTypeCubit() : super(0);
//! usage : changing the page controller of buttom navigation and change the UI screens 
  changeState(newState)=>emit(newState); 

}