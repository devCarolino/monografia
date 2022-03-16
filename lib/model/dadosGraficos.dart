import 'package:charts_flutter/flutter.dart' as charts;

class DadosVenda{
  final int ano;
  final int venda;

  DadosVenda(this.ano, this.venda);
}

final data = [
  new DadosVenda(0, 15000),
  new DadosVenda(1, 17000),
  new DadosVenda(2, 19000),
  new DadosVenda(3, 25000),
  new DadosVenda(4, 45000),
  new DadosVenda(5, 12000),
  new DadosVenda(6, 31000),
  new DadosVenda(7, 16000),
  new DadosVenda(8, 12000),
  new DadosVenda(9, 14230),
  new DadosVenda(10, 12300),
  new DadosVenda(11, 13420),
  new DadosVenda(12, 45310),
  new DadosVenda(13, 12310),
  new DadosVenda(14, 41200),
  new DadosVenda(15, 14300),
  new DadosVenda(16, 89300),
  new DadosVenda(17, 13410),
  new DadosVenda(18, 65310),
  new DadosVenda(19, 12900),
];

_pegarSerieDados(){
    List<charts.Series<DadosVenda, int>> series = [
      charts.Series(
          id: "Sales",
          data: data,
          domainFn: (DadosVenda series, _) => series.ano,
          measureFn: (DadosVenda series, _) => series.venda,
          colorFn: (DadosVenda series, _) => charts.MaterialPalette.blue.shadeDefault
      )
    ];
    return series;
}
