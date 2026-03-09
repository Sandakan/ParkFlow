import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkflow/models/user/notification_entity.dart';
import 'package:parkflow/presentation/notifiers/notification/notification_notifier.dart';
import 'package:parkflow/utils/constants/app_colors.dart';
import 'package:parkflow/utils/extensions/app_localizations_extension.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          l10n.notifications,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          state.when(
            data: (notifications) {
              final hasUnread = notifications.any((n) => n.readAt == null);
              if (!hasUnread) return const SizedBox.shrink();
              
              return TextButton(
                onPressed: () => ref.read(notificationProvider.notifier).markAllAsRead(),
                child: Text(
                  l10n.markAllAsRead,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, _) => const SizedBox.shrink(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: state.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 64,
                    color: AppColors.textSecondary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noNotifications,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              // Refresh is handled by the provider watch
              ref.invalidate(notificationProvider);
            },
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final isRead = notification.readAt != null;

                return GestureDetector(
                  onTap: () {
                    if (!isRead) {
                      ref.read(notificationProvider.notifier).markAsRead(notification.id);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isRead ? AppColors.white : AppColors.primary.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isRead ? AppColors.outlineVariant : AppColors.primary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: _getTypeColor(notification.type).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getTypeIcon(notification.type),
                            color: _getTypeColor(notification.type),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      notification.title,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                        color: AppColors.black87,
                                      ),
                                    ),
                                  ),
                                  if (!isRead)
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.message,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _formatTime(context, notification.createdAt),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text(err.toString())),
      ),
    );
  }

  IconData _getTypeIcon(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.warning:
        return Icons.warning_amber_rounded;
      case NotificationType.error:
        return Icons.error_outline_rounded;
      case NotificationType.info:
        return Icons.info_outline_rounded;
    }
  }

  Color _getTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return Colors.green;
      case NotificationType.warning:
        return Colors.orange;
      case NotificationType.error:
        return AppColors.error;
      case NotificationType.info:
        return AppColors.primary;
    }
  }

  String _formatTime(BuildContext context, DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    final l10n = context.l10n;
    
    if (difference.inMinutes < 1) return l10n.justNow;
    if (difference.inMinutes < 60) {
      return l10n.minutesAgoShort(difference.inMinutes.toString());
    }
    if (difference.inHours < 24) {
      return l10n.hoursAgoShort(difference.inHours.toString());
    }
    if (difference.inDays < 7) {
      return l10n.daysAgoShort(difference.inDays.toString());
    }
    
    return '${time.day}/${time.month}/${time.year}';
  }
}
