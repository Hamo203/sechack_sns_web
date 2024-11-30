import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sechack_sns_web/view/startup/registerpage2.dart';

import '../account/user_auth.dart';
import 'login.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _isObscure=true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future<void> _createUser(BuildContext context, String email, String password) async {
    try {
      await userAuth.createUserWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(msg: "Firebaseの登録に成功しました");
      Navigator.push(context, MaterialPageRoute(builder: (context) => Registerpage2()));
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: "Firebaseの登録に失敗しました");
    }
  }

  OutlineInputBorder _buildOutlineInputBorder({required Color color, required double width}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Stack(
                children: [
                  // 青い丸（上）
                  Align(
                    alignment: Alignment(-1.2, -1.2),
                    child: Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.2,
                      decoration: ShapeDecoration(
                        color: Color(0xFFC5D8E7),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  // オレンジの丸（下）
                  Align(
                    alignment: Alignment(1.5, 1.5),
                    child: Container(
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.3,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF9E4C8),
                        shape: OvalBorder(),
                      ),
                    ),
                  ),
                  // コンテンツ（アプリ名、フォーム、ボタンなど）
                  Center(
                    child: Form(
                      key: _formKey, // フォームキーを設定
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // アプリ名
                          Text(
                            'Pals Place',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.1,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w300,
                              height: 1,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05), // スペース
                          // メールアドレス入力
                          Container(
                            width: screenWidth * 0.7,
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'メールアドレスを入力',
                                filled: true,
                                fillColor: Colors.white,
                                border: _buildOutlineInputBorder(color: Colors.transparent, width: 0),
                                enabledBorder: _buildOutlineInputBorder(color: Color(0xFFF6CBD1), width: 3),
                                focusedBorder: _buildOutlineInputBorder(color: Color(0xFFF6CBD1), width: 3),
                                errorBorder: _buildOutlineInputBorder(color: Colors.red, width: 3),
                                focusedErrorBorder: _buildOutlineInputBorder(color: Colors.red, width: 3),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return "メールアドレスは必須項目です";
                                if (value.length < 6) return "メールアドレスが短すぎます";
                                String emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                                RegExp regex = RegExp(emailPattern);
                                if (!regex.hasMatch(value)) return '正しいメールアドレスを入力してください';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          // パスワード入力
                          Container(
                            width: screenWidth * 0.7,
                            child: TextFormField(
                              obscureText: _isObscure,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'パスワードを入力',
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: IconButton(
                                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                border: _buildOutlineInputBorder(color: Colors.transparent, width: 0),
                                enabledBorder: _buildOutlineInputBorder(color: Color(0xFFC5D8E7), width: 3),
                                focusedBorder: _buildOutlineInputBorder(color: Color(0xFFC5D8E7), width: 3),
                                errorBorder: _buildOutlineInputBorder(color: Colors.red, width: 3),
                                focusedErrorBorder: _buildOutlineInputBorder(color: Colors.red, width: 3),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return 'パスワードは必須項目です';
                                if (value.length < 6) return 'パスワードは6桁以上です';
                                String passwordPattern = r'^(?=.*[A-Za-z]|.*\d|.*[!@#\$&*~.])[A-Za-z\d!@#\$&*~.]{6,}$';
                                RegExp regex = RegExp(passwordPattern);
                                if (!regex.hasMatch(value.trim())) return 'パスワードは英字、数字、記号（.も含む）のいずれかを含む必要があります';
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          // 登録ボタン
                          Container(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.07,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFF2D3B5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  print("email:"+_emailController.text);
                                  print("pass:"+_passwordController.text);

                                  await _createUser(context, _emailController.text, _passwordController.text);
                                }
                              },
                              child: const Center(
                                child: Text(
                                  'メールアドレスで登録',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          // すでに登録済みの場合のリンク
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login()),
                              );
                            },
                            child: Text(
                              'すでに登録済みの場合はこちら',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth * 0.04,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
