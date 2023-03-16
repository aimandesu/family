import 'package:family/providers/login_sign_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final VoidCallback changeTheme;
  const Login({super.key, required this.changeTheme});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isDisplayLogin = true;

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
        ? message = 'account successfully created'
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

  void showMessage(String message, BuildContext ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // void loginSucces(bool authentication) {
  //   if (authentication) {
  //     Navigator.of(context).pushNamed(MainScreen.routeName);
  //   } else {
  //     // _showDialog(authentication);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final mediaQuery = MediaQuery.of(context);
    var appBar2 = AppBar();

    final paddingTop = appBar2.preferredSize.height + mediaQuery.padding.top;
    //provider
    final loginSignProvider =
        Provider.of<LoginSignProvider>(context, listen: false);
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: (mediaQuery.size.height - paddingTop) * 0.1,
                child: Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: widget.changeTheme,
                    icon: const Icon(Icons.dark_mode),
                  ),
                ),
              ),
              SizedBox(
                height: (mediaQuery.size.height - paddingTop) * 0.9,
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
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 30, left: 15, right: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: const BorderRadius.all(
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
                    isDisplayLogin
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(
                                bottom: 30, left: 15, right: 15),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              borderRadius: const BorderRadius.all(
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
                      margin: const EdgeInsets.only(
                          bottom: 30, left: 15, right: 15),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        borderRadius: const BorderRadius.all(
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
                              final email = emailController.text;
                              final password = passwordController.text;

                              try {
                                // loginSignProvider.loginUser(email, password);
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                              } on PlatformException catch (e) {
                                var message =
                                    'An error occured, please check your credential';

                                if (e.message != null) {
                                  message = e.message!;
                                }
                                showMessage(message, context);
                              } catch (e) {
                                // print(e);
                              }
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

                              final userAvailablity = await loginSignProvider
                                  .findUserAvailable(username);

                              if (!userAvailablity) {
                                loginSignProvider.createUser(
                                    username, email, password);
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
                                  isDisplayLogin = !isDisplayLogin;
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
                                  isDisplayLogin = !isDisplayLogin;
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
            ],
          ),
        ),
      ),
    );
  }
}
