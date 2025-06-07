import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  late String email = '';
  late String senha = '';

  @override
  Widget build(BuildContext context) {
    return _buildLoginPage(context);
  }

  Widget _buildLoginPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfdfcea),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLogo(context),
          _buildForm(context),
          _buildLoginButton(context),
          const SizedBox(height: 10),
          _buildDivider(context),
          const SizedBox(height: 10),
          _buildRegisterButton(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Image.asset(
      'assets/images/logo2.png',
      height: 500,
      width: 500,
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xD9D9D980).withAlpha(50),
              border: InputBorder.none,
              hintText: 'Email',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            obscureText: true,
            onChanged: (value) {
              setState(() {
                senha = value;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xD9D9D980).withAlpha(50),
              border: InputBorder.none,
              hintText: 'Senha',
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              thickness: 1.5,
              color: Colors.black,
              indent: 50,
              endIndent: 10,
            ),
          ),
          Text('ou'),
          Expanded(
            child: Divider(
              thickness: 1.5,
              color: Colors.black,
              indent: 10,
              endIndent: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: senha);
          context.goNamed('menu');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao fazer login: ${e.toString()}')),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 50),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.zero,
          ),
          child: Center(
            child: Text(
              'Entrar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed('register');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.zero,
          ),
          child: Center(
            child: Text(
              'Registrar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
