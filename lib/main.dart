import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/bloc_observer.dart';
import 'package:social/firebase_options.dart';
import 'package:social/layout/cubit/social_cubit.dart';
import 'package:social/layout/social_layout.dart';
import 'package:social/modules/login/login_screen.dart';
import 'package:social/modules/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit(),
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
              ),
            )),
        home:  LoginScreen(),
      ),
    );
  }
}
