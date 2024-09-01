import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final FocusNode _textFieldFocusNode = FocusNode();
  final FocusNode _dateFieldFocusNode = FocusNode();
  final FocusNode _numberFieldFocusNode = FocusNode();
  final List<FocusNode> _focusCampos = []; // = List<FocusNode()>;

  @override
  void initState() {
    super.initState();
    _focusCampos.add(FocusNode());
    _focusCampos.add(FocusNode());
    _focusCampos.add(FocusNode());
  }

  @override
  void dispose() {
    // Liberar los FocusNodes
    _textFieldFocusNode.dispose();
    _dateFieldFocusNode.dispose();
    _numberFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de FocusNode'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto
            TextField(
              focusNode: _focusCampos[
                  0], // _textFieldFocusNode, // Asignar el FocusNode
              decoration: const InputDecoration(
                //labelText: 'Ingrese texto',
                label: Text("data"),
              ),
              onSubmitted: (_) {
                //FocusScope.of(context).requestFocus(
                //   _dateFieldFocusNode); // Cambiar foco al siguiente campo

                FocusScope.of(context).requestFocus(
                    _focusCampos[1]); // Cambiar foco al siguiente campo
              },
            ),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Campo de fecha (se puede usar un TextField o un widget de selección de fecha)
            TextField(
              focusNode: _focusCampos[
                  1], //_dateFieldFocusNode, // Asignar el FocusNode
              decoration: const InputDecoration(
                labelText: 'Seleccione una fecha',
              ),
              readOnly:
                  true, // Solo para lectura, puedes implementar un selector de fecha
              onSubmitted: (_) {
                //FocusScope.of(context).requestFocus(
                //  _numberFieldFocusNode); // Cambiar foco al siguiente campo
                FocusScope.of(context).requestFocus(
                    _focusCampos[2]); // Cambiar foco al siguiente campo
              },
            ),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Campo numérico
            TextField(
              focusNode: _focusCampos[
                  2], // _numberFieldFocusNode, // Asignar el FocusNode
              decoration: const InputDecoration(
                labelText: 'Ingrese un número',
              ),
              keyboardType:
                  TextInputType.number, // Permitir solo entrada numérica
              onSubmitted: (_) {
                // Puedes agregar más lógica aquí si deseas, o cambiar el foco a otro campo
                _numberFieldFocusNode
                    .unfocus(); // Quitar el foco al presionar "Enter"
              },
            ),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Botón para enfocar el primer campo (opcional)
            ElevatedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(
                    _textFieldFocusNode); // Enfocar el primer campo
              },
              child: const Text('Enfocar Campo de Texto'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyForm(),
  ));
}
