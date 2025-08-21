import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('en'));

  void changeLanguage(Locale locale) => emit(locale);
}
