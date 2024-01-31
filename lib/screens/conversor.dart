import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:proy_final/models/monedas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class MonedaOption {
  final String codigo;
  final String descripcion;

  MonedaOption(this.codigo, this.descripcion);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonedaOption &&
          runtimeType == other.runtimeType &&
          codigo == other.codigo &&
          descripcion == other.descripcion;

  @override
  int get hashCode => codigo.hashCode ^ descripcion.hashCode;
}

class ConversorVentana extends StatefulWidget {
  const ConversorVentana({Key? key}) : super(key: key);

  @override
  _ConversorVentanaState createState() => _ConversorVentanaState();
}

class _ConversorVentanaState extends State<ConversorVentana> {
  Monedas? monedas;
  final TextEditingController _numeroController = TextEditingController();
  MonedaOption? _unidadDesdeOption;
  MonedaOption? _unidadHastaOption;
  String _resultadoConversion = '';

  @override
  void initState() {
    super.initState();
    getUnidades();
  }

  Future<void> getUnidades() async {
    try {
      final response =
          await Dio().get('https://api.frankfurter.app/currencies');
      setState(() {
        monedas = Monedas.fromJson(response.data);

        // Verificamos si hay monedas disponibles antes de asignar valores iniciales
        if (monedas != null && monedas!.toJson().isNotEmpty) {
          _unidadDesdeOption = MonedaOption(
            monedas!.toJson().keys.first,
            monedas!.toJson().values.first,
          );
          _unidadHastaOption = MonedaOption(
            monedas!.toJson().keys.first,
            monedas!.toJson().values.first,
          );
        }
      });
    } catch (e) {
      print('Error al obtener las monedas: $e');
    }
  }

  Future<void> convertirMoneda() async {
    // Valida valor ingresado
    if (_numeroController.text.isEmpty) {
      mostrarError('Ingrese un valor numérico.');
      return;
    }

    try {
      // Intentar convertir moneda
      final response = await Dio().get(
        'https://api.frankfurter.app/latest',
        queryParameters: {
          'amount': _numeroController.text,
          'from': _unidadDesdeOption?.codigo,
          'to': _unidadHastaOption?.codigo,
        },
      );

      setState(() {
        _resultadoConversion =
            '${_numeroController.text} ${_unidadDesdeOption?.codigo} = ${response.data['rates'][_unidadHastaOption?.codigo]} ${_unidadHastaOption?.codigo}';
      });
    } catch (e) {
      // Mostrar mensaje de error si hay un problema en la conv (validaciones)
      mostrarError('Error al realizar la conversión: $e');
    }
  }

  // Método para mostrar mensajes de error
  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Monedas - Ronald Viorel',
          style: GoogleFonts.happyMonkey(
            fontSize: 22.0,
            color: const Color(0xFFF3F3F8),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _numeroController,
              keyboardType: TextInputType.number,
              inputFormatters: [DecimalTextInputFormatter()],
              decoration: const InputDecoration(labelText: 'Ingrese el valor a convertir'),
            ),
            const SizedBox(height: 22.0),
            const Text('Convertir de:'),
            DropdownButton<MonedaOption>(
              value: _unidadDesdeOption,
              onChanged: (newValue) {
                setState(() {
                  _unidadDesdeOption = newValue;
                });
              },
              items: monedas
                      ?.toJson()
                      .entries
                      .map<DropdownMenuItem<MonedaOption>>(
                        (entry) => DropdownMenuItem(
                          value: MonedaOption(entry.key, entry.value),
                          child: Text('${entry.key}-${entry.value}'),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            const SizedBox(height: 11.0),
            const Text('A:'),
            DropdownButton<MonedaOption>(
              value: _unidadHastaOption,
              onChanged: (newValue) {
                setState(() {
                  _unidadHastaOption = newValue;
                });
              },
              items: monedas
                      ?.toJson()
                      .entries
                      .map<DropdownMenuItem<MonedaOption>>(
                        (entry) => DropdownMenuItem(
                          value: MonedaOption(entry.key, entry.value),
                          child: Text('${entry.key}-${entry.value}'),
                        ),
                      )
                      .toList() ??
                  [],
            ),
            const SizedBox(height: 11.0),
            ElevatedButton(
              onPressed: () {
                convertirMoneda();
              },
              child: const Text('CONVERTIR'),
            ),
            const SizedBox(height: 11.0),
            Center(
              child: Text(
                _resultadoConversion,
                style: GoogleFonts.happyMonkey(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 171, 89, 225),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // hacemos el icono centrado al final
            const SizedBox(height: 8.0),
            const Center(
              child: FaIcon(
                FontAwesomeIcons.moneyBill1Wave, 
                size: 70.0,
                color: Color.fromARGB(255, 171, 89, 225), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text == '.' || newValue.text == '-') {
      return oldValue;
    } else if (newValue.text.contains('-') && newValue.text.indexOf('-') != 0) {
      return oldValue;
    } else if (newValue.text.split('.').length > 2) {
      return oldValue;
    }
    return newValue;
  }
}
