import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/account_bloc/account_bloc.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'blocs/product_bloc/product_bloc.dart';
import 'blocs/notification_bloc/notification_bloc.dart';
import 'models/product.dart';
import 'repositories/notification_repository.dart';
import 'repositories/product_repository.dart';
import 'repositories/user_repository.dart';
import 'services/auth_service.dart';
import 'theme/theme_data.dart';
import 'views/login_screen.dart';
import 'views/main_screen.dart';
import 'views/notifications_screen.dart';
import 'views/order_detail_screen.dart';
import 'views/product_detail_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => UserRepository()),
        RepositoryProvider(create: (context) => AuthenticationService()),
        RepositoryProvider(
            create: (context) => ProductRepository(FirebaseFirestore.instance)),
        RepositoryProvider(create: (context) => NotificationRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              RepositoryProvider.of<AuthenticationService>(context),
            ),
          ),
          BlocProvider<AccountBloc>(
            create: (context) => AccountBloc(
              RepositoryProvider.of<UserRepository>(context),
            ),
          ),
          BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(
              RepositoryProvider.of<ProductRepository>(context),
            ),
          ),
          BlocProvider<NotificationBloc>(
            create: (context) => NotificationBloc(
              RepositoryProvider.of<NotificationRepository>(context),
            ),
          ),
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          title: 'Flutter Demo',
          theme: buildTheme(),
          home: SplashScreen(),
          routes: {
            '/main': (context) => MainScreen(),
            '/login': (context) => LoginView(),
            '/orderDetails': (context) => OrderDetailsScreen(
                orderId: ModalRoute.of(context)!.settings.arguments as String),
            '/productDetails': (context) => ProductDetailScreen(
                product: ModalRoute.of(context)!.settings.arguments as Product),
            '/notifications': (context) => NotificationsScreen(),
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
