import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../main.dart';
import '../../utils/date_formatter.dart';

/// Admin screen for managing news articles.
class NewsManagementScreen extends StatefulWidget {
  const NewsManagementScreen({super.key});

  @override
  State<NewsManagementScreen> createState() => _NewsManagementScreenState();
}

class _NewsManagementScreenState extends State<NewsManagementScreen> {
  List<News> _news = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final news = await client.news.getAll();
      if (mounted) {
        setState(() {
          _news = news;
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

  bool _isExpired(News news) {
    if (news.expiresAt == null) return false;
    return news.expiresAt!.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.newsManagementScreen),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: _deleteExpired,
            tooltip: l10n.deleteExpired,
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewsDialog(null),
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
              onPressed: _loadNews,
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }

    if (_news.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.newspaper_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              l10n.noNewsItems,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.createFirstNews,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadNews,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _news.length,
        itemBuilder: (context, index) {
          final news = _news[index];
          return _buildNewsCard(news);
        },
      ),
    );
  }

  Widget _buildNewsCard(News news) {
    final isExpired = _isExpired(news);
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  news.isPublished ? Icons.public : Icons.public_off,
                  color: news.isPublished
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    news.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                if (!news.isPublished)
                  _buildStatusChip(context, l10n.newsStatusDraft, Colors.grey),
                if (news.isPublished && !isExpired)
                  _buildStatusChip(context, l10n.newsStatusPublished, Colors.green),
                if (isExpired)
                  _buildStatusChip(context, l10n.newsStatusExpired, Colors.red),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              news.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  l10n.createdLabel(DateFormatter.formatDate(context,news.createdAt)),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(width: 16),
                if (news.expiresAt != null) ...[
                  Icon(Icons.timer,
                      size: 14,
                      color: isExpired
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    l10n.expiresLabel(news.expiresAt != null ? DateFormatter.formatDate(context, news.expiresAt!) : l10n.noExpiryDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isExpired
                              ? Theme.of(context).colorScheme.error
                              : null,
                        ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _showNewsDialog(news),
                  icon: const Icon(Icons.edit, size: 18),
                  label: Text(l10n.edit),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _confirmDelete(news),
                  icon: Icon(Icons.delete, size: 18, color: Theme.of(context).colorScheme.error),
                  label: Text(l10n.delete, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
      ),
    );
  }

  Future<void> _showNewsDialog(News? news) async {
    final l10n = AppLocalizations.of(context)!;
    final isEditing = news != null;
    final titleController = TextEditingController(text: news?.title ?? '');
    final contentController = TextEditingController(text: news?.content ?? '');
    final lifetimeController = TextEditingController(text: '14');
    bool isPublished = news?.isPublished ?? false;
    DateTime? expiresAt = news?.expiresAt;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? l10n.editNewsItem : l10n.createNewsItem),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: l10n.newsTitle,
                    ),
                    autofocus: true,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      labelText: l10n.newsContent,
                      hintText: l10n.markdownSupported,
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: 16),
                  if (!isEditing)
                    TextField(
                      controller: lifetimeController,
                      decoration: InputDecoration(
                        labelText: l10n.lifetimeDays,
                        hintText: l10n.defaultLifetimeDays,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  if (isEditing)
                    ListTile(
                      title: Text(l10n.expiryDate),
                      subtitle: Text(expiresAt != null ? DateFormatter.formatDate(context, expiresAt!) : l10n.noExpiryDate),
                      trailing: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: expiresAt ?? DateTime.now().add(const Duration(days: 14)),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                          );
                          if (date != null) {
                            setDialogState(() => expiresAt = date);
                          }
                        },
                      ),
                    ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(l10n.publish),
                    subtitle: Text(l10n.publishNewsMessage),
                    value: isPublished,
                    onChanged: (value) => setDialogState(() => isPublished = value),
                  ),
                ],
              ),
            ),
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
      final title = titleController.text.trim();
      final content = contentController.text.trim();

      if (title.isEmpty || content.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.titleContentRequired)),
        );
        return;
      }

      try {
        if (isEditing) {
          await client.news.update(
            id: news.id!,
            title: title,
            content: content,
            isPublished: isPublished,
            expiresAt: expiresAt,
          );
        } else {
          final lifetime = int.tryParse(lifetimeController.text);
          await client.news.create(
            title: title,
            content: content,
            publish: isPublished,
            lifetimeDays: lifetime,
          );
        }
        _loadNews();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorLoading(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _confirmDelete(News news) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteNews),
        content: Text(l10n.confirmDeleteNewsWithTitle(news.title)),
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
        await client.news.delete(news.id!);
        _loadNews();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorDeleting(e.toString()))),
          );
        }
      }
    }
  }

  Future<void> _deleteExpired() async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteExpiredNews),
        content: Text(l10n.confirmDeleteExpiredNews),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final count = await client.news.deleteExpired();
        _loadNews();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.expiredNewsDeleted(count))),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.errorLoading(e.toString()))),
          );
        }
      }
    }
  }
}
