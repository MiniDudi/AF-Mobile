import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GelatoRegister extends StatefulWidget {
  const GelatoRegister({super.key, required this.isEdit, this.docId});

  final bool isEdit;
  final String? docId;

  @override
  State<StatefulWidget> createState() => _GelatoRegisterState();
}

class _GelatoRegisterState extends State<GelatoRegister> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  bool isActive = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.docId != null) {
      _loadGelatoData(widget.docId!);
    }
  }

  Future<void> _loadGelatoData(String docId) async {
    try {
      final doc = await FirebaseFirestore.instance.collection('gelatos').doc(docId).get();
      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          nameController.text = data['name'] ?? '';
          descriptionController.text = data['description'] ?? '';
          stockController.text = data['stock']?.toString() ?? '';
          priceController.text = data['price']?.toString() ?? '';
          unitController.text = data['unit'] ?? '';
          typeController.text = data['type'] ?? '';
          isActive = data['isActive'] ?? false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar gelato: $e')),
      );
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
            context.goNamed('mainList');
          },
        ),
        title: Text(widget.isEdit ? 'Editar Gelato' : 'Adicionar Gelato'),
        centerTitle: true,
        elevation: 0,
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
              _buildGelatoPicture(),
              const SizedBox(height: 20),
              _buildLabel('Nome/sabor:'),
              _buildInputField(controller: nameController),
              _buildLabel('Descrição:'),
              _buildInputField(controller: descriptionController, maxLines: 3),
              _buildLabel('Quantidade/estoque:'),
              _buildInputField(controller: stockController, keyboardType: TextInputType.number),
              _buildLabel('Preço:'),
              _buildInputField(controller: priceController, keyboardType: TextInputType.number),
              _buildDropdownField(
                label: 'Unidade de medida:',
                value: unitController.text,
                items: ['litro', 'unidade de picolé'],
                onChanged: (value) {
                  setState(() {
                    unitController.text = value!;
                  });
                },
              ),
              _buildLabel('Tipo de venda:'),
              _buildInputField(controller: typeController),
              _buildCheckbox(),
              const SizedBox(height: 30),
              _buildSaveButton(),
              if (widget.isEdit) ...[
                const SizedBox(height: 10),
                _buildDeleteButton(),
              ],
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGelatoPicture() {
    return Column(
      children: [
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Foto do Gelato',
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

  Widget _buildInputField({
    required TextEditingController controller,
    bool obscure = false,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? hintText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade300,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        DropdownButtonFormField<String>(
          value: items.contains(value) ? value : null,
          onChanged: onChanged,
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade300,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(top: 10, bottom: 5),
          child: Text(
            'Ativo:',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, height: 1),
          ),
        ),
        Checkbox(
          value: isActive,
          onChanged: (value) {
            setState(() {
              isActive = value ?? false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final gelatoData = {
              'name': nameController.text,
              'description': descriptionController.text,
              'stock': int.tryParse(stockController.text) ?? 0,
              'price': double.tryParse(priceController.text) ?? 0.0,
              'unit': unitController.text,
              'type': typeController.text,
              'isActive': isActive,
              'createdAt': FieldValue.serverTimestamp(),
            };

            try {
              if (widget.isEdit && widget.docId != null) {
                await FirebaseFirestore.instance.collection('gelatos').doc(widget.docId).update(gelatoData);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gelato atualizado com sucesso!')),
                );
                context.goNamed('mainList');
              } else {
                await FirebaseFirestore.instance.collection('gelatos').add(gelatoData);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gelato adicionado com sucesso!')),
                );
                context.goNamed('mainList');
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao salvar gelato: $e')),
              );
            }
          }
        },
        child: Text(
          widget.isEdit ? 'Atualizar' : 'Salvar',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade300,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        onPressed: () async {
          if (widget.docId != null) {
            try {
              await FirebaseFirestore.instance.collection('gelatos').doc(widget.docId).delete();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gelato deletado com sucesso!')),
              );
              context.goNamed('mainList');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao deletar gelato: $e')),
              );
            }
          }
        },
        child: Text(
          'Deletar',
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}
