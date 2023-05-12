import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PayScreen extends StatelessWidget {
   
  const PayScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Pay completed')
      ),
      body: Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(FontAwesomeIcons.star,color:Colors.white54,size:100),
            SizedBox(height: 20,),
            Text('Payment successfully completed',style: TextStyle(color: Colors.white,fontSize: 22),)
          ],
         ),
      ),
    );
  }
}