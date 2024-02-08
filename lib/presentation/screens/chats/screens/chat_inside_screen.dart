import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/chat_service/chat_services.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/core/themes/theme.dart';
import 'package:connected/presentation/screens/profile/screens/self_discussion_view.dart';
import 'package:connected/presentation/widgets/textField.dart';
import 'package:flutter/material.dart';

class ChatInsideScreen extends StatelessWidget {
  final String receiverId;

  const ChatInsideScreen({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    TextEditingController textCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection(FirebaseConstants.userDb)
                .doc(receiverId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox();
              } else {
                return Row(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data![FirebaseConstants.fieldImage]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      snapshot.data![FirebaseConstants.fieldRealname],
                      style: MyTextStyle.commonButtonText,
                    ),
                  )
                ]);
              }
            }),
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream: ChatServices().getChatMessages(receiverId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return Expanded(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];
                            final alignment =
                                data[FirebaseConstants.fieldchatSenderId] ==
                                        UserDbFunctions().userId
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start;
                            final nipAlignment =
                                data[FirebaseConstants.fieldchatSenderId] ==
                                        UserDbFunctions().userId
                                    ? BubbleNip.rightTop
                                    : BubbleNip.leftTop;
                            final color =
                                data[FirebaseConstants.fieldchatSenderId] ==
                                        UserDbFunctions().userId
                                    ? const Color.fromARGB(255, 195, 235, 165)
                                    : const Color.fromARGB(255, 232, 230, 230);
                            return Row(
                              mainAxisAlignment: alignment,
                              children: [
                                data[FirebaseConstants.fieldChatIsDiscussion] ==
                                        true
                                    ? _sharedDiscussionBubble(
                                        color: color,
                                        nipAlignment: nipAlignment,
                                        data: data,
                                        context: context)
                                    : data[FirebaseConstants
                                                .fieldChatIsAlert] ==
                                            true
                                        ? _dateShow(
                                            data: data, context: context)
                                        : _textMsgBubble(
                                            color: color,
                                            nipAlignment: nipAlignment,
                                            data: data),
                              ],
                            );
                          }));
                }
              }),
          CustomTextField(
            readOnly: false,
            hint: 'Message',
            textCont: textCont,
            suffixIcon: const Icon(Icons.send),
            prefixIcon: const Icon(Icons.attachment),
            suffixOnPressed: () async {
              if (textCont.text.isEmpty) {
                return;
              }
              String temp = textCont.text;
              textCont.clear();
              await ChatServices().sendChatMessage(receiverId, temp);
            },
            prefixOnPressed: () {},
          )
        ],
      ),
    );
  }

  //textmessage bubble
  Widget _textMsgBubble(
      {required Color color,
      required BubbleNip nipAlignment,
      required final data}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Bubble(
        color: color,
        margin: const BubbleEdges.fromLTRB(10, 10, 10, 10),
        nip: nipAlignment,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data[FirebaseConstants.fieldchatMessage],
              style: MyTextStyle.descriptionText,
            ),
            Text(
              data[FirebaseConstants.fieldchatTime],
              style: MyTextStyle.greyHeadingTextSmall,
            ),
          ],
        ),
      ),
    );
  }

  //alert message container
  Widget _dateShow({required final data, required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: Colors.amber),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
              child: Text(
                data[FirebaseConstants.fieldChatlertMsg],
                style: MyTextStyle.greyHeadingTextSmall,
              ),
            ),
          )
        ],
      ),
    );
  }

  //discussion share bubble
  Widget _sharedDiscussionBubble(
      {required Color color,
      required BubbleNip nipAlignment,
      required final data,
      required BuildContext context}) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Bubble(
        color: color,
        margin: const BubbleEdges.fromLTRB(10, 10, 10, 10),
        nip: nipAlignment,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shared a discussion',
              style: MyTextStyle.greyHeadingTextSmall,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SelfDiscussionView(
                          discussionId:
                              data[FirebaseConstants.fieldChatDiscussionId])));
                },
                child: Text(
                  data[FirebaseConstants.fieldChatDiscussionName],
                  style: MyTextStyle.linkTextMedium,
                )),
            Text(
              data[FirebaseConstants.fieldchatTime],
              style: MyTextStyle.greyHeadingTextSmall,
            ),
          ],
        ),
      ),
    );
  }
}
