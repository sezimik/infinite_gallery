import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_gallery/config/config.dart';
import '../photo_list_bloc/photo_event.dart';
import '../photo_list_bloc/photo_state.dart';
import '../../repositories/repositories.dart';



class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {

 PhotoRepository  _repository = PhotoRepository();

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
            requestStatus: PhotoRequestStatus.success,
            completed: false));
      } else {

        //Comment out the first block to visit the last tile of the listview
        ///updates the state and allows future get requests
        _newPhotoList.isNotEmpty
            ? stateEmitter(state.updateProp(
                photoList: [...state.photoList, ..._newPhotoList],
                requestStatus: PhotoRequestStatus.success,
                completed: false))
            :
            /// updates the state with no future requests 
             stateEmitter(state.updateProp(
                photoList: state.photoList,
                requestStatus: PhotoRequestStatus.success,
                completed: true));
      }
    } catch (error){
      stateEmitter(state.updateProp(
          errorMessage: kErrorMessage, requestStatus: PhotoRequestStatus.error));
    } 
  }

// used for injecting mockclients during tests
    void injectMockClient(http.Client client) {
    _repository = PhotoRepository(client: client);
  }
}
