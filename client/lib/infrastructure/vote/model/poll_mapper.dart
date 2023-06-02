import 'package:client/domain/poll/poll.dart';
import 'package:client/infrastructure/poll/poll.dart';

extension PollMapper on Poll {
  PollDto toPollDto() {
    return PollDto(id: id, question: question, options: options);
  }
}

extension PollDtoMapper on PollDto {
  Poll toPoll() {
    return Poll(id: id, question: question, options: options);
  }
}
