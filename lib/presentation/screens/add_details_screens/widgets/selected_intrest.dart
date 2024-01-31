import 'package:connected/application/bloc/add_details_bloc/add_details_bloc.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_event.dart';
import 'package:connected/application/bloc/add_details_bloc/add_details_state.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectedInterestWidget extends StatelessWidget {
  const SelectedInterestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddDetailsBloc, AddDetailsState>(
                  builder: (context, state) {
                if (state is InterestUpdatedState) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: SizedBox(
                      height: MediaQueryCustom.interestSectionHeight(context),
                      width: double.infinity,
                      child: GridView.count(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        childAspectRatio: 2,
                        children:
                            List.generate(state.interests.length, (index) {
                          return Chip(
                            label: Text(
                              state.interests[index],
                              style: MyTextStyle.smallText,
                            ),
                            deleteIcon: const FaIcon(
                              FontAwesomeIcons.xmark,
                              size: 15,
                            ),
                            deleteIconColor: Colors.black,
                            onDeleted: () {
                              BlocProvider.of<AddDetailsBloc>(context).add(
                                  RemoveInterestEvent(
                                      intrest: state.interests[index]));
                            },
                          );
                        }),
                      ),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Container(),
                  );
                }
              });
  }
}