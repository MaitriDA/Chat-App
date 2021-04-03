import 'package:baatein/authentication/authService.dart';
import 'package:baatein/utils/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'homePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Declaring Necessary Variables
  int _pagestate = 0;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpassController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  var _backgroundColor = Color(0xFFBFEEFEC);
  var _headingColor = Color(0xFFB1E4155);
  var _arrowColor = Color(0xFFBFEEFEC);

  double _headingTop = 120;
  double _loginYOffset = 0;
  double _registerYOffset = 0;

  double windowWidth = 0;
  double windowHeight = 0;

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    confirmpassController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size of the Screen
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch (_pagestate) {
      case 0:
        _backgroundColor = Color(0xFFBFEEFEC);
        _headingColor = Color(0xFFB1E4155);
        _loginYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _headingTop = 60;
        _arrowColor = Color(0xFFBFEEFEC);
        break;
      case 1:
        _backgroundColor = Color(0xFFB1E4155);
        _headingColor = Colors.white;
        _loginYOffset = 200;
        _registerYOffset = windowHeight;
        _headingTop = 30;
        _arrowColor = Colors.white;
        break;
      case 2:
        _backgroundColor = Color(0xFFB1E4155);
        _headingColor = Colors.white;
        _loginYOffset = 200;
        _registerYOffset = 0;
        _headingTop = 30;
        _arrowColor = Colors.white;
        break;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              color: _backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          child: SafeArea(
                            child: Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: _arrowColor,
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_pagestate == 2) {
                                _pagestate = 1;
                              } else {
                                _pagestate = 0;
                              }
                            });
                          },
                        ),
                        AnimatedContainer(
                          curve: Curves.fastLinearToSlowEaseIn,
                          duration: Duration(milliseconds: 1000),
                          margin: EdgeInsets.only(top: _headingTop),
                          child: Text(
                            "Baatein",
                            style: TextStyle(
                              color: _headingColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Welcome, we are so glad to see you :)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _headingColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Center(
                          child: Image.asset('assets/images/vector5.png'),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: GestureDetector(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 32),
                            padding: EdgeInsets.all(20),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFFB1E4155),
                                borderRadius: BorderRadius.circular(50)),
                            child: Center(
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              if (_pagestate != 0) {
                                _pagestate = 0;
                              } else {
                                _pagestate = 1;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Login Section
            AnimatedContainer(
              padding: EdgeInsets.all(32),
              curve: Curves.fastLinearToSlowEaseIn,
              duration: Duration(milliseconds: 1000),
              transform: Matrix4.translationValues(0, _loginYOffset, 1),
              decoration: BoxDecoration(
                  color: Color(0xFFBFEEFEC),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: Text(
                        "Login To Continue",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  ]),
                  Column(
                    children: <Widget>[
                      InputWithIcon(
                        btnIcon: Icons.email_outlined,
                        hintText: "Email",
                        myController: emailController,
                        validateFunc: (value) {
                          if (value.isEmpty) {
                            return "Email Required";
                          } else if (!value.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                            return "Enter valid email address";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InputWithIcon(
                        btnIcon: Icons.vpn_key,
                        hintText: "Password",
                        myController: passwordController,
                        obscure: true,
                        validateFunc: (value) {
                          if (value.isEmpty) {
                            return "Enter Password";
                          } else if (value.length < 6) {
                            return "Password should be atleast 6 characters!";
                          }
                          return null;
                        },
                      ),
                      TextButton(
                        onPressed: () async {
                          final authServiceProvider =
                              Provider.of<AuthService>(context, listen: false);
                          try {
                            await authServiceProvider
                                .sendPasswordResetEmail(emailController.text);
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Reset Password Email"),
                                  content: Text(
                                      "Reset password email has been sent to your email."),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      child: TextButton(
                                        child: Text("Got it"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            print(e);
                            print('error sending email');
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Error sending reset email."),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 15, 10),
                                      child: TextButton(
                                        child: Text("Try Again"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: Text(
                          'FORGOT PASSWORD?',
                          style: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      PrimaryButton(
                        btnText: "Login",
                        onPressed: () async {
                          validateAndLogin(context);
                          // Navigator.pushNamed(context, "/setProfile");
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      PrimaryButton(
                          btnText: "Continue with Google",
                          onPressed: () async {
                            // Signing the User with Google
                            final authServiceProvider =
                                Provider.of<AuthService>(context,
                                    listen: false);
                            try {
                              var authUser =
                                  await authServiceProvider.signInWithGoogle();
                              await _createFirebaseDocument(authUser);
                              print("Users Logged In");
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_context) => HomePage()),
                              );
                              print("login successful");
                            } catch (signUpError) {
                              print(signUpError);
                            }
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        child: OutlineBtn(
                          btnText: "Create New Account",
                        ),
                        onTap: () {
                          setState(() {
                            _pagestate = 2;
                            emailController.clear();
                            passwordController.clear();
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SignUp Section
            AnimatedContainer(
                padding: EdgeInsets.all(32),
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                transform: Matrix4.translationValues(0, _registerYOffset, 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                          child: Text(
                            "Create a New Account",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    InputWithIcon(
                      btnIcon: Icons.account_circle_rounded,
                      hintText: "Name",
                      myController: nameController,
                      keyboardType: TextInputType.name,
                      validateFunc: (val) {
                        if (val.isEmpty) return 'Name Required';
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputWithIcon(
                      btnIcon: Icons.phone,
                      hintText: "Phone",
                      myController: phoneController,
                      keyboardType: TextInputType.phone,
                      validateFunc: (value) {
                        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                        RegExp regExp = new RegExp(pattern);
                        if (value.length == 0) {
                          return 'Phone Required';
                        } else if (!regExp.hasMatch(value)) {
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputWithIcon(
                      btnIcon: Icons.email_outlined,
                      hintText: "Email",
                      myController: emailController,
                      validateFunc: (value) {
                        if (value.isEmpty) {
                          return "Email Required";
                        } else if (!value.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
                          return "Enter valid email address";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputWithIcon(
                      btnIcon: Icons.vpn_key,
                      hintText: "Password",
                      obscure: true,
                      myController: passwordController,
                      validateFunc: (value) {
                        if (value.isEmpty) {
                          return "Enter Password";
                        } else if (value.length < 6) {
                          return "Password should be atleast 6 characters!";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InputWithIcon(
                        btnIcon: Icons.vpn_key,
                        hintText: "Confirm Password",
                        obscure: true,
                        myController: confirmpassController,
                        validateFunc: (val) {
                          if (val.isEmpty) return 'Empty';
                          if (val != passwordController.text)
                            return 'Not Match';
                          if (val.isEmpty) return 'Enter Password';
                          if (val != passwordController.text)
                            return 'Not Match';
                          return null;
                        }),
                    SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      child: PrimaryButton(
                        btnText: "Create Account",
                      ),
                      onTap: () async {
                        validateAndSignUp(context);
                        // Navigator.pushNamed(context, "/setProfile");
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _pagestate = 1;
                          emailController.clear();
                          passwordController.clear();
                        });
                      },
                      child: OutlineBtn(
                        btnText: "Have an account?",
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  // Checking Submission from the Form
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  // SignUp
  void validateAndSignUp(BuildContext _context) async {
    final authServiceProvider =
        Provider.of<AuthService>(_context, listen: false);
    if (validateAndSave()) {
      try {
        var authUser = await authServiceProvider.createUser(
            emailController.text, passwordController.text, nameController.text);
        await _createFirebaseDocument(authUser);
        print("Sign Up Successful!");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_context) => HomePage()),
        );
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Some error occurred!\nPlease Try Again!"),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: TextButton(
                    child: Text("Try Again"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  // logging In
  void validateAndLogin(BuildContext _context) async {
    final authServiceProvider =
        Provider.of<AuthService>(_context, listen: false);
    final authService = authServiceProvider.getCurrentUser();
    if (validateAndSave()) {
      try {
        var authUser = await authService.signInWithEmailPassword(
            emailController.text, passwordController.text);
        await _createFirebaseDocument(authUser);
        print("Sign In Successful!");
        // Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_context) => HomePage()),
        );
      } catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("Some error occurred!\nPlease Try Again!"),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: TextButton(
                    child: Text("Try Again"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<void> _createFirebaseDocument(UserCredentials authUser) async {
    final usersRef =
        FirebaseFirestore.instance.collection('Users').doc(authUser.email);
    usersRef.get().then((docSnapshot) async {
      if (!docSnapshot.exists) {
        var photo_url = authUser.photoUrl ??
            "https://firebasestorage.googleapis.com/v0/b/baatein-85a8d.appspot.com/o/noprofile.png?alt=media&token=15abddd9-a7ca-4271-9ba4-b531173c2429";
        usersRef
            .set({
              "name": authUser.displayName,
              "email": authUser.email,
              "phone": phoneController.text,
              "photo_url": photo_url
            })
            .then((value) => print("User's Document Added"))
            .catchError((error) =>
                print("Failed to add user: $error")); // create the document

        await FirebaseFirestore.instance
            .collection('Users')
            .doc("allusers")
            .update({
          "emails": FieldValue.arrayUnion([authUser.email]),
          "phones": FieldValue.arrayUnion([authUser.displayName]),
          "names": FieldValue.arrayUnion([phoneController.text]),
        });
      }
    });
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData btnIcon;
  final String hintText;
  final TextEditingController myController;
  final String Function(String) validateFunc;
  final bool obscure;
  final TextInputType keyboardType;
  InputWithIcon({
    this.btnIcon,
    this.hintText,
    this.myController,
    this.validateFunc,
    this.obscure,
    this.keyboardType,
  });

  @override
  _InputWithIconState createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: Row(
        children: <Widget>[
          Container(
              width: 60,
              child: Icon(
                widget.btnIcon,
                size: 20,
                color: Colors.grey.shade500,
              )),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontSize: 9,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    border: InputBorder.none,
                    hintText: widget.hintText),
                autocorrect: false,
                controller: widget.myController,
                validator: widget.validateFunc,
                obscureText: widget.obscure ?? false,
                keyboardType: widget.keyboardType ?? TextInputType.emailAddress,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText, this.onPressed});
  final void Function() onPressed;

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFB1E4155),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: EdgeInsets.all(15),
        child: Center(
            child: Text(
          widget.btnText,
          style: TextStyle(color: Colors.white, fontSize: 16),
        )),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFB1E4155), width: 2),
          borderRadius: BorderRadius.circular(50)),
      padding: EdgeInsets.all(15),
      child: Center(
          child: Text(
        widget.btnText,
        style: TextStyle(color: Color(0xFFB1E4155), fontSize: 16),
      )),
    );
  }
}
