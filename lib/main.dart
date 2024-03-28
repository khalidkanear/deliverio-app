import '/Model/CompletedOrders.dart';
import '/Screens/ChatScreen/Chat.dart';
import '/Screens/CollectCash/CollectCash.dart';
import '/Screens/Dashboard/Dashboard.dart';
import '/Screens/DragableList/Model/SelectedItemsListener.dart';
import '/Screens/ErrorScreens/NoConnection.dart';
import '/Screens/ErrorScreens/NoGPS.dart';
import '/Screens/HomeScreen/Components/HomeBody.dart';
import '/Screens/HomeScreen/HomeScreen.dart';
import '/Screens/OrderInitiated/Model/MapChangeListener.dart';
import '/Screens/OrderInitiated/Model/OrderStatusListener.dart';
import '/Screens/OrderInitiated/OrderInitiated.dart';
import '/Screens/Profile/Profile.dart';
import '/Screens/SignUp/Model/ProfileChangeNotifier.dart';
import '/Screens/SignUp/SignUp.dart';
import '/Screens/Welcome/Welcome.dart';
import '/Screens/Thankyou/Thankyou.dart';
import '/Styling.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Screen Imports
//Screen Imports
import 'Config.dart';
import 'Screens/CaptureImage/CaptureImage.dart';
import 'Screens/ErrorScreens/Error.dart';
import 'Screens/ForgotPassword/ForgotPasswordScreen.dart';
import 'Screens/HomeScreen/Components/DialogScreen.dart';
import 'Screens/HomeScreen/Components/HomeBody.dart';
import 'Screens/HomeScreen/Models/StatusProvider.dart';
import 'Screens/Login/Login.dart';
import 'Screens/OrderDetails/OrderDetails.dart';
import 'Screens/Orders/Models/OrdersListener.dart';
import 'Screens/Orders/Orders.dart';
import 'Screens/SplashScreens/SplashScreen.dart';
import 'Screens/SplashScreens/SplashScreen1.dart';
import 'Screens/SplashScreens/SplashScreen2.dart';
import 'Styling.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  Firebase.initializeApp();

  debugPrint('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => Status()),
                  ChangeNotifierProvider(create: (_) => OrderStatusListener()),
                  ChangeNotifierProvider(create: (_) => MapChangeListener()),
                  ChangeNotifierProvider(create: (_) => SelectedItem()),
                  ChangeNotifierProvider(create: (_) => OrdersListener()),
                  ChangeNotifierProvider(
                      create: (_) => ProfileChangeNotifier()),
                  ChangeNotifierProvider(
                      create: (_) => CompletedOrdersProvider()),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme: AppTheme.lightTheme,
                  initialRoute: '/',
                  routes: {
                    '/': (context) => SplashScreen(),
                    '/chatScreen': (context) => const ChatScreen(),
                    '/splashScreen': (context) => SplashScreenOne(),
                    '/second': (context) => SplashScreenTwo(),
                    '/login': (context) => Login(),
                    '/forgotPassword': (context) => ForgotPassword(),
                    '/signup': (context) => SignUp(false, null),
                    '/welcome': (context) => Welcome(),
                    '/home': (context) => HomeScreen(),
                    '/orderInitiated': (context) => OrderInitiated(),
                    '/orders': (context) => Orders(),
                    '/orderDetails': (context) => OrderDetailsScreen(),
                    '/dashboard': (context) => Dashboard(),
                    '/profile': (context) => Profile(),
                    '/noConnection': (context) => NoConnection(),
                    '/locationError': (context) => NoGPS(),
                    '/error': (context) => ErrorScreen(),
                    '/collectCash': (context) => CollectCash(),
                    '/captureImage': (context) => CaptureImageScreen(),
                    '/thankyou': (context) => Thankyou(),
                    '/dialogScreen': (context) => DialogScreen(),
                  },
                ));
          },
        );
      },
    );
  }
}
