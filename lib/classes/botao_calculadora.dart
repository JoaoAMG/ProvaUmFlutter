import 'package:provaum/enums/tipo_operacao.dart';

class BotaoCalculadora {
  final String valor;
  final TipoOperacao tipo;

  const BotaoCalculadora({
    required this.valor,
    required this.tipo,
  });

  static Map<TipoOperacao, BotaoCalculadora> botaoDetails() {
    return {
      TipoOperacao.limpar: const BotaoCalculadora(
        valor: 'AC',
        tipo: TipoOperacao.limpar,
      ),
      TipoOperacao.apagar: const BotaoCalculadora(
        valor: '⌫',
        tipo: TipoOperacao.apagar,
      ),
      TipoOperacao.dividir: const BotaoCalculadora(
        valor: '÷',
        tipo: TipoOperacao.dividir,
      ),
      TipoOperacao.multiplicar: const BotaoCalculadora(
        valor: '×',
        tipo: TipoOperacao.multiplicar,
      ),
      TipoOperacao.subtrair: const BotaoCalculadora(
        valor: '-',
        tipo: TipoOperacao.subtrair,
      ),
      TipoOperacao.somar: const BotaoCalculadora(
        valor: '+',
        tipo: TipoOperacao.somar,
      ),
      TipoOperacao.igual: const BotaoCalculadora(
        valor: '=',
        tipo: TipoOperacao.igual,
      ),
      TipoOperacao.ponto: const BotaoCalculadora(
        valor: '.',
        tipo: TipoOperacao.ponto,
      ),
      ..._createNumberButtons(),
    };
  }

  static Map<TipoOperacao, BotaoCalculadora> _createNumberButtons() {
    final numbers = {
      0: TipoOperacao.zero,
      1: TipoOperacao.um,
      2: TipoOperacao.dois,
      3: TipoOperacao.tres,
      4: TipoOperacao.quatro,
      5: TipoOperacao.cinco,
      6: TipoOperacao.seis,
      7: TipoOperacao.sete,
      8: TipoOperacao.oito,
      9: TipoOperacao.nove,
    };

    return {
      for (var entry in numbers.entries)
        entry.value: BotaoCalculadora(
          valor: entry.key.toString(),
          tipo: entry.value,
        )
    };
  }
}