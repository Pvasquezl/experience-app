import 'package:experience_app/features/admin/products/domain/product_admin_entity.dart';
import 'package:experience_app/features/admin/products/presentation/state/products_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductFormView extends ConsumerStatefulWidget {
  const ProductFormView({super.key, this.product});

  /// Null means create mode; non-null means edit mode.
  final ProductAdminEntity? product;

  @override
  ConsumerState<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends ConsumerState<ProductFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _priceController;
  late final TextEditingController _quantityController;
  late final TextEditingController _imageController;
  late bool _available;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _priceController = TextEditingController(
      text: widget.product != null
          ? widget.product!.price.toStringAsFixed(2)
          : '',
    );
    _quantityController = TextEditingController(
      text: widget.product != null ? widget.product!.quantity.toString() : '',
    );
    _imageController = TextEditingController(text: widget.product?.image ?? '');
    _available = widget.product?.available ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(productsNotifierProvider.notifier);

    if (_isEditing) {
      notifier.updateProduct(
        widget.product!.copyWith(
          name: _nameController.text.trim(),
          price: double.parse(_priceController.text.trim()),
          available: _available,
          quantity: int.parse(_quantityController.text.trim()),
          image: _imageController.text.trim(),
        ),
      );
    } else {
      final newId = DateTime.now().millisecondsSinceEpoch.toString();
      notifier.addProduct(
        ProductAdminEntity(
          id: newId,
          name: _nameController.text.trim(),
          price: double.parse(_priceController.text.trim()),
          available: _available,
          quantity: int.parse(_quantityController.text.trim()),
          image: _imageController.text.trim(),
        ),
      );
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit Product' : 'New Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_isEditing) ...[
                TextFormField(
                  initialValue: widget.product!.id,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'ID',
                    border: OutlineInputBorder(),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  prefixText: '\$ ',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Price is required';
                  if (double.tryParse(v.trim()) == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Quantity is required';
                  }
                  if (int.tryParse(v.trim()) == null) {
                    return 'Enter a valid integer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              IconButton(
                icon: const Icon(Icons.image_outlined),
                iconSize: 40.0,
                color: Colors.blue,
                tooltip: 'Seleccionar imagen',
                onPressed: () {
                  // Lógica para seleccionar la imagen
                  //seleccionarImagen();
                },
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                title: const Text('Available'),
                value: _available,
                onChanged: (v) => setState(() => _available = v),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _submit,
                child: Text(_isEditing ? 'Save Changes' : 'Create Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
