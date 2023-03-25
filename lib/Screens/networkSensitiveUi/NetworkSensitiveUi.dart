import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thinkcreative_technologies/Services/providers/ConnectivityServices.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget? child;
  final double opacity;

  NetworkSensitive({
    this.child,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.Offline) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi_off_rounded,
                  size: 55,
                ),
                SizedBox(
                  height: 22,
                ),
                Text(
                  'No Internet',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Please check your Internet Connection',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // return Opacity(
    //   opacity: 0.1,
    //   child: child,
    // );
    return child!;
  }
}
