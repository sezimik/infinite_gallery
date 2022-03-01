import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../widgets/widgets.dart';
import '../bloc/bloc.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  @override
  void dispose() {
    super.dispose();
    Hive.close();
  }

  @override
  void initState() {
    super.initState();
    context.read<PhotoBloc>().add(const PhotoEventRequest());
    context.read<LikeCubit>().loadLikes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: BlocConsumer<PhotoBloc, PhotoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return state.requestStatus == PhotoRequestStatus.initialized
              ? const LoaderWidget()
              : state.requestStatus == PhotoRequestStatus.success
                  ? PhotoListView(
                      models: state.photoList,
                    )
                  : ErrorDisplayWidget(errorMessage: state.errorMessage);
        },
      ),
    );
  }
}
