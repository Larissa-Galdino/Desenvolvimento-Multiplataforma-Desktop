class ItemColecao {

  final int? id;
  final String nome;
  final String categoria;
  final String status;
  final String raridade;
  final String conservacao;
  final double? valorPago;
  final double? valorEstimado;
  final String? localizacao;
  final bool repetido;

  ItemColecao({
    required this.id,
    required this.nome,
    required this.categoria,
    required this.status,
    required this.raridade,
    required this.conservacao,
    this.valorPago,
    this.valorEstimado,
    this.localizacao,
    this.repetido = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'categoria': categoria,
      'status': status,
      'raridade': raridade,
      'conservacao': conservacao,
      'valorPago': valorPago,
      'valorEstimado': valorEstimado,
      'localizacao': localizacao,
      'repetido': repetido,
    };
  }
  factory ItemColecao.fromMap(Map<String, dynamic> map) {
    return ItemColecao(
      id: map['id'],
      nome: map['nome'],
      categoria: map['categoria'],
      status: map['status'],
      raridade: map['raridade'],
      conservacao: map['conservacao'],
      valorPago: map['valorPago'],
      valorEstimado: map['valorEstimado'],
      localizacao: map['localizacao'],
      repetido: map['repetido'],
    );
  }
}