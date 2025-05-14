import 'package:flutter/material.dart';
import 'package:provaum/classes/botao_calculadora.dart';
import 'package:provaum/enums/tipo_operacao.dart';
import 'package:provaum/widgets/teclado_calculadora.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blue.shade100,
          surface: Colors.blue.shade50,
        ),
        useMaterial3: true,
      ),
      home: const CalculadoraScreen(),
    );
  }
}

class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  String _display = '0';
  String _operacao = '';
  double? _primeiroNumero;
  bool _novoNumero = true;
  String _historico = '';

  void _handleBotaoPressed(TipoOperacao tipo) {
    setState(() {
      final botao = BotaoCalculadora.botaoDetails()[tipo]!;

      if (tipo == TipoOperacao.limpar) {
        _resetCalculadora();
        return;
      }

      if (tipo == TipoOperacao.apagar) {
        _apagarUltimoCaractere();
        return;
      }

      if (tipo == TipoOperacao.ponto) {
        _adicionarPontoDecimal();
        return;
      }

      if ([
        TipoOperacao.somar,
        TipoOperacao.subtrair,
        TipoOperacao.multiplicar,
        TipoOperacao.dividir,
      ].contains(tipo)) {
        _handleOperacao(botao.valor);
        return;
      }

      if (tipo == TipoOperacao.igual) {
        _calcularResultado();
        return;
      }

      _adicionarDigito(botao.valor);
    });
  }

  void _resetCalculadora() {
    _display = '0';
    _operacao = '';
    _primeiroNumero = null;
    _novoNumero = true;
    _historico = '';
  }

  void _apagarUltimoCaractere() {
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
      _novoNumero = true;
    }
  }

  void _adicionarPontoDecimal() {
    if (_novoNumero) {
      _display = '0.';
      _novoNumero = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
  }

  void _handleOperacao(String operacao) {
    if (_operacao.isNotEmpty && !_novoNumero) {
      _calcularResultado();
    }
    _primeiroNumero = double.parse(_display);
    _operacao = operacao;
    _historico = '$_primeiroNumero $_operacao';
    _novoNumero = true;
  }

  void _calcularResultado() {
    if (_operacao.isEmpty || _primeiroNumero == null || _novoNumero) return;

    final segundoNumero = double.parse(_display);
    double resultado;

    switch (_operacao) {
      case '+':
        resultado = _primeiroNumero! + segundoNumero;
        break;
      case '-':
        resultado = _primeiroNumero! - segundoNumero;
        break;
      case '×':
        resultado = _primeiroNumero! * segundoNumero;
        break;
      case '÷':
        resultado = segundoNumero != 0 ? _primeiroNumero! / segundoNumero : double.infinity;
        break;
      default:
        resultado = 0;
    }

    _historico = '$_primeiroNumero $_operacao $segundoNumero =';
    _display = resultado.isInfinite 
      ? 'Erro' 
      : resultado.toString().replaceAll(RegExp(r'\.0$'), '');
    _operacao = '';
    _primeiroNumero = null;
    _novoNumero = true;
  }

  void _adicionarDigito(String digito) {
    if (_novoNumero) {
      _display = digito;
      _novoNumero = false;
    } else {
      _display += digito;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  _historico,
                  style: const TextStyle(
                    fontSize: 24, 
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              
              
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    _display,
                    style: const TextStyle(
                      fontSize: 58, 
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: TecladoCalculadora(
                  onPressed: _handleBotaoPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}