part of 'helpers.dart';

showLoading (BuildContext context){
  showDialog(
    context: context,
    barrierDismissible:false,
    builder: (_) =>const AlertDialog(
      title: Text('Wait please...'),
      content: LinearProgressIndicator(),
    )
    );
}

showCustomAlert (BuildContext context,String title, String msg){
  showDialog(
    context: context,
     builder: (_)=>AlertDialog(
      title: Center(child: Text (title)),
      content: Center(child: Text(msg)),
      actions: [
        MaterialButton(
          onPressed: (){
            Navigator.of(context).pop();          },
          child: const Text('Ok'),
          )
      ],
     )
     );

}