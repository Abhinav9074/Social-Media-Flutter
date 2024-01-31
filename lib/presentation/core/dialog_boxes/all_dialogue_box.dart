// ignore_for_file: use_build_context_synchronously

import 'package:connected/presentation/core/themes/theme.dart';
import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final dynamic function;
  final dynamic id1;
  final dynamic id2;

  const WarningDialog({super.key,required this.function, this.id1, this.id2});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        height: 300.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'You are about to delete a discussion',
                style: MyTextStyle.mediumHeadingText,
                textAlign: TextAlign.center,
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset('assets/icons/warning.gif',height: 100,width: 100,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(onPressed: (){Navigator.of(context).pop();}, icon: const Icon(Icons.close,color: Colors.red,), label: const Text('No',style: MyTextStyle.commonButtonTextRed,)),
                  TextButton.icon(
                    onPressed: ()async{
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      await function.removeDiscussion(id1);
                    }, 
                    icon: const Icon(Icons.check,color: Colors.green,), label: const Text('Yes',style: MyTextStyle.commonButtonTextGreen,)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
