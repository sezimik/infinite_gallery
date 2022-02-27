import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_gallery/gallery/bloc/photo_bloc/photo_event.dart';
import 'package:infinite_gallery/gallery/bloc/photo_bloc/photo_state.dart';
import '../../repositories/repositories.dart';



class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {

  final _repository = PhotoRepository();

  PhotoBloc() : super(const PhotoState()) {
    on<PhotoEventRequest>(_onRequst);
  }

  Future<void> _onRequst(
      PhotoEventRequest event, Emitter<PhotoState> stateEmitter) async {

    // bounces back when the list of photos is completed
    if (state.completed) return;

    try {

      // starr index: 0 on initialization and List.length on later requests
      final _newPhotoList =
          await _repository.fetchPhotos(startIndex: state.photoList.length);

      if (state.requestStatus == PhotoRequestStatus.initialized) {
        return stateEmitter(state.updateProp(
            photoList: _newPhotoList,
            requestStatus: PhotoRequestStatus.suscess,
            completed: false));
      } else {

        //Comment out the first block to visit the last tile of the listview
        ///updates the state and allows future get requests
        _newPhotoList.isNotEmpty
            ? stateEmitter(state.updateProp(
                photoList: [...state.photoList, ..._newPhotoList],
                requestStatus: PhotoRequestStatus.suscess,
                completed: false))
            :
            /// updates the state with no future requests 
             stateEmitter(state.updateProp(
                photoList: state.photoList,
                requestStatus: PhotoRequestStatus.suscess,
                completed: true));
      }
    } catch (error){
      stateEmitter(state.updateProp(
          errorMessage: "Somthing went wrong!\nplease check your internet connection.", requestStatus: PhotoRequestStatus.error));
    } 
  }
}
