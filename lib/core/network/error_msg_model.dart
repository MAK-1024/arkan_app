
import 'package:equatable/equatable.dart';

class ErrorMsgModel extends Equatable
{
  final int statusCode;
  final String statusMsg;
  final bool success;

  const ErrorMsgModel({
    required this.statusCode,
    required this.statusMsg,
    required this.success
  });

 factory ErrorMsgModel.fromJson(Map<String , dynamic> json){
   return ErrorMsgModel(
       statusCode: json['status_code'],
       statusMsg: json['status_message'],
       success: json['success']
   );
 }

  @override
  List<Object?> get props =>[statusCode , statusMsg , success];



}