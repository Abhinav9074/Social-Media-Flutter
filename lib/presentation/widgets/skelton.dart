import 'package:connected/application/bloc/like_bloc.dart/like_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return BlocProvider(
            create: (context) => LikeBloc(),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(width: 0.02)),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                  )
                ],
              ),
            ),
          );
        });
  }
}