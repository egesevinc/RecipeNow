import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:se380_project/homePage.dart';
import 'package:se380_project/screens/meals_screen.dart';
import 'package:se380_project/screens/recipe_screen.dart';
import 'MainPage.dart';
import 'package:se380_project/screens/search_screen.dart' ;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key,required this.onClickedSignup}) : super(key: key);
  final VoidCallback onClickedSignup;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: "Email")
          ),
          SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(style:ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),),
              icon: Icon(Icons.lock_open, size: 32 ),
              label: Text(
                'Sign In',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signIn,
            ),
            SizedBox(height: 24,),
            RichText(
            text: TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap= widget.onClickedSignup,
              style: TextStyle(color: Colors.white,fontSize: 24),
              text: 'No account?',
              children: [
                TextSpan(
                  text: 'Sign Up',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                )
              ]
            )
            )
      ],
    ),
  );
Future signIn() async{
  showDialog(context: context,barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator(),));
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    );
  } on FirebaseAuthException catch (e) {
    print(e);
  }
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'SE 380 Project',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "Montserrat"
      ),
      home: LoginPage(),
    );
  }
}
class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(snapshot.hasError){
          return Center(child: Text("Something went wrong!"),);
        }
        else if (snapshot.hasData){
          // search buraya
          return MainPage();
        }
        else {
          return AuthPage();
        }
      }
    ),
  );
  
}
class HomePageLogin extends StatelessWidget {
  const HomePageLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Signed in as",
            style: TextStyle(fontSize: 16)),
            SizedBox(height: 8,),
            Text(user.email!,
            //fontweight ekleyeceğım aşağı
            style: TextStyle(fontSize: 20),),
            SizedBox(height: 40,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.arrow_back, size: 32),
              label: Text('Sign Out', style: TextStyle(fontSize: 24),),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),

          ],
        ),
      ),
    );
  }
}
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) =>
      isLogin ? LoginWidget(onClickedSignup: toggle)
      : SignUpWidget(onClickedSignIn: toggle);
  void toggle() => setState(() =>
    isLogin = !isLogin);
  
}
class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key,required this.onClickedSignIn}) : super(key: key);
  final Function() onClickedSignIn;
  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        TextField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Email")
        ),
        SizedBox(height: 4),
        TextField(
          controller: passwordController,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton.icon(style:ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50),),
          icon: Icon(Icons.lock_open, size: 32 ),
          label: Text(
            'Sign In',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: signUp,
        ),
        SizedBox(height: 24,),
        RichText(
            text: TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap= widget.onClickedSignIn,
                style: TextStyle(color: Colors.white,fontSize: 24),
                text: 'Alread have an account?',
                children: [
                  TextSpan(
                      text: 'Log In',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary,
                      )
                  )
                ]
            )
        )
      ],
    ),
  );

  Future signUp() async {
    showDialog(context: context,barrierDismissible: false, builder: (context) => Center(child: CircularProgressIndicator(),));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
