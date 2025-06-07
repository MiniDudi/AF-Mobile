import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<StatefulWidget> createState() => _MenuPage();
}

class _MenuPage extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return _buildMenuPage(context);
  }

  Widget _buildMenuPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfdfcea),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLogo(context),
          _buildProfileButton(context),
          const SizedBox(height: 10),
          _buildGelatoButton(context),
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

  Widget _buildProfileButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed('profile');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: Text(
              'Perfil',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGelatoButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed('mainList');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 15),
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(60),
          ),
          child: Center(
            child: Text(
              'Gelatos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
