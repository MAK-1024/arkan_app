
import '../network/error_msg_model.dart';

class ServerExerption implements Exception
{
  final ErrorMsgModel errorMsgModel;

 const ServerExerption({required this.errorMsgModel});
}