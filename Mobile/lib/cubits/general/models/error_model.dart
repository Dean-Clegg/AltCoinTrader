import 'package:equatable/equatable.dart';

enum ErrorType { info, warning, error, critical }

extension ErrorTypeExtension on ErrorType {
  int get number {
    switch (this) {
      case ErrorType.info:
        return 1;
      case ErrorType.warning:
        return 2;
      case ErrorType.error:
        return 3;
      case ErrorType.critical:
        return 4;
    }
  }
}

class ErrorModel extends Equatable {
  final String error;
  final String stackTrace;
  final ErrorType errorType;

  const ErrorModel({required this.error, required this.stackTrace, this.errorType = ErrorType.error});

  @override
  List<Object?> get props => [error, stackTrace, errorType];

  ErrorModel copyWith({String? error, String? stackTrace, ErrorType? errorType}) {
    return ErrorModel(error: error ?? this.error, stackTrace: stackTrace ?? this.stackTrace, errorType: errorType ?? this.errorType);
  }

  Map<String, dynamic> toMap() {
    return {'error': error, 'stackTrace': stackTrace, 'errorType': errorType.number};
  }
}
