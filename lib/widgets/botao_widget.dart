import 'package:flutter/material.dart';
import 'package:provaum/classes/botao_calculadora.dart';
import 'package:provaum/enums/tipo_operacao.dart';

class BotaoWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final TipoOperacao tipo;
  final bool grande;

  const BotaoWidget({
    super.key,
    required this.onPressed,
    required this.tipo,
    this.grande = false,
  });

  @override
  Widget build(BuildContext context) {
    final botao = BotaoCalculadora.botaoDetails()[tipo]!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          minimumSize: Size(
            grande ? 160 : 75, 
            65, 
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: Text(
          botao.valor,
          style: const TextStyle(
            fontSize: 29, 
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}