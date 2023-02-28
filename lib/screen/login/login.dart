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
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

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
                    onPressed: (() {
                      Navigator.of(context).pushNamed(MainScreen.routeName);
                    }),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      final email = emailController.text;
                      final username = usernameController.text;
                      final password = usernameController.text;

                      loginSignProvider.createUser(username, email, password);
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
