import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key});

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
        title: Text("Title of Task 1", style: textTheme.titleMedium),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              "It is a long established fact that a reader will be distracted by the readable",
              style: textTheme.titleSmall?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "02-02-2026",
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
                  backgroundColor: colorScheme.primary.withOpacity(0.7),
                  label: Text(
                    "New",
                    style: textTheme.bodySmall?.copyWith(color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_note_outlined),
                      color: colorScheme.primary,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.redAccent,
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
}
