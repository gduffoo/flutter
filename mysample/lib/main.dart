import 'package:flutter/material.dart';

class MyFormField extends StatefulWidget {
  const MyFormField({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  DateTime? _selectedDate;
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _textFieldFocusNode =
      FocusNode(); // FocusNode para el campo de texto
  String? _selectedOption;

  List<String> options = ['Opción 1', 'Opción 2', 'Opción 3'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose(); // Liberar el FocusNode
    _numberController.dispose(); // Liberar el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario Elegante'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campo de texto con límite de 20 caracteres
            CustomTextFormField(textFieldFocusNode: _textFieldFocusNode),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Campo de fecha
            TextField(
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: _selectedDate == null
                    ? 'Seleccione una fecha'
                    : 'Fecha: ${_selectedDate!.toLocal()}'.split(' ')[0],
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              ),
            ),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Campo numérico que solo acepta números
            TextFormField(
              controller: _numberController,
              keyboardType:
                  TextInputType.number, // Permitir solo entrada numérica
              decoration: InputDecoration(
                labelText: 'Ingrese un número',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              ),
              style: const TextStyle(fontSize: 16.0),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese un número';
                }
                // Verifica si el valor es un número válido
                if (double.tryParse(value) == null) {
                  return 'Ingrese un número válido';
                }
                return null; // Si es válido, no hay error
              },
            ),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Campo de opciones (Dropdown)
            DropdownButtonFormField<String>(
              value: _selectedOption,
              decoration: InputDecoration(
                labelText: 'Seleccione una opción',
                labelStyle: TextStyle(color: Colors.grey[700]),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
              },
            ),
            const SizedBox(height: 16.0), // Espacio entre campos

            // Botón para enfocar el primer campo
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

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required FocusNode textFieldFocusNode,
  }) : _textFieldFocusNode = textFieldFocusNode;

  final FocusNode _textFieldFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _textFieldFocusNode, // Asignar el FocusNode
      maxLength: 20, // Limitar a 20 caracteres
      decoration: InputDecoration(
        //labelText: 'Ingrese su texto',
        label: const Text("Ingrese su texto"),
        labelStyle: TextStyle(
          color: Colors.grey[700],
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      style: const TextStyle(fontSize: 16.0),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyFormField(),
  ));
}
