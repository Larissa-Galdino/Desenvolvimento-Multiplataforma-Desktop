import 'package:flutter/material.dart';
import '../models/item_colecao.dart';
import '../database/data_base.dart';
import 'formulario_screen.dart';
import 'painel_screen.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  final db = DatabaseHelper.instance;
  List<ItemColecao> itens = [];
  String _busca = '';
  String _filtroStatus = '';
  String _filtroRaridade = '';

  List<ItemColecao> get itensFiltrados {
    return itens.where((item) {
      final buscaOk = _busca.isEmpty || item.nome.toLowerCase().contains(_busca.toLowerCase());
      final statusOk = _filtroStatus.isEmpty || item.status == _filtroStatus;
      final raridadeOk = _filtroRaridade.isEmpty || item.raridade == _filtroRaridade;
      return buscaOk && statusOk && raridadeOk;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _carregarItens();
  }

  Future<void> _carregarItens() async {
    final itensCarregados = await db.listarItens();
    setState(() {
      itens = itensCarregados;
    });
  }

  Future<void> _excluirItem(int id) async {
    await db.excluirItem(id);
    await _carregarItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.gamepad, color: Colors.white),
            SizedBox(width: 9),
            Text('Coleção de Jogos', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PainelScreen(itens: itens),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (valor) {
              setState(() {
                if (valor.startsWith('status:')) {
                  final v = valor.substring(7);
                  _filtroStatus = _filtroStatus == v ? '' : v;
                } else if (valor.startsWith('raridade:')) {
                  final v = valor.substring(9);
                  _filtroRaridade = _filtroRaridade == v ? '' : v;
                }
              });
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'status:Na Coleção', child: Text('Status: Na Coleção')),
              const PopupMenuItem(value: 'status:Lista de Desejos', child: Text('Status: Lista de Desejos')),
              const PopupMenuItem(value: 'status:Emprestado', child: Text('Status: Emprestado')),
              const PopupMenuItem(value: 'status:Vendido', child: Text('Status: Vendido')),
              const PopupMenuItem(value: 'status:Trocado', child: Text('Status: Trocado')),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'raridade:Comum', child: Text('Raridade: Comum')),
              const PopupMenuItem(value: 'raridade:Raro', child: Text('Raridade: Raro')),
              const PopupMenuItem(value: 'raridade:Muito Raro', child: Text('Raridade: Muito Raro')),
              const PopupMenuItem(value: 'raridade:Único', child: Text('Raridade: Único')),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar item...',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (valor) {
                setState(() {
                  _busca = valor;
                });
              },
            ),
          ),
        ),
      ),
      body: itensFiltrados.isEmpty
          ? const Center(
              child: Text('Nenhum item cadastrado ainda.'),
            )
          : ListView.builder(
              itemCount: itensFiltrados.length,
              itemBuilder: (context, index) {
                final item = itensFiltrados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: Text(item.nome),
                    subtitle: Text('${item.categoria} • ${item.status} • R\$ ${item.valorEstimado?.toStringAsFixed(2) ?? '0,00'} • ${item.raridade} • ${item.conservacao} • ${item.localizacao} • ${item.repetido}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormularioScreen(item: item),
                              ),
                            );
                            await _carregarItens();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirmar = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Excluir item', 
                                textAlign: TextAlign.center,),
                                content: Text('Deseja excluir "${item.nome}"?'),

                                actionsAlignment: MainAxisAlignment.center,
                                
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pop(context, true),
                                    child: const Text(
                                      'Excluir',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            );
                            if (confirmar == true) {
                              await _excluirItem(item.id!);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioScreen(),
            ),
          );
          await _carregarItens();
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo Item'),
      ),
    );
  }
}