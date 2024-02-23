// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/application/bloc/location_bloc/location_bloc.dart';
import 'package:connected/application/bloc/location_bloc/location_event.dart';
import 'package:connected/application/bloc/location_bloc/location_state.dart';
import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_bloc.dart';
import 'package:connected/application/bloc/profile_edit_bloc/profile_edit_state.dart';
import 'package:connected/application/bloc/profile_switch_bloc/profile_switch_bloc.dart';
import 'package:connected/application/bloc/profile_switch_bloc/profile_switch_event.dart';
import 'package:connected/application/bloc/profile_switch_bloc/profile_switch_state.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/domain/models/user_model/user_update_model.dart';
import 'package:connected/domain/streams/interest_stream.dart';
import 'package:connected/presentation/core/media_query/media_query.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile_edit/widgets/old_profile.dart';
import 'package:connected/presentation/widgets/button.dart';
import 'package:connected/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recase/recase.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  TextEditingController usernameCont = TextEditingController();
  TextEditingController bioCont = TextEditingController();
  TextEditingController locationCont = TextEditingController();
  bool isPicEdited = false;
  String newProfilePic = '';
  bool locationView=false;
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (context) => ProfileEditBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: MyTextStyle.googleButton,
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(FirebaseConstants.userDb)
                .doc(UserDbFunctions().userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                //assigning the old data to the fields
                locationView =
                    snapshot.data![FirebaseConstants.fieldAllowLocationView];
                usernameCont.text =
                    '${snapshot.data![FirebaseConstants.fieldRealname]}'
                        .titleCase;
                bioCont.text =
                    '${snapshot.data![FirebaseConstants.fieldUserBio]}';
                locationCont.text =
                    '${snapshot.data![FirebaseConstants.fieldAddress]}'
                        .titleCase;

                return SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //profile picture editing
                        BlocBuilder<ProfileEditBloc, ProfileEditState>(
                          builder: (context, state) {
                            if (state is NewProfilePictureState) {
                              isPicEdited = true;
                              newProfilePic = state.image;
                              return OldProfilePicture(
                                image: state.image,
                                network: false,
                              );
                            } else {
                              newProfilePic = snapshot.data![FirebaseConstants.fieldImage];
                              return OldProfilePicture(
                                image:
                                    snapshot.data![FirebaseConstants.fieldImage],
                                network: true,
                              );
                            }
                          },
                        ),
                  
                        //username editing
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: CustomTextField(
                              readOnly: false,
                              hint: 'Realname',
                              textCont: usernameCont,
                              suffixOnPressed: () {},
                              prefixOnPressed: () {},
                              suffixIcon: const Icon(Icons.abc),
                              prefixIcon:
                                  const Icon(Icons.supervised_user_circle)),
                        ),
                  
                        //Bio editing
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: CustomTextField(
                              readOnly: false,
                              hint: 'Bio',
                              textCont: bioCont,
                              suffixOnPressed: () {},
                              prefixOnPressed: () {},
                              suffixIcon: const Icon(Icons.abc),
                              prefixIcon: const Icon(Icons.description)),
                        ),
                  
                        //location fetching
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, state) {
                            if (state is LocationFetchedState) {
                              locationCont.text = [
                                state.locationData.locality,
                                state.locationData.administrative,
                                state.locationData.country
                              ].join(' ');
                            }
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: CustomTextField(
                                  readOnly: true,
                                  hint: 'Click On The Location Icon',
                                  textCont: locationCont,
                                  suffixOnPressed: () {
                                    BlocProvider.of<LocationBloc>(context)
                                        .add(LocationButtonPressedEvent());
                                  },
                                  prefixOnPressed: () {},
                                  suffixIcon: state is LocationLoadingState
                                      ? const CircularProgressIndicator()
                                      : state is LocationFetchedState
                                          ? const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            )
                                          : const Icon(
                                              Icons.location_on,
                                              color: Colors.red,
                                            ),
                                  prefixIcon: const Icon(Icons.location_city)),
                            );
                          },
                        ),
                  
                        //allow others to view location data
                        BlocBuilder<ProfileSwitchBloc, ProfileSwitchState>(
                          builder: (context, state) {
                            if (state is ProfileSwitchToggledState) {
                              locationView = state.switchValue;
                            }
                            return _allowLoactionSwitch(
                                locationView: locationView, context: context);
                          },
                        ),
                  
                        //Add Interst Button
                        CommonButton(
                          text: 'Add Interest',
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return _interestSelector(
                                      context: context,
                                      interest: snapshot.data![
                                          FirebaseConstants.fieldInterest]);
                                });
                          },
                        ),
                  
                        //Interest display
                        _interestDisplay(
                            interests:
                                snapshot.data![FirebaseConstants.fieldInterest],
                            context: context)
                      ],
                    ),
                  ),
                );
              }
            }),

        //floating action button
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.red,
            label: const Text(
              'Update Deatils',
              style: MyTextStyle.commonButtonTextWhite,
            ),
            onPressed: ()async{
              final data = UserUpdateModel(image: newProfilePic, realName: usernameCont.text, locationView: locationView, address: locationCont.text, bio: bioCont.text);
              if(isPicEdited){
                await UserDbFunctions().updateUserData(data: data,image: newProfilePic);
              }else{
                await UserDbFunctions().updateUserData(data: data);
              }

              Navigator.of(context).pop();
            }),
      ),
    );
  }





  //LOCATION VIEW ON OFF SWITCH
  Widget _allowLoactionSwitch(
      {required bool locationView, required BuildContext context}) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: ListTile(
            title: const Text(
              'Allow Location View',
              style: MyTextStyle.optionTextMedium,
            ),
            subtitle: const Text(
              'Others can view your location in map view',
              style: MyTextStyle.smallText,
            ),
            trailing: Switch(
              value: locationView,
              onChanged: (value) {
                BlocProvider.of<ProfileSwitchBloc>(context)
                    .add(ProfileSwitchTapEvent(currentStatus: locationView));
              },
              activeColor: Colors.red,
            )));
  }

  //INTEREST DISPLAY WIDGET
  Widget _interestDisplay(
      {required List<dynamic> interests, required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: SizedBox(
        height: MediaQueryCustom.interestSectionHeight(context),
        width: double.infinity,
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 2,
          crossAxisSpacing: 1,
          crossAxisCount: 3,
          children: List.generate(interests.length, (index) {
            return Chip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: Text(
                interests[index],
                style: MyTextStyle.smallText,
              ),
              deleteIcon: const FaIcon(
                FontAwesomeIcons.xmark,
                size: 15,
              ),
              deleteIconColor: Colors.black,
              onDeleted: () async {
                await UserDbFunctions().removeInterest(interests[index]);
              },
            );
          }),
        ),
      ),
    );
  }

  //Interest selection bottom sheet
  Widget _interestSelector(
      {required BuildContext context, required List<dynamic> interest}) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirebaseConstants.interestsDb)
            .doc(FirebaseConstants.interestDbId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return StreamBuilder(
                stream: interestStream(
                    userInterest: interest,
                    deafultInterest:
                        snapshot.data![FirebaseConstants.fieldInterests]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  } else {
                    return Center(
                      child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 2,
                        children: List.generate(snapshot.data.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chip(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              label: Text(
                                snapshot.data[index],
                                style: MyTextStyle.smallText,
                              ),
                              deleteIcon: const FaIcon(
                                FontAwesomeIcons.plus,
                                size: 15,
                              ),
                              deleteIconColor: Colors.black,
                              onDeleted: () async {
                                //adding the interest
                                UserDbFunctions()
                                    .addInterest(snapshot.data[index]);
                              },
                            ),
                          );
                        }),
                      ),
                    );
                  }
                });
          }
        });
  }
}
