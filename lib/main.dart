import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/bloc_observer.dart';
import 'package:social/firebase_options.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/get_it_helper.dart';
import 'package:social/shared/network/local/cache_helper.dart';
// mmoamenmohamed101@gmail.com
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setup();
  await getIt<CacheHelper>().init();
  var uId = getIt<CacheHelper>().getValue(key: 'login');
  Widget? startWidget;
  if(uId != null) {
    startWidget = const SocialLayout();
  } else {
    startWidget = LoginScreen();
  }
  token = getIt<CacheHelper>().getValue(key: 'login');
  print(token);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(startWidget: startWidget));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({super.key,required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData()..getUserPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            bodySmall: TextStyle(
              fontSize: 20,
              height: 1.3,
            ),
          ),
        ),
        home: startWidget,
      ),
    );
  }
}