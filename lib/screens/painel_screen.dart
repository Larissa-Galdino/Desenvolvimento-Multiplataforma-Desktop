import 'package:flutter/material.dart';
import '../models/item_colecao.dart';

class PainelScreen extends StatelessWidget {
  final List<ItemColecao> itens;

  const PainelScreen({super.key, required this.itens});

  @override
  Widget build(BuildContext context) {
    final totalItens = itens.length;
    final naColecao = itens.where((i) => i.status == 'Na Coleção').length;
    final listaDesejos = itens.where((i) => i.status == 'Lista de Desejos').length;
    final emprestados = itens.where((i) => i.status == 'Emprestado').length;
    final valorPago = itens.fold<double>(0, (s, i) => s + (i.valorPago ?? 0));
    final valorEstimado = itens.fold<double>(0, (s, i) => s + (i.valorEstimado ?? 0));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.dashboard, color: Colors.white),
              SizedBox(width: 9),
              Text('Painel da Coleção', style: TextStyle(color: Colors.white)),
            ],
          ),
          centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCard('Total de itens', '$totalItens', Icons.inventory_2_outlined, Colors.indigo),
            _buildCard('Na Coleção', '$naColecao', Icons.star, Colors.indigo),
            _buildCard('Lista de Desejos', '$listaDesejos', Icons.favorite, Colors.indigo),
            _buildCard('Emprestados', '$emprestados', Icons.swap_horiz, Colors.indigo),
            _buildCard('Valor Investido', 'R\$ ${valorPago.toStringAsFixed(2)}', Icons.payments, Colors.indigo),
            _buildCard('Valor Estimado', 'R\$ ${valorEstimado.toStringAsFixed(2)}', Icons.trending_up, Colors.indigo),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String titulo, String valor, IconData icon, Color cor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: cor, size: 32),
        title: Text(titulo),
        trailing: Text(
          valor,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: cor),
        ),
      ),
    );
  }
}