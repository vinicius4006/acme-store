import 'dart:async';

import 'package:acme_store/models/lista_produtos.dart';
import 'package:acme_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => context.read<ListaProdutos>().carregarProdutos().then((value) {
              Navigator.pushNamed(context, Rotas.PRODUTOS);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color(0x00ffffff),
        elevation: 0,
        bottomOpacity: 1,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xFFC9CBA3),
          Color(0xFFFFE1A8),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            LoadingAnimationWidget.threeRotatingDots(
                color: Colors.white, size: 250),
            const Positioned(
              top: 125,
              child: Text(
                'ACME',
                style: TextStyle(fontSize: 30),
              ),
            )
          ],
        )),
      ),
    );
  }
}
