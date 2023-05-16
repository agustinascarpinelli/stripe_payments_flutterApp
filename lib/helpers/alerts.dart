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
showCustomAlert(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Text(title)),
              const SizedBox(height: 10),
              Center(child: Text(msg)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}