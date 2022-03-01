import 'package:flutter/material.dart';
import '../models/models.dart';
import '../bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/config.dart';
import '../widgets/widgets.dart';

class PhotoListView extends StatefulWidget {
  final List<PhotoModel> models;
  const PhotoListView({required this.models, Key? key}) : super(key: key);

  @override
  State<PhotoListView> createState() => _PhotoListViewState();
}

class _PhotoListViewState extends State<PhotoListView> {
  @override
  Widget build(BuildContext context) {
    imageCacher();
    return BlocBuilder<LikeCubit, List<int>>(builder: (context, likes) {
      
      return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: BlocProvider.of<PhotoBloc>(context).state.completed
              ? widget.models.length + 1
              : widget.models.length,
          itemBuilder: (scontext, index) {
            if (index == widget.models.length - 2) {
              BlocProvider.of<PhotoBloc>(context)
                  .add(const PhotoEventRequest());
            }

            // shows an alert tile when the users reaches th end of the list(5000 photos!)
            return index < widget.models.length
                ? customTile(widget.models[index],
                    likes.contains(widget.models[index].id))
                : SizedBox(
                    height: 150,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 24,
                            color: InfiniteColors.pink,
                          ),
                          SizedBox(width: Insets.small),
                          Text(
                            kListWarning,
                            style: InfiniteTextStyles.error,
                          )
                        ]));
          });
    });
  }

  Widget customTile(PhotoModel model, bool isLiked) {
    const double _height = 120;
    const double _radius = 10;

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_radius),
          color: InfiniteColors.white,
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 6),
                color: InfiniteColors.black10,
                blurRadius: 8)
          ]),
      margin: const EdgeInsets.all(Insets.small),
      height: _height,
      child: Row(
        children: [
          /// show fullscreen on thumbnail tap
          GestureDetector(
            onTap: () => ImagePreview().showFullsScreen(context, model.url),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(_radius),
                    topLeft: Radius.circular(_radius),
                  ),
                  image:
                      DecorationImage(image: NetworkImage(model.thumbnailUrl))),
              width: _height,
              height: _height,
            ),
          ),

          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(Insets.xsmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    model.title,
                    style: InfiniteTextStyles.title,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    //preview button
                    OutlinedButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(_radius)),
                          primary: InfiniteColors.blue,
                        ),
                        onPressed: () =>
                            ImagePreview().showFullsScreen(context, model.url),
                        child: const Icon(
                          Icons.fullscreen,
                          size: 18,
                        )),
                    const SizedBox(
                      width: Insets.medium,
                    ),

                    // like button
                    OutlinedButton(
                      style: TextButton.styleFrom(
                        splashFactory: NoSplash.splashFactory,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_radius)),
                        primary:
                            isLiked ? InfiniteColors.pink : InfiniteColors.grey,
                        textStyle: isLiked
                            ? InfiniteTextStyles.inactiveButton
                            : InfiniteTextStyles.inactiveButton,
                      ),
                      child: isLiked
                          ? Row(children: const [
                              Icon(
                                Icons.favorite,
                                size: 18,
                              ),
                              SizedBox(
                                width: Insets.xsmall,
                              ),
                              Text(kUnlikeTItle)
                            ])
                          : Row(children: const [
                              Icon(
                                Icons.favorite_outline,
                                size: 18,
                              ),
                              SizedBox(
                                width: Insets.xsmall,
                              ),
                              Text(kLikeTitle)
                            ]),
                      onPressed: () {
                        isLiked
                            ? context.read<LikeCubit>().unLike(model)
                            : context.read<LikeCubit>().like(model);
                      },
                    ),
                    const SizedBox(width: Insets.xsmall)
                  ],
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }

// prefetching thumbnail images for bttr scroll experience.
  void imageCacher() {
    if (widget.models.isNotEmpty) {
      int queryLimit =
          widget.models.length.toInt() > 25 ? 25 : widget.models.length.toInt();
      var newItems = widget.models
          .getRange(widget.models.length - queryLimit, widget.models.length)
          .toList();
      var urls = newItems.map((e) => e.thumbnailUrl).toList();

      for (var i = 0; i < urls.length; i++) {
        // try {
        precacheImage(NetworkImage(urls[i]), context)
            .then((_) {})
            .whenComplete(() {})
            .catchError((error) {});
      }
    }
  }
}
