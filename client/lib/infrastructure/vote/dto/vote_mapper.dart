import 'package:client/domain/vote/vote.dart';
import 'package:client/infrastructure/vote/dto/vote_dto.dart';

extension VoteMapper on Vote {
  VoteDto toVoteDto() {
    return VoteDto(id: id, choice: choice);
  }
}

extension VoteDtoMapper on VoteDto {
  Vote toVote() {
    return Vote(id: id, choice: choice);
  }
}
