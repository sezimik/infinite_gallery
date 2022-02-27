import 'package:equatable/equatable.dart';

abstract class PhotoEvent extends Equatable {
  const PhotoEvent();
}

/// called on http requests
class PhotoEventRequest extends PhotoEvent {
  const PhotoEventRequest();
  @override
  List<Object?> get props => [];
}
