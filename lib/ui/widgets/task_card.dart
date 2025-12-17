import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/data/models/task_model.dart';
import 'package:task_managment_app/data/services/network_caller.dart';
import 'package:task_managment_app/providers/canceled_task_provider.dart';
import 'package:task_managment_app/providers/completed_task_provider.dart';
import 'package:task_managment_app/providers/new_task_provider.dart';
import 'package:task_managment_app/providers/progress_task_provider.dart';
import 'package:task_managment_app/providers/task_count_provider.dart';
import 'package:task_managment_app/providers/task_delete_provider.dart';
import 'package:task_managment_app/ui/widgets/snackbar_message.dart';
import 'package:task_managment_app/utils/url.dart';

class TaskCard extends StatefulWidget {
  final TaskModel task;
  const TaskCard({super.key, required this.task});

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        tileColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        title: Text(widget.task.title, style: textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              widget.task.description,
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.task.createdDate,
              style: textTheme.titleSmall?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: getColorByStatus(widget.task.status),
                  label: Text(
                    widget.task.status,
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _showStatusUpdateModal,
                      icon: Icon(Icons.edit_note_outlined),
                      color: colorScheme.primary,
                    ),
                    Consumer<TaskDeleteProvider>(
                      builder: (context, provider, child) {
                        return Visibility(
                          replacement: CircularProgressIndicator(),
                          visible: provider.isDeleting == false,
                          child: IconButton(
                            onPressed: () {
                              deleteTask(widget.task.id);
                            },
                            icon: const Icon(Icons.delete_outline),
                            color: Colors.redAccent,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _showStatusUpdateModal() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update status"),
          content: ListTileTheme(
            data: ListTileThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: ColorScheme.of(context).primary.withAlpha(50),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            child: Column(
              spacing: 5,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _updateStatus(widget.task.id, "New");
                  },
                  title: Text("New"),
                  trailing: _isCuurrentStatus("New") ? Icon(Icons.done) : null,
                ),
                ListTile(
                  onTap: () {
                    _updateStatus(widget.task.id, "Completed");
                  },
                  title: Text("Completed"),
                  trailing: _isCuurrentStatus("Completed")
                      ? Icon(Icons.done)
                      : null,
                ),
                ListTile(
                  onTap: () {
                    _updateStatus(widget.task.id, "Canceled");
                  },
                  title: Text("Canceled"),
                  trailing: _isCuurrentStatus("Canceled")
                      ? Icon(Icons.done)
                      : null,
                ),
                ListTile(
                  onTap: () {
                    _updateStatus(widget.task.id, "Progress");
                  },
                  title: Text("Progress"),
                  trailing: _isCuurrentStatus("Progress")
                      ? Icon(Icons.done)
                      : null,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _isCuurrentStatus(String status) {
    return widget.task.status == status;
  }

  Future<void> _updateStatus(id, status) async {
    NetworkResponse response = await NetworkCaller.getRequest(
      Url.updateUrl(id, status),
    );
    if (response.statusCode == 200) {
      snackbarMessgae(context, "Updated successful");
      Navigator.pop(context);
      _refresh();
    } else {
      snackbarMessgae(context, "${response.body}");
    }
  }

  Future<void> deleteTask(id) async {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Delete Task"),
          content: Text("Do you want to delete ${widget.task.title} ?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            Consumer<TaskDeleteProvider>(
              builder: (context, provider, child) {
                return Visibility(
                  replacement: CircularProgressIndicator(),
                  visible: provider.isDeleting == false,
                  child: FilledButton(
                    style: FilledButton.styleFrom(maximumSize: Size(140, 45)),
                    onPressed: () async {
                      NetworkResponse response = await provider.deleteTask(
                        id: id,
                      );
                      if (response.isSuccess) {
                        snackbarMessgae(context, "Task deleted");
                        Navigator.pop(context);
                        _refresh();
                      } else {
                        snackbarMessgae(context, "${response.body}");
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Confirm"),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _refresh() {
    context.read<NewTaskProvider>().getNewTasks();
    context.read<CompletedTaskProvider>().getCompletedTasks();
    context.read<CanceledTaskProvider>().getCanceledTask();
    context.read<ProgressTaskProvider>().getProgressTasks();
    context.read<TaskCountProvider>().getTaskCounts();
  }

  Color getColorByStatus(String status) {
    if (status == "New") {
      return Colors.blueAccent.withAlpha(700);
    } else if (status == "Completed") {
      return ColorScheme.of(context).primary.withAlpha(700);
    } else if (status == "Canceled") {
      return Colors.redAccent.withAlpha(700);
    } else if (status == "Canceled") {
      return Colors.redAccent.withAlpha(700);
    } else {
      return Colors.deepOrange.withAlpha(700);
    }
  }
}
