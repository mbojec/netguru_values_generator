import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes_generator/blocs/editor/state.dart';
import 'package:quotes_generator/models/quote.dart';
import 'package:quotes_generator/storage/database_helper.dart';

class EditorCubit extends Cubit<EditorState>{
  EditorCubit():super(const EditorInitial());

  Future<void> saveNewQuote(String value) async {
    emit(const EditorSaving());
    try{
      await DatabaseHelper().insert(Quote(content: value));
      Future<void>.delayed(const Duration(seconds: 2),(){
        emit(const EditorSuccess());
      });
    } catch(e){
      Future<void>.delayed(const Duration(seconds: 2),(){
        emit(const EditorError("There's been an error during fetching values list"));
      });
    }
  }

  void setErrorMessage (String errorMessage){
    emit(EditorError(errorMessage));
  }

  void clearState (){
    emit(const EditorInitial());
  }
}

