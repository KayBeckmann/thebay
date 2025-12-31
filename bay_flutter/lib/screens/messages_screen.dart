import 'package:bay_client/bay_client.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../main.dart' show messageService, pgpKeyService;
import '../services/message_service.dart';
import '../services/pgp_key_service.dart';

/// Öffnet den Dialog zum Verfassen einer Nachricht.
/// Kann von anderen Screens aufgerufen werden.
void showComposeMessageDialog(
  BuildContext context, {
  int? recipientId,
  String? recipientName,
  int? listingId,
  VoidCallback? onSent,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) => _ComposeMessageSheet(
      messageService: messageService,
      pgpKeyService: pgpKeyService,
      recipientId: recipientId,
      recipientName: recipientName,
      listingId: listingId,
      onSent: () {
        onSent?.call();
        Navigator.pop(context);
      },
      onDraftSaved: () {},
    ),
  );
}

/// Screen für verschlüsselte Nachrichten.
class MessagesScreen extends StatefulWidget {
  final MessageService messageService;
  final PgpKeyService pgpKeyService;
  final VoidCallback? onUnreadCountChanged;

  const MessagesScreen({
    super.key,
    required this.messageService,
    required this.pgpKeyService,
    this.onUnreadCountChanged,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Message> _inbox = [];
  List<Message> _sent = [];
  List<MessageDraft> _drafts = [];

  bool _isLoadingInbox = true;
  bool _isLoadingSent = true;
  bool _isLoadingDrafts = true;

  String? _errorInbox;
  String? _errorSent;
  String? _errorDrafts;

  // Cache für Benutzernamen
  final Map<int, String> _usernameCache = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadInbox();
    _loadSent();
    _loadDrafts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadInbox() async {
    setState(() {
      _isLoadingInbox = true;
      _errorInbox = null;
    });

    try {
      final messages = await widget.messageService.getInbox();
      if (mounted) {
        setState(() {
          _inbox = messages;
          _isLoadingInbox = false;
        });
        // Lade Benutzernamen
        _loadUsernamesForMessages(messages, isSent: false);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorInbox = e.toString();
          _isLoadingInbox = false;
        });
      }
    }
  }

  Future<void> _loadSent() async {
    setState(() {
      _isLoadingSent = true;
      _errorSent = null;
    });

    try {
      final messages = await widget.messageService.getSent();
      if (mounted) {
        setState(() {
          _sent = messages;
          _isLoadingSent = false;
        });
        // Lade Benutzernamen
        _loadUsernamesForMessages(messages, isSent: true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorSent = e.toString();
          _isLoadingSent = false;
        });
      }
    }
  }

  Future<void> _loadDrafts() async {
    setState(() {
      _isLoadingDrafts = true;
      _errorDrafts = null;
    });

    try {
      final drafts = await widget.messageService.getDrafts();
      if (mounted) {
        setState(() {
          _drafts = drafts;
          _isLoadingDrafts = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorDrafts = e.toString();
          _isLoadingDrafts = false;
        });
      }
    }
  }

  Future<void> _loadUsernamesForMessages(
    List<Message> messages, {
    required bool isSent,
  }) async {
    for (final msg in messages) {
      final userId = isSent ? msg.recipientId : msg.senderId;
      if (!_usernameCache.containsKey(userId)) {
        try {
          final username = await widget.messageService.getUsername(userId);
          if (username != null && mounted) {
            setState(() {
              _usernameCache[userId] = username;
            });
          }
        } catch (e) {
          // Ignore
        }
      }
    }
  }

  Future<void> _refresh() async {
    await Future.wait([
      _loadInbox(),
      _loadSent(),
      _loadDrafts(),
    ]);
    widget.onUnreadCountChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.messages),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
            tooltip: l10n.refresh,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.inbox),
                  if (_inbox.where((m) => !m.isRead).isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_inbox.where((m) => !m.isRead).length}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(text: l10n.sent),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(l10n.drafts),
                  if (_drafts.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_drafts.length}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildInboxTab(),
          _buildSentTab(),
          _buildDraftsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showComposeDialog(),
        icon: const Icon(Icons.edit),
        label: Text(l10n.newMessage),
      ),
    );
  }

  Widget _buildInboxTab() {
    if (_isLoadingInbox) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorInbox != null) {
      return _buildErrorState(_errorInbox!, _loadInbox);
    }

    if (_inbox.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return _buildEmptyState(
        Icons.inbox_outlined,
        l10n.noMessages,
        l10n.inboxEmpty,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadInbox,
      child: ListView.builder(
        itemCount: _inbox.length,
        itemBuilder: (context, index) {
          final message = _inbox[index];
          final senderName = _usernameCache[message.senderId] ??
              'Benutzer #${message.senderId}';
          return _MessageListTile(
            message: message,
            otherUserName: senderName,
            isInbox: true,
            onTap: () => _openMessage(message),
            onDelete: () => _deleteMessage(message),
          );
        },
      ),
    );
  }

  Widget _buildSentTab() {
    if (_isLoadingSent) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorSent != null) {
      return _buildErrorState(_errorSent!, _loadSent);
    }

    if (_sent.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return _buildEmptyState(
        Icons.send_outlined,
        l10n.noSentMessages,
        l10n.noSentMessagesYet,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadSent,
      child: ListView.builder(
        itemCount: _sent.length,
        itemBuilder: (context, index) {
          final message = _sent[index];
          final recipientName = _usernameCache[message.recipientId] ??
              'Benutzer #${message.recipientId}';
          return _MessageListTile(
            message: message,
            otherUserName: recipientName,
            isInbox: false,
            onTap: () => _openMessage(message),
            onDelete: () => _deleteMessage(message),
          );
        },
      ),
    );
  }

  Widget _buildDraftsTab() {
    if (_isLoadingDrafts) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorDrafts != null) {
      return _buildErrorState(_errorDrafts!, _loadDrafts);
    }

    if (_drafts.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return _buildEmptyState(
        Icons.drafts_outlined,
        l10n.noDrafts,
        l10n.noSavedDrafts,
      );
    }

    return RefreshIndicator(
      onRefresh: _loadDrafts,
      child: ListView.builder(
        itemCount: _drafts.length,
        itemBuilder: (context, index) {
          final draft = _drafts[index];
          return _DraftListTile(
            draft: draft,
            onTap: () => _openDraft(draft),
            onDelete: () => _deleteDraft(draft),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(IconData icon, String title, String subtitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error, VoidCallback onRetry) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              l10n.errorLoading,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.retry),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openMessage(Message message) async {
    // Markiere als gelesen
    if (!message.isRead) {
      await widget.messageService.markAsRead(message.id!);
      widget.onUnreadCountChanged?.call();
    }

    if (!mounted) return;

    // Zeige Nachricht-Detail
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _MessageDetailScreen(
          message: message,
          messageService: widget.messageService,
          pgpKeyService: widget.pgpKeyService,
          otherUserName: message.senderId == message.recipientId
              ? 'Du'
              : _usernameCache[message.senderId] ??
                  'Benutzer #${message.senderId}',
          onReply: (recipientId, recipientName) {
            _showComposeDialog(
              recipientId: recipientId,
              recipientName: recipientName,
              parentMessageId: message.id,
            );
          },
        ),
      ),
    );

    // Aktualisiere Listen
    _loadInbox();
  }

  Future<void> _deleteMessage(Message message) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteMessage),
        content: Text(l10n.actionCannotBeUndone),
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

    if (confirmed == true) {
      await widget.messageService.deleteMessage(message.id!);
      _refresh();
    }
  }

  Future<void> _openDraft(MessageDraft draft) async {
    final decrypted = await widget.messageService.getDraftById(draft.id!);
    if (!mounted) return;

    _showComposeDialog(
      recipientId: draft.recipientId,
      recipientName: draft.recipientUsername,
      existingDraftId: draft.id,
      initialSubject: decrypted?.subject,
      initialContent: decrypted?.content,
      listingId: draft.listingId,
    );
  }

  Future<void> _deleteDraft(MessageDraft draft) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteDraft),
        content: Text(l10n.actionCannotBeUndone),
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

    if (confirmed == true) {
      await widget.messageService.deleteDraft(draft.id!);
      _loadDrafts();
    }
  }

  void _showComposeDialog({
    int? recipientId,
    String? recipientName,
    int? parentMessageId,
    int? existingDraftId,
    String? initialSubject,
    String? initialContent,
    int? listingId,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _ComposeMessageSheet(
        messageService: widget.messageService,
        pgpKeyService: widget.pgpKeyService,
        recipientId: recipientId,
        recipientName: recipientName,
        parentMessageId: parentMessageId,
        existingDraftId: existingDraftId,
        initialSubject: initialSubject,
        initialContent: initialContent,
        listingId: listingId,
        onSent: () {
          _refresh();
          Navigator.pop(context);
        },
        onDraftSaved: () {
          _loadDrafts();
        },
      ),
    );
  }
}

/// ListTile für eine Nachricht.
class _MessageListTile extends StatelessWidget {
  final Message message;
  final String otherUserName;
  final bool isInbox;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _MessageListTile({
    required this.message,
    required this.otherUserName,
    required this.isInbox,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = isInbox && !message.isRead;

    return Dismissible(
      key: Key('message_${message.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isUnread
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Icon(
            isInbox ? Icons.person : Icons.send,
            color: isUnread
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        title: Text(
          isInbox
              ? AppLocalizations.of(context)!.from(otherUserName)
              : AppLocalizations.of(context)!.to(otherUserName),
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Text(
          _formatDate(context, message.createdAt),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: isUnread
            ? Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return l10n.yesterday;
    } else if (diff.inDays < 7) {
      final days = [
        l10n.monday,
        l10n.tuesday,
        l10n.wednesday,
        l10n.thursday,
        l10n.friday,
        l10n.saturday,
        l10n.sunday
      ];
      return days[date.weekday - 1];
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }
}

/// ListTile für einen Entwurf.
class _DraftListTile extends StatelessWidget {
  final MessageDraft draft;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _DraftListTile({
    required this.draft,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('draft_${draft.id}'),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          Icons.delete,
          color: Theme.of(context).colorScheme.onError,
        ),
      ),
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(
            Icons.edit_note,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        title: Text(
          draft.recipientUsername ?? AppLocalizations.of(context)!.noRecipient,
          style: const TextStyle(fontStyle: FontStyle.italic),
        ),
        subtitle: Text(
          AppLocalizations.of(context)!.lastEdited(_formatDate(draft.updatedAt)),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// Screen für Nachricht-Details.
class _MessageDetailScreen extends StatefulWidget {
  final Message message;
  final MessageService messageService;
  final PgpKeyService pgpKeyService;
  final String otherUserName;
  final void Function(int recipientId, String recipientName) onReply;

  const _MessageDetailScreen({
    required this.message,
    required this.messageService,
    required this.pgpKeyService,
    required this.otherUserName,
    required this.onReply,
  });

  @override
  State<_MessageDetailScreen> createState() => _MessageDetailScreenState();
}

class _MessageDetailScreenState extends State<_MessageDetailScreen> {
  DecryptedMessage? _decrypted;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _decryptMessage();
  }

  Future<void> _decryptMessage() async {
    try {
      final decrypted =
          await widget.messageService.decryptMessage(widget.message);
      if (mounted) {
        setState(() {
          _decrypted = decrypted;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.otherUserName),
        actions: [
          IconButton(
            icon: const Icon(Icons.reply),
            onPressed: () {
              Navigator.pop(context);
              widget.onReply(
                widget.message.senderId,
                widget.otherUserName,
              );
            },
            tooltip: AppLocalizations.of(context)!.reply,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    final l10n = AppLocalizations.of(context)!;
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(l10n.decryptingMessage),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(l10n.decryptionFailed),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppLocalizations.of(context)!.endToEndEncrypted,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.fromUser(widget.otherUserName),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppLocalizations.of(context)!.dateLabel(_formatDate(widget.message.createdAt)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Betreff
          Text(
            AppLocalizations.of(context)!.subject,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 4),
          Text(
            _decrypted?.subject ?? AppLocalizations.of(context)!.noSubject,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const Divider(height: 32),

          // Inhalt
          Text(
            AppLocalizations.of(context)!.message,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            _decrypted?.content ?? AppLocalizations.of(context)!.noContent,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}.${date.month}.${date.year} um ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}

/// Bottom Sheet zum Verfassen einer Nachricht.
class _ComposeMessageSheet extends StatefulWidget {
  final MessageService messageService;
  final PgpKeyService pgpKeyService;
  final int? recipientId;
  final String? recipientName;
  final int? parentMessageId;
  final int? existingDraftId;
  final String? initialSubject;
  final String? initialContent;
  final int? listingId;
  final VoidCallback onSent;
  final VoidCallback onDraftSaved;

  const _ComposeMessageSheet({
    required this.messageService,
    required this.pgpKeyService,
    this.recipientId,
    this.recipientName,
    this.parentMessageId,
    this.existingDraftId,
    this.initialSubject,
    this.initialContent,
    this.listingId,
    required this.onSent,
    required this.onDraftSaved,
  });

  @override
  State<_ComposeMessageSheet> createState() => _ComposeMessageSheetState();
}

class _ComposeMessageSheetState extends State<_ComposeMessageSheet> {
  final _recipientController = TextEditingController();
  final _subjectController = TextEditingController();
  final _contentController = TextEditingController();

  int? _recipientId;
  String? _recipientName;
  bool _isSending = false;
  bool _isSavingDraft = false;
  String? _error;
  bool _recipientHasKey = false;
  bool _isCheckingRecipient = false;

  @override
  void initState() {
    super.initState();
    _recipientId = widget.recipientId;
    _recipientName = widget.recipientName;
    _recipientController.text = widget.recipientName ?? '';
    _subjectController.text = widget.initialSubject ?? '';
    _contentController.text = widget.initialContent ?? '';

    if (_recipientId != null) {
      _checkRecipientKey();
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _subjectController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _checkRecipientKey() async {
    if (_recipientId == null) return;

    setState(() => _isCheckingRecipient = true);

    try {
      final hasKey = await widget.messageService.recipientHasKey(_recipientId!);
      if (mounted) {
        setState(() {
          _recipientHasKey = hasKey;
          _isCheckingRecipient = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isCheckingRecipient = false;
        });
      }
    }
  }

  Future<void> _searchRecipient() async {
    final username = _recipientController.text.trim();
    if (username.isEmpty) {
      setState(() {
        _recipientId = null;
        _recipientHasKey = false;
      });
      return;
    }

    setState(() {
      _isCheckingRecipient = true;
      _error = null;
    });

    try {
      print('[ComposeMessage] Suche Empfänger: $username');
      final userKey = await widget.messageService.findUserByUsername(username);
      if (userKey != null) {
        print('[ComposeMessage] Empfänger gefunden: userId=${userKey.userId}');
        setState(() {
          _recipientId = userKey.userId;
          _recipientName = username;
          _recipientHasKey = true;
          _isCheckingRecipient = false;
        });
      } else {
        print('[ComposeMessage] Empfänger nicht gefunden oder hat keinen Key');
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          _recipientId = null;
          _recipientHasKey = false;
          _error = l10n.userNotFoundOrNoKey(username);
          _isCheckingRecipient = false;
        });
      }
    } catch (e) {
      print('[ComposeMessage] Fehler bei der Suche: $e');
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _error = l10n.searchError(e.toString());
        _isCheckingRecipient = false;
      });
    }
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context)!;
    if (_recipientId == null) {
      setState(() => _error = l10n.pleaseSelectRecipient);
      return;
    }

    if (!_recipientHasKey) {
      setState(() => _error = l10n.recipientNotVerified);
      return;
    }

    if (_subjectController.text.trim().isEmpty) {
      setState(() => _error = l10n.pleaseEnterSubject);
      return;
    }

    if (_contentController.text.trim().isEmpty) {
      setState(() => _error = l10n.pleaseEnterMessage);
      return;
    }

    setState(() {
      _isSending = true;
      _error = null;
    });

    try {
      await widget.messageService.sendMessage(
        recipientId: _recipientId!,
        subject: _subjectController.text.trim(),
        content: _contentController.text.trim(),
        listingId: widget.listingId,
        parentMessageId: widget.parentMessageId,
      );

      // Lösche Entwurf falls vorhanden
      if (widget.existingDraftId != null) {
        await widget.messageService.deleteDraft(widget.existingDraftId!);
      }

      widget.onSent();
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _error = l10n.errorSending(e.toString());
        _isSending = false;
      });
    }
  }

  Future<void> _saveDraft() async {
    setState(() {
      _isSavingDraft = true;
      _error = null;
    });

    try {
      await widget.messageService.saveDraft(
        recipientId: _recipientId,
        recipientUsername: _recipientName ?? _recipientController.text.trim(),
        subject: _subjectController.text.trim(),
        content: _contentController.text.trim(),
        listingId: widget.listingId,
        existingDraftId: widget.existingDraftId,
      );

      widget.onDraftSaved();

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.draftSaved)),
        );
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      setState(() {
        _error = l10n.errorSavingDraft(e.toString());
      });
    } finally {
      setState(() => _isSavingDraft = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    // Erste Zeile: Schließen + Titel
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.existingDraftId != null
                                ? AppLocalizations.of(context)!.editDraft
                                : AppLocalizations.of(context)!.newMessage,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Zweite Zeile: Buttons
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: [
                        if (_isSavingDraft)
                          const SizedBox(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                            ),
                          )
                        else
                          TextButton.icon(
                            onPressed: _saveDraft,
                            icon: const Icon(Icons.save_outlined),
                            label: Text(AppLocalizations.of(context)!.draft),
                            style: TextButton.styleFrom(
                              minimumSize: const Size(0, 44),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        FilledButton.icon(
                          onPressed: _isSending ? null : _send,
                          icon: _isSending
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.send),
                          label: Text(AppLocalizations.of(context)!.send),
                          style: FilledButton.styleFrom(
                            minimumSize: const Size(0, 44),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Error message
              if (_error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Theme.of(context).colorScheme.errorContainer,
                  child: Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),

              // Form
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    // Empfänger
                    TextField(
                      controller: _recipientController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.recipient,
                        hintText: AppLocalizations.of(context)!.enterUsername,
                        prefixIcon: const Icon(Icons.person),
                        suffixIcon: _isCheckingRecipient
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2),
                                ),
                              )
                            : _recipientHasKey
                                ? Icon(
                                    Icons.check_circle,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )
                                : IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: _searchRecipient,
                                  ),
                        border: const OutlineInputBorder(),
                        enabled: widget.recipientId == null,
                      ),
                      onSubmitted: (_) => _searchRecipient(),
                    ),
                    if (_recipientHasKey) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: 14,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)!.messageWillBeEncrypted,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ] else if (!_isCheckingRecipient &&
                        _recipientController.text.isNotEmpty &&
                        widget.recipientId == null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 14,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)!.clickToVerifyRecipient,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),

                    // Betreff
                    TextField(
                      controller: _subjectController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.subject,
                        prefixIcon: const Icon(Icons.subject),
                        border: const OutlineInputBorder(),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),

                    // Nachricht
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.message,
                        alignLabelWithHint: true,
                        border: const OutlineInputBorder(),
                      ),
                      maxLines: 10,
                      minLines: 5,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
