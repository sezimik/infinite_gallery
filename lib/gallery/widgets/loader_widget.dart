import 'package:flutter/material.dart';
import '../../config/config.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisSize: MainAxisSize.min,
        children: const [

         Text(kLoadingTitle, style: InfiniteTextStyles.title,),
         SizedBox(height: 10,),
          LinearProgressIndicator( color: InfiniteColors.blue,)

      ],)
      
    );
  }
}