import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GelatoListPage extends StatelessWidget {
  GelatoListPage({super.key});

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
        title: const Text('Gelatos'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildButton(context, 'Adicionar Gelato', Colors.black),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('gelatos').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  if (docs.isEmpty) {
                    return const Center(child: Text('Nenhum gelato encontrado.'));
                  }

                  return ListView.separated(
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final docId = docs[index].id;

                      return _buildGelatoItem(context, data, docId);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        onPressed: () {
          context.goNamed(
            'gelato-register',
            extra: {'isEdit': false},
          );
        },
        child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildGelatoItem(BuildContext context, Map<String, dynamic> item, String docId) {
    return GestureDetector(
      onTap: () {
        context.goNamed(
          'gelato-register',
          extra: {'isEdit': true, 'docId': docId},
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            item['imagem'] ?? 'https://picsum.photos/200/300',
          ),
        ),
        title: Text(item['name'] ?? 'Sem nome', style: const TextStyle(fontSize: 16)),
        subtitle: Text('Quantidade: ${item['stock'] ?? '0'}'),
      ),
    );
  }
}

