import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String code;
  final String message;
  final String plugin;

  const CustomError({this.code = '', this.message = '', this.plugin = ''});

  @override
  List<Object> get props {
    return [code, message, plugin];
  }

  @override
  String toString() {
    return  'CustomError(code: $code,message: $message,plugin: $plugin)';
  }
}