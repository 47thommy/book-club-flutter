import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// part 'poll_dto.freezed.dart';
// part 'poll_dto.g.dart';

class PollDto extends Equatable {
  final int id;
  final String question;
  final List<String> options;

  const PollDto({
    required this.id,
    required this.question,
    required this.options,
  });

  factory PollDto.fromJson(Map<String, dynamic> json) {
    return PollDto(
        id: json['id'], 
        question: json['question'], 
        options: json['options']);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'options': options
    };
  }

  @override
  List<Object?> get props => [id, question, options];
}

// @freezed
// class PollDto with _$PollDto {
//   const PollDto._();

//   const factory PollDto(
//       {required int id,
//       required String question,
//       required List<String> options}) = _PollDto;

//   factory PollDto.fromJson(Map<String, dynamic> json) =>
//       _$PollDtoFromJson(json);
// }
