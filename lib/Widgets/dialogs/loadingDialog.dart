import 'package:flutter/material.dart';
import 'package:thinkcreative_technologies/Configs/Mycolors.dart';

class LoadingAlertDialog extends StatelessWidget {
  final String? messagetitle;
  final String? messagesubtitle;
  const LoadingAlertDialog({Key? key, this.messagetitle, this.messagesubtitle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Container(
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Mycolors.loadingindicator)),
            SizedBox(
              width: 27,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(messagetitle ?? 'Please wait...'),
                SizedBox(height: 7),
                Text(
                  messagesubtitle ?? '',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container circularProgress() {
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10.0),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Mycolors.loadingindicator),
      ));
}

Container linearProgress() {
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Mycolors.loadingindicator),
    ),
  );
}
