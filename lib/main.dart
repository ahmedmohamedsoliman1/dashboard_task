import 'package:dashboard_task/config/app_theming.dart';
import 'package:dashboard_task/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'features/dashboard/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true ,
      minTextAdapt: true,
      designSize: const Size(360, 690),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dashboard_Task',
        theme: AppTheming.lightTheme ,
        initialRoute: AppRoutes.dashboardRoute,
        routes: {
          AppRoutes.dashboardRoute : (context) => const DashBoardScreen()
        },
      ),
    );
  }
}

