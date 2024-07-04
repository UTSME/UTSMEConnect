import 'package:flutter/material.dart';
import 'package:utsmeconnect/src/core/navigation/utsmeconnect_router.dart';
import 'package:sizer/sizer.dart';

class UTSMEConnect extends StatelessWidget {
  const UTSMEConnect({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        title: 'UTSMEConnect',
        debugShowCheckedModeBanner: false,
        // we use UTSMEConnectRouter.router INSTEAD OF
        // UTSMEConnectRouter().router.. because we set
        // the router to be static.. but why static?
        // to prevent the router continuous restarting
        // and hence, the splash screen replaying
        routerConfig: UTSMEConnectRouter.router,
      );
    });
  }
}
