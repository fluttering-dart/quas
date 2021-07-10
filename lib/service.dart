import 'dart:async';
import 'package:grpc/src/server/call.dart';
import 'package:quap/generated/qua.pbgrpc.dart';

import 'db.dart';

class QuaService extends QuaServiceBase {
  @override
  Stream<QuaMessage> quaInterview(
      ServiceCall call, Stream<QuaMessage> candidateStream) async* {
    //
    var questionsCount = 0;

    await for (var candidateMessage in candidateStream) {
      print('Received message from the candidate ${candidateMessage.from}:'
          '\n${candidateMessage.body}');
      if (questionsCount < questions.length) {
        yield _createMessage(
            from: 'Qua Interviewer', text: questions[questionsCount++]);
      } else {
        yield _createMessage(
            from: 'Qua HR', text: 'Thank you for the answers. Bye!');
        return;
      }
    }
  }
}

QuaMessage _createMessage({String from = '', String text = ''}) => QuaMessage()
  ..from = from
  ..body = text;
