import 'package:family/screen/main/main_screen.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isDisplayLogin = false;

  @override
  Widget build(BuildContext context) {
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
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  )
                : const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 30,
                    ),
                  ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, left: 15, right: 15),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                color: Colors.blue,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintText: "Email",
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
                color: Colors.blue,
              ),
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
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
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  )
                : const ElevatedButton(
                    onPressed: null,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
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
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )
                    : const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white,
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
                            color: Colors.white,
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
                            color: Colors.white,
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
