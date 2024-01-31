import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String image;
  

  const ProfilePicture({super.key,required this.image});
  

  @override
  Widget build(BuildContext context) {
    return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              image),
                          radius: MediaQueryCustom.profilePicSize(context),
                        ),
                      ),
                    ],
                  );
  }
}