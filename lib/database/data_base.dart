import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item_colecao.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  DatabaseHelper._init();
  static const String _chaveItens = 'itens';

  Future<List<ItemColecao>> listarItens() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dados = prefs.getString(_chaveItens);

    if (dados == null) {
      return [];
    }

    final List listaJson = jsonDecode(dados);

    return listaJson.map((item) {
      return ItemColecao.fromMap(Map<String, dynamic>.from(item));
    }).toList();
  }

  Future<int> inserirItem(ItemColecao item) async {
    final prefs = await SharedPreferences.getInstance();
    final itens = await listarItens();
    final novoItem = ItemColecao(
      id: DateTime.now().millisecondsSinceEpoch,
      nome: item.nome,
      categoria: item.categoria,
      status: item.status,
      raridade: item.raridade,
      conservacao: item.conservacao,
      valorPago: item.valorPago,
      valorEstimado: item.valorEstimado,
      localizacao: item.localizacao,
      repetido: item.repetido,
    );

    itens.add(novoItem);
    final listaMap = itens.map((item) => item.toMap()).toList();
    await prefs.setString(_chaveItens, jsonEncode(listaMap));
    return novoItem.id!;
  }

  Future<int> editarItem(ItemColecao itemAtualizado) async {
    final prefs = await SharedPreferences.getInstance();
    final itens = await listarItens();
    final index = itens.indexWhere((item) => item.id == itemAtualizado.id);
    if (index == -1) {
      return 0;
    }

    itens[index] = itemAtualizado;

    final listaMap = itens.map((item) => item.toMap()).toList();
    await prefs.setString(_chaveItens, jsonEncode(listaMap));
    return 1;
  }

  Future<int> excluirItem(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final itens = await listarItens();
    final quantidadeAntes = itens.length;
    itens.removeWhere((item) => item.id == id);
    final listaMap = itens.map((item) => item.toMap()).toList();
    await prefs.setString(_chaveItens, jsonEncode(listaMap));
    return (quantidadeAntes - itens.length);
  }

  Future<int> contarItens() async {
    final itens = await listarItens();
    return itens.length;
  }
}