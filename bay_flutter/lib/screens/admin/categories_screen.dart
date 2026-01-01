import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';

/// Admin screen for managing categories.
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final categories = await client.category.getAll();
      if (mounted) {
        setState(() {
          _categories = categories;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  List<Category> _getRootCategories() {
    return _categories.where((c) => c.parentId == null).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  List<Category> _getSubcategories(int parentId) {
    return _categories.where((c) => c.parentId == parentId).toList()
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.manageCategories),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryDialog(null, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(l10n.errorLoading(_error!)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _loadCategories,
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (_categories.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.category_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              l10n.noCategories,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.createFirstCategory,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCategories,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _getRootCategories().length,
        itemBuilder: (context, index) {
          final category = _getRootCategories()[index];
          return _buildCategoryCard(category);
        },
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    final subcategories = _getSubcategories(category.id!);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        leading: Icon(
          category.isActive ? Icons.folder : Icons.folder_off_outlined,
          color: category.isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        title: Text(
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: category.isActive ? null : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        subtitle: Text(
          l10n.subcategoriesCount(subcategories.length, category.sortOrder),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showCategoryDialog(null, category.id),
              tooltip: l10n.addSubcategory,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showCategoryDialog(category, null),
              tooltip: l10n.edit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(category),
              tooltip: l10n.delete,
            ),
          ],
        ),
        children: [
          if (subcategories.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.noSubcategories,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            )
          else
            ...subcategories.map((sub) => _buildSubcategoryTile(sub)),
        ],
      ),
    );
  }

  Widget _buildSubcategoryTile(Category category) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: Icon(
        category.isActive ? Icons.folder_open : Icons.folder_off_outlined,
        color: category.isActive
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(
        category.name,
        style: TextStyle(
          color: category.isActive ? null : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      subtitle: Text(l10n.sortingLabel(category.sortOrder)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: () => _showCategoryDialog(category, category.parentId),
            tooltip: l10n.edit,
          ),
          IconButton(
            icon: const Icon(Icons.delete, size: 20),
            onPressed: () => _confirmDelete(category),
            tooltip: l10n.delete,
          ),
        ],
      ),
    );
  }

  Future<void> _showCategoryDialog(Category? category, int? parentId) async {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = category != null;
    final nameController = TextEditingController(text: category?.name ?? '');
    final sortOrderController =
        TextEditingController(text: (category?.sortOrder ?? 0).toString());
    bool isActive = category?.isActive ?? true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? l10n.editCategory : l10n.newCategory),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.categoryName,
                  hintText: l10n.enterCategoryName,
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: sortOrderController,
                decoration: InputDecoration(
                  labelText: l10n.sorting,
                  hintText: l10n.sortingHint,
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: Text(l10n.active),
                subtitle: Text(l10n.categoryShownToUsers),
                value: isActive,
                onChanged: (value) => setDialogState(() => isActive = value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(isEditing ? l10n.save : l10n.create),
            ),
          ],
        ),
      ),
    );

    if (result == true && mounted) {
      final name = nameController.text.trim();
      final sortOrder = int.tryParse(sortOrderController.text) ?? 0;

      if (name.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.nameRequired)),
        );
        return;
      }

      try {
        if (isEditing) {
          await client.category.update(
            category.id!,
            name,
            category.parentId,
            sortOrder,
            isActive,
          );
        } else {
          await client.category.create(name, parentId, sortOrder);
        }
        _loadCategories();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorLoading(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _confirmDelete(Category category) async {
    final l10n = AppLocalizations.of(context)!;
    final subcategories = _getSubcategories(category.id!);
    final hasSubcategories = subcategories.isNotEmpty;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteCategory),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.confirmDeleteCategoryWithName(category.name)),
            if (hasSubcategories) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning,
                        color: Theme.of(context).colorScheme.onErrorContainer),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        l10n.categoryHasSubcategories(subcategories.length),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await client.category.delete(category.id!);
        _loadCategories();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorDeleting(e.toString()))),
          );
        }
      }
    }
  }
}
