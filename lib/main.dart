import 'package:demo_futter_app/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _passwordVisible = false; // Trạng thái hiển thị mật khẩu
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  var _userNameErr = "Tài khoản không hợp lệ";
  var _passErr = "Mật khẩu phải chứa chữ hoa, chữ thường, số và ký tự đặc biệt";
  var _userInvalid = false;
  var _passInvalid = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  void onToggShowPass() {
    setState(() {
      _passwordVisible = !_passwordVisible; // Đổi từ hiện sang ẩn và ngược lại
    });
  }

  void onSignInClicked() {
    // Kiểm tra điều kiện cho tên người dùng: Phải chứa "@gmail.com"
    if (!_userController.text.contains("@gmail.com")) {
      setState(() {
        _userInvalid = true; // Báo lỗi nếu username không chứa "@gmail.com"
      });
    } else {
      setState(() {
        _userInvalid = false; // Username hợp lệ nếu chứa "@gmail.com"
      });
    }

    // Kiểm tra điều kiện cho mật khẩu: Phải chứa chữ hoa, chữ thường, số và ký tự đặc biệt
    String password = _passController.text;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    setState(() async {
      if (password.length < 8 || !hasUppercase || !hasLowercase || !hasDigits || !hasSpecialCharacters) {
        _passInvalid = true;
      } else {
        _passInvalid = false;
      }

      // Chuyển đến HomePage nếu cả tài khoản và mật khẩu hợp lệ
      if (!_userInvalid && !_passInvalid) {
      String received = await Navigator.push(context, MaterialPageRoute(builder: (context) => new HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(80),
          constraints: BoxConstraints.expand(),
          color: Colors.limeAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      'asset/images/Avatar.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(width: 20), // Add space between image and text
                  const Expanded(
                    child: Text(
                      "WELCOME TO LANA FASHION APP\nLOGIN",
                      style: TextStyle(
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  style: TextStyle(color: Colors.black, fontSize: 15),
                  controller: _userController,
                  decoration: InputDecoration(
                    labelText: "USERNAME",
                    errorText: _userInvalid ? _userNameErr : null,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _passController,
                  obscureText: !_passwordVisible, // Điều khiển việc ẩn và hiện mật khẩu
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    errorText: _passInvalid ? _passErr : null,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility // Hiện mật khẩu
                            : Icons.visibility_off, // Ẩn mật khẩu
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: onToggShowPass,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0), // Add padding around the button
                child: SizedBox(
                  width: double.infinity, // Full width of the parent container
                  height: 40, // Set the height
                  child: ElevatedButton(
                    onPressed: () {
                      onSignInClicked(); // Gọi hàm kiểm tra khi nhấn nút
                      if (!_userInvalid && !_passInvalid) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Đăng nhập thành công!!!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // Rounded edges
                      ),
                    ),
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.black87, // Text color
                        fontSize: 15, // Text size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "NEW ACCOUNT? SIGN UP",
                        style: TextStyle(
                          fontFamily: "Oswald",
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
