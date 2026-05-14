import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
  });

  Color getPriorityColor() {
    switch (task.priority) {
      case 'High':
        return Colors.red;

      case 'Medium':
        return Colors.orange;

      default:
        return Colors.green;
    }
  }

  IconData getCategoryIcon() {
    switch (task.category) {
      case 'School':
        return Icons.school;

      case 'Health':
        return Icons.favorite;

      default:
        return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isOverdue =
        task.dueDate.isBefore(
          DateTime.now(),
        ) &&
        !task.isCompleted;

    return GestureDetector(
      onTap: onTap,

      child: Card(
        elevation: 4,

        margin:
            const EdgeInsets.symmetric(
          vertical: 8,
        ),

        color: isOverdue
            ? Colors.red.shade50
            : Colors.white,

        shape:
            RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(
            15,
          ),
        ),

        child: Padding(
          padding:
              const EdgeInsets.all(16),

          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    getPriorityColor(),

                child: Icon(
                  getCategoryIcon(),
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [
                    Text(
                      task.title,

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,

                        decoration:
                            task.isCompleted
                                ? TextDecoration
                                    .lineThrough
                                : TextDecoration
                                    .none,
                      ),
                    ),

                    const SizedBox(
                        height: 5),

                    Text(task.category),

                    const SizedBox(
                        height: 5),

                    Text(
                      'Due: ${task.dueDate.day}/${task.dueDate.month}/${task.dueDate.year}',
                    ),
                  ],
                ),
              ),

              Icon(
                task.isCompleted
                    ? Icons.check_circle
                    : Icons.pending_actions,

                color:
                    task.isCompleted
                        ? Colors.green
                        : Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
