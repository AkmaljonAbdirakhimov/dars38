import 'package:dars38/pages/home_page.dart';
import 'package:dars38/pages/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic>? user;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  String userError = "";

  void login() {
    // ma'lumotlarni olamiz va tekshiramiz
    validateEmail();
    validatePassword();

    if (emailError == null && passwordError == null) {
      if (user == null) {
        userError = "Foydalanuvchi topilmadi, iltimos ro'yxatdan o'ting";
        setState(() {});
      } else {
        if (user!['email'] == emailController.text &&
            user!['password'] == passwordController.text) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (ctx) {
                return const HomePage();
              },
            ),
          );
        } else {
          userError = "Email yoki parol xato";
          setState(() {});
        }
      }
    }
  }

  void validateEmail() {
    String email = emailController.text;

    setState(() {
      if (email.isEmpty) {
        emailError = "Iltimos elektron pochta kiriting";
      } else if (!email.contains("@") ||
          !email.substring(email.indexOf("@")).contains(".")) {
        emailError = "To'g'ri elektron pochta kiriting";
      } else {
        emailError = null;
      }
    });
  }

  void validatePassword() {
    String password = passwordController.text;

    setState(() {
      if (password.isEmpty) {
        passwordError = "Iltimos parol kiriting";
      } else {
        passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "TIZIMGA KIRISH",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (userError.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    userError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.email),
                hintText: "Elektron pochta",
                labelText: "Elektron pochta",
                errorText: emailError,
              ),
              onChanged: (value) {
                validateEmail();
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.password),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.eye_slash),
                ),
                hintText: "Parol",
                labelText: "Parol",
                errorText: passwordError,
              ),
              onChanged: (value) {
                validatePassword();
              },
              onSubmitted: (value) {
                login();
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text("KIRISH"),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () async {
                user = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const RegisterPage();
                    },
                  ),
                );
                print(user);
                if (user != null) {
                  setState(() {});
                }
              },
              child: const Text("Ro'yxatdan o'tish"),
            ),
          ],
        ),
      ),
    );
  }
}
