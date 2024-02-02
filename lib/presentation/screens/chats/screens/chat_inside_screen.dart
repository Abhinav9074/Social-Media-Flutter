import 'package:bubble/bubble.dart';
import 'package:connected/domain/common/firestore_constants/firebase_constants.dart';
import 'package:connected/domain/fire_store_functions/chat_service/chat_services.dart';
import 'package:connected/domain/fire_store_functions/user_db/user_db_functions.dart';
import 'package:connected/presentation/widgets/textField.dart';
import 'package:flutter/material.dart';

class ChatInsideScreen extends StatelessWidget {
  final String receiverId;

  const ChatInsideScreen({super.key, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    TextEditingController textCont = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          StreamBuilder(
              stream: ChatServices().getChatMessages(receiverId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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
                                ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 300),
                                  child: Bubble(
                                    color: color,
                                    margin: const BubbleEdges.fromLTRB(
                                        10, 10, 10, 10),
                                    nip: nipAlignment,
                                    child: Text(data[
                                        FirebaseConstants.fieldchatMessage]),
                                  ),
                                ),
                              ],
                            );
                          }));
                }
              }),
          CustomTextField(
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
}
