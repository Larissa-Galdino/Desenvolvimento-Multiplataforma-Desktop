import 'package:flutter/material.dart';
import '../models/item_colecao.dart';
import '../database/data_base.dart';

class FormularioScreen extends StatefulWidget {
  final ItemColecao? item;
  const FormularioScreen({super.key, this.item});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final categoriaController = TextEditingController();
  final valorPagoController = TextEditingController();
  final valorEstimadoController = TextEditingController();
  final localizacaoController = TextEditingController();

  String? _status;
  String? _raridade;
  String? _conservacao;
  bool _repetido = false;

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      nomeController.text = widget.item!.nome;
      categoriaController.text = widget.item!.categoria;
      valorPagoController.text = widget.item!.valorPago?.toString() ?? '';
      valorEstimadoController.text = widget.item!.valorEstimado?.toString() ?? '';
      localizacaoController.text = widget.item!.localizacao ?? '';
      _status = widget.item!.status;
      _raridade = widget.item!.raridade;
      _conservacao = widget.item!.conservacao;
      _repetido = widget.item!.repetido;
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    categoriaController.dispose();
    valorPagoController.dispose();
    valorEstimadoController.dispose();
    localizacaoController.dispose();
    super.dispose();
  }

  Future<void> salvarItem() async {
    if (formKey.currentState!.validate()) {
      final item = ItemColecao(
        id: widget.item?.id,
        nome: nomeController.text,
        categoria: categoriaController.text,
        status: _status ?? '',
        raridade: _raridade ?? '',
        conservacao: _conservacao ?? '',
        valorPago: double.tryParse(valorPagoController.text),
        valorEstimado: double.tryParse(valorEstimadoController.text),
        localizacao: localizacaoController.text,
        repetido: _repetido,
      );

      if (widget.item == null) {
        await DatabaseHelper.instance.inserirItem(item);
      } else {
        await DatabaseHelper.instance.editarItem(item);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.item == null
                ? 'Item cadastrado com sucesso!'
                : 'Item editado com sucesso!',
          ),
        ),
      );
      Navigator.pop(context);
    }
  }

  Widget campoTexto({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType teclado = TextInputType.text,
    bool obrigatorio = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: teclado,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (obrigatorio && (value == null || value.trim().isEmpty)) {
          return 'Preencha o campo $label';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final editando = widget.item != null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.label, color: Colors.white),
            const SizedBox(width: 8),
            Text(editando ? 'Editar Item' : 'Novo Item'),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              campoTexto(
                controller: nomeController,
                label: 'Nome do item',
                icon: Icons.label,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: 'Jogos',
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Categoria',
                  prefixIcon: Icon(Icons.videogame_asset),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              campoTexto(
                controller: valorPagoController,
                label: 'Valor Pago (R\$)',
                icon: Icons.payments,
                teclado: TextInputType.number,
                obrigatorio: false,
              ),
              const SizedBox(height: 12),
              campoTexto(
                controller: valorEstimadoController,
                label: 'Valor Estimado (R\$)',
                icon: Icons.trending_up,
                teclado: TextInputType.number,
                obrigatorio: false,
              ),
              const SizedBox(height: 12),
              campoTexto(
                controller: localizacaoController,
                label: 'Localização',
                icon: Icons.location_on,
                obrigatorio: false,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.flag),
                  border: OutlineInputBorder(),
                ),
                items: ['Na Coleção', 'Lista de Desejos', 'Emprestado', 'Vendido', 'Trocado']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (valor) => setState(() => _status = valor!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _raridade,
                decoration: const InputDecoration(
                  labelText: 'Raridade',
                  prefixIcon: Icon(Icons.star),
                  border: OutlineInputBorder(),
                ),
                items: ['Comum', 'Incomum', 'Raro', 'Muito Raro', 'Único']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (valor) => setState(() => _raridade = valor!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _conservacao,
                decoration: const InputDecoration(
                  labelText: 'Conservação',
                  prefixIcon: Icon(Icons.shield),
                  border: OutlineInputBorder(),
                ),
                items: ['Ótimo', 'Bom', 'Regular', 'Ruim', 'Danificado']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (valor) => setState(() => _conservacao = valor!),
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                title: const Text('Item repetido?'),
                value: _repetido,
                activeColor: Colors.indigo,
                onChanged: (valor) => setState(() => _repetido = valor),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: salvarItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.save),
                  label: Text(editando ? 'Salvar alterações' : 'Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}