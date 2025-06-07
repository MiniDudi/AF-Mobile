import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('teste');
      nameController.text = user.displayName ?? 'Nome não informado';
      emailController.text = user.email ?? 'Email não informado';
      phoneController.text = user.phoneNumber ?? 'Telefone não informado';

      birthController.text = 'Data de nascimento não informada';
      passwordController.text = '********';
    } else {
      print('teste2');
      nameController.text = '';
      emailController.text = '';
      phoneController.text = '';
      birthController.text = '';
      passwordController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfdfcea),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.goNamed('menu');
          },
        ),
        title: const Text('Perfil'),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              _buildProfilePicture(),
              const SizedBox(height: 20),
              _buildLabel('Nome:'),
              _buildInputField(controller: nameController),
              _buildLabel('Email:'),
              _buildInputField(controller: emailController),
              _buildLabel('Telefone:'),
              _buildInputField(controller: phoneController),
              _buildLabel('Data de nascimento:'),
              _buildInputField(controller: birthController),
              _buildLabel('Senha:'),
              _buildInputField(controller: passwordController, obscure: true),
              const SizedBox(height: 30),
              // _buildSaveButton(context),
              // const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Foto de perfil:',
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 10),
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage('https://picsum.photos/200/300'),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, bool obscure = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      enabled: false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Lógica de salvar
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dados salvos')),
            );
          }
        },
        child: const Text(
          'Salvar',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
