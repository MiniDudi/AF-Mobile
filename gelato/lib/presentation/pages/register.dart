import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  late String email = '';
  late String senha = '';

  @override
  Widget build(BuildContext context) {
    return _buildRegisterPage(context);
  }

  Widget _buildRegisterPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed('login');
          },
        ),
        title: Text('Registro'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildForm(context),
          const SizedBox(height: 30),
          _buildRegisterButton(context),
        ],
      ),
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

  Widget _buildRegisterButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: senha);
          context.goNamed('login');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao registrar: ${e.toString()}')),
          );
        }
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
