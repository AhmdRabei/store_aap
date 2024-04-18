import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:store_test/firebase_options.dart';
import 'package:store_test/views/edit_view.dart';
import 'package:store_test/views/home_view.dart';
import 'package:store_test/views/login_view.dart';
import 'package:store_test/views/register_view.dart';
import 'package:store_test/widgets/user_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const StoreTest());
}

class StoreTest extends StatelessWidget {
  const StoreTest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.id: (context) => const LoginView(),
        RegisterView.id: (context) => const RegisterView(),
        HomeView.id: (context) => const HomeView(),
        UserState.id: (context) => const UserState(),
        EditView.id: (context) => const EditView(),
      },
      initialRoute: UserState.id,
    );
  }
}
