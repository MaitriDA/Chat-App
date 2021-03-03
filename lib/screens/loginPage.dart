import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _pagestate = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  var _backgroundColor = Color(0xFFBFEEFEC);
  var _headingColor = Color(0xFFB1E4155);
  var _arrowColor = Color(0xFFBFEEFEC);

  double _headingTop = 120;
  double _loginYOffset = 0;
  double _registerYOffset = 0;
  String _mainText = "BAATEIN";

  double windowWidth = 0;
  double windowHeight = 0;

  @override
  Widget build(BuildContext context) {
    windowHeight = MediaQuery.of(context).size.height;
    windowWidth = MediaQuery.of(context).size.width;

    switch (_pagestate) {
      case 0:
        _backgroundColor = Color(0xFFBFEEFEC);
        _headingColor = Color(0xFFB1E4155);
        _loginYOffset = windowHeight;
        _registerYOffset = windowHeight;
        _headingTop = 60;
        _mainText = "BAATEIN";
        _arrowColor = Color(0xFFBFEEFEC);
        break;
      case 1:
        _backgroundColor = Color(0xFFB1E4155);
        _headingColor = Colors.white;
        _loginYOffset = 270;
        _registerYOffset = windowHeight;
        _headingTop = 50;
        _mainText = "Hey there.";
        _arrowColor = Colors.white;
        break;
      case 2:
        _backgroundColor = Color(0xFFB1E4155);
        _headingColor = Colors.white;
        _loginYOffset = 240;
        _registerYOffset = 270;
        _headingTop = 40;
        _mainText = "Join us.";
        _arrowColor = Colors.white;
        break;
    }

    return Scaffold(
      body: Stack(children: <Widget>[
        AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: Duration(milliseconds: 1000),
          color: _backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Column(children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_pagestate == 2) {
                        _pagestate = 1;
                      } else {
                        _pagestate = 0;
                      }
                    });
                  },
                  child: SafeArea(
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: _arrowColor,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 1000),
                  margin: EdgeInsets.only(top: _headingTop),
                  child: Text(
                    "$_mainText",
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
              ])),
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
                        onTap: () {
                          setState(() {
                            if (_pagestate != 0) {
                              _pagestate = 0;
                            } else {
                              _pagestate = 1;
                            }
                          });
                        },
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
                      )),
                ],
              ),
            ],
          ),
        ),
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputWithIcon(
                    btnIcon: Icons.vpn_key,
                    hintText: "Password",
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  PrimaryButton(
                    btnText: "Login",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pagestate = 2;
                      });
                    },
                    child: OutlineBtn(
                      btnText: "Create New Account",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Create a New Account",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      )
                    ]),
                InputWithIcon(
                  btnIcon: Icons.email_outlined,
                  hintText: "your email here",
                ),
                SizedBox(
                  height: 20,
                ),
                InputWithIcon(
                  btnIcon: Icons.vpn_key,
                  hintText: "your password here",
                ),
                SizedBox(
                  height: 70,
                ),
                PrimaryButton(
                  btnText: "Create Account",
                ),
                SizedBox(
                  height: 20,
                ),
                OutlineBtn(btnText: "Continue with Google"),
              ],
            ))
      ]),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final IconData btnIcon;
  final String hintText;
  InputWithIcon({this.btnIcon, this.hintText});

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
            child: TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  border: InputBorder.none,
                  hintText: widget.hintText),
            ),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFB1E4155),
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.all(20),
      child: Center(
          child: Text(
        widget.btnText,
        style: TextStyle(color: Colors.white, fontSize: 16),
      )),
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
      padding: EdgeInsets.all(20),
      child: Center(
          child: Text(
        widget.btnText,
        style: TextStyle(color: Color(0xFFB1E4155), fontSize: 16),
      )),
    );
  }
}
