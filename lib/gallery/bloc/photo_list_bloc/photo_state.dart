
import 'package:equatable/equatable.dart';
import '../../models/models.dart';


/* 
I first created multiple classes for state management(bottom of the file) then I
 realized that I need to keep track of the phhoto items, so I adapted this 
 method to keep track of all the proprties in a single instance. 
*/

// called based on http request status 
enum PhotoRequestStatus { initialized, success, error }

class PhotoState extends Equatable {
  final List<PhotoModel> photoList;
  final PhotoRequestStatus requestStatus;
  final String errorMessage;
  final bool completed;
  
  //initializing for Bloc:Super
  const PhotoState(
      {this.photoList = const <PhotoModel>[],
      this.requestStatus = PhotoRequestStatus.initialized,
      this.errorMessage = "",
      this.completed = false});

  PhotoState updateProp(
      {List<PhotoModel>? photoList,
      PhotoRequestStatus? requestStatus,
      String? errorMessage,
      bool? completed}) {
    return PhotoState(
        photoList: photoList ?? this.photoList,
        requestStatus: requestStatus ?? this.requestStatus,
        errorMessage: errorMessage ?? this.errorMessage ,
        completed: completed ?? this.completed);
  }

  @override
  List<Object?> get props => [photoList, requestStatus,errorMessage, completed];
}


/* 

Another method for updating bloc states:
abstract class PhotoState extends Equatable {
  const PhotoState();
}

//on initialization
class PhotoStateInitialized extends PhotoState {
  @override
  List<Object?> get props =>[];
  
}
//on success
class PhotoStateSucess extends PhotoState {
  final List<PhotoModel> photoModels;
 const  PhotoStateSucess({required this.photoModels});
  @override
  List<Object?> get props =>  [photoModels];
}
//on error
class PhotoStateError extends PhotoState {
  final String error;
 const  PhotoStateError({required this.error});
  @override
  List<Object?> get props =>[error];
}

//on loading
class PhotoStateLoading extends PhotoState {
  @override
  List<Object?> get props =>[];
}

*/
