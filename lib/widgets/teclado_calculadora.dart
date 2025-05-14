import 'package:flutter/material.dart';
import 'package:provaum/enums/tipo_operacao.dart';
import 'package:provaum/widgets/botao_widget.dart';

class TecladoCalculadora extends StatelessWidget {
  final Function(TipoOperacao) onPressed;

  const TecladoCalculadora({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          
          _buildButtonRow([
            TipoOperacao.limpar,
            TipoOperacao.apagar,
            TipoOperacao.dividir,
          ]),
          const SizedBox(height: 10),
          
          
          _buildButtonRow([
            TipoOperacao.sete,
            TipoOperacao.oito,
            TipoOperacao.nove,
            TipoOperacao.multiplicar,
          ]),
          const SizedBox(height: 10),
          
         
          _buildButtonRow([
            TipoOperacao.quatro,
            TipoOperacao.cinco,
            TipoOperacao.seis,
            TipoOperacao.subtrair,
          ]),
          const SizedBox(height: 10),
          
          
          _buildButtonRow([
            TipoOperacao.um,
            TipoOperacao.dois,
            TipoOperacao.tres,
            TipoOperacao.somar,
          ]),
          const SizedBox(height: 10),
          
          
          Row(
            children: [
              Expanded(
                flex: 2,
                child: BotaoWidget(
                  tipo: TipoOperacao.zero,
                  onPressed: () => onPressed(TipoOperacao.zero),
                  grande: true,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BotaoWidget(
                  tipo: TipoOperacao.ponto,
                  onPressed: () => onPressed(TipoOperacao.ponto),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: BotaoWidget(
                  tipo: TipoOperacao.igual,
                  onPressed: () => onPressed(TipoOperacao.igual),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<TipoOperacao> botoes) {
    return Row(
      children: botoes.map((tipo) {
        return Expanded(
          child: BotaoWidget(
            tipo: tipo,
            onPressed: () => onPressed(tipo),
          ),
        );
      }).toList(),
    );
  }
}