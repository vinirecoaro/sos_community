import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sos_community/firebase_options.dart';
import 'package:sos_community/providers/claim_provider.dart';
import 'package:sos_community/routes.dart';
import 'package:sos_community/screens/add_claim_screen.dart';
import 'package:sos_community/screens/claims_list_screen.dart';
import 'package:sos_community/screens/login_screen.dart';
import 'package:sos_community/screens/profile_screen.dart';
import 'package:sos_community/screens/sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ClaimProvider>(
          create: (context) => ClaimProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 11, 109, 60)),
          useMaterial3: true,
        ),
        routes: {
          Routes.LOGIN: (context) => const LoginScreen(),
          Routes.SIGN_UP: (context) => const SignUpScreen(),
          Routes.PROFILE: (context) => const ProfileScreen(),
          Routes.CLAIM_LIST: (context) => const ClaimsListScreen(),
          Routes.ADD_EDIT_CLAIM: (context) => const AddClaimScreen()
        },
      ),
    );
  }
}
