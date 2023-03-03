import 'package:family/providers/login_sign_provider.dart';
import 'package:family/screen/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isDisplayLogin = false;

  //controller
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //function
  void _showDialog(bool option) {
    String message = '';
    option == false
        ? message = 'Account has been created'
        : message = 'username has been used';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: option == false
            ? const Text('Succeed')
            : const Text('An Error Occured'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Okay'),
          ),
        ],
      ),
    );
  }

  void loginSucces(bool authentication) {
    if (authentication) {
      Navigator.of(context).pushNamed(MainScreen.routeName);
    } else {
      _showDialog(authentication);
    }
  }

  @override
  Widget build(BuildContext context) {
    //provider
    final loginSignProvider =
        Provider.of<LoginSignProvider>(context, listen: false);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isDisplayLogin
                ? const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )
                : const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            isDisplayLogin
                ? Container()
                : Container(
                    margin:
                        const EdgeInsets.only(bottom: 30, left: 15, right: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      style: const TextStyle(),
                      decoration: const InputDecoration.collapsed(
                        hintStyle: TextStyle(),
                        hintText: "Email",
                      ),
                    ),
                  ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: TextFormField(
                controller: usernameController,
                style: const TextStyle(),
                decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(),
                  hintText: "Username",
                ),
              ),
            ),
            // Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: TextFormField(
                controller: passwordController,
                style: const TextStyle(),
                decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(),
                  hintText: "Password",
                ),
              ),
            ),
            isDisplayLogin
                ? ElevatedButton(
                    onPressed: () async {
                      final username = usernameController.text;
                      final password = passwordController.text;

                      final succeed =
                          await loginSignProvider.loginUser(username, password);

                      loginSucces(succeed);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () async {
                      final email = emailController.text;
                      final username = usernameController.text;
                      final password = passwordController.text;

                      final userAvailablity =
                          await loginSignProvider.findUserAvailable(username);

                      if (!userAvailablity) {
                        loginSignProvider.createUser(username, email, password);
                      }

                      _showDialog(userAvailablity);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isDisplayLogin
                    ? const Text(
                        "No account yet?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    : const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                isDisplayLogin
                    ? TextButton(
                        onPressed: () => setState(() {
                          isDisplayLogin = false;
                        }),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: () => setState(() {
                          isDisplayLogin = true;
                        }),
                        child: const Text(
                          "login",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
