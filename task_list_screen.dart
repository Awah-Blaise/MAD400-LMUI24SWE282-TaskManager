import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() =>
      _TaskListScreenState();
}

class _TaskListScreenState
    extends State<TaskListScreen> {
  List<Task> tasks = [
    Task(
      title: 'Complete Flutter Assignment',
      description:
          'Finish the mobile application exercise',
      category: 'School',
      priority: 'High',
      dueDate:
          DateTime.now().add(const Duration(days: 2)),
    ),

    Task(
      title: 'Workout Session',
      description: 'Go to the gym and exercise',
      category: 'Health',
      priority: 'Medium',
      dueDate:
          DateTime.now().add(const Duration(days: 1)),
    ),
  ];

  String selectedFilter = 'All';
  String searchQuery = '';

  final TextEditingController titleController =
      TextEditingController();

  final TextEditingController descriptionController =
      TextEditingController();

  String selectedCategory = 'School';
  String selectedPriority = 'Medium';

  DateTime? selectedDate;

  List<Task> getFilteredTasks() {
    List<Task> filteredTasks = tasks;

    if (selectedFilter == 'Pending') {
      filteredTasks = filteredTasks
          .where((task) => !task.isCompleted)
          .toList();
    }

    if (selectedFilter == 'Completed') {
      filteredTasks = filteredTasks
          .where((task) => task.isCompleted)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      filteredTasks = filteredTasks
          .where(
            (task) => task.title
                .toLowerCase()
                .contains(
                  searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filteredTasks;
  }

  void addTask() {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        selectedDate == null) {
      return;
    }

    setState(() {
      tasks.add(
        Task(
          title: titleController.text,
          description:
              descriptionController.text,
          category: selectedCategory,
          priority: selectedPriority,
          dueDate: selectedDate!,
        ),
      );
    });

    titleController.clear();
    descriptionController.clear();

    selectedCategory = 'School';
    selectedPriority = 'Medium';
    selectedDate = null;

    Navigator.pop(context);
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom:
                    MediaQuery.of(context)
                            .viewInsets
                            .bottom +
                        20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [
                    const Text(
                      'Add New Task',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    TextField(
                      controller:
                          titleController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Task Title',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    TextField(
                      controller:
                          descriptionController,
                      maxLines: 3,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Description',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    DropdownButtonFormField(
                      value:
                          selectedCategory,
                      items: const [
                        DropdownMenuItem(
                          value: 'School',
                          child:
                              Text('School'),
                        ),

                        DropdownMenuItem(
                          value:
                              'Personal',
                          child:
                              Text('Personal'),
                        ),

                        DropdownMenuItem(
                          value: 'Health',
                          child:
                              Text('Health'),
                        ),
                      ],
                      onChanged: (value) {
                        setModalState(() {
                          selectedCategory =
                              value!;
                        });
                      },
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Category',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    DropdownButtonFormField(
                      value:
                          selectedPriority,
                      items: const [
                        DropdownMenuItem(
                          value: 'Low',
                          child:
                              Text('Low'),
                        ),

                        DropdownMenuItem(
                          value:
                              'Medium',
                          child: Text(
                              'Medium'),
                        ),

                        DropdownMenuItem(
                          value: 'High',
                          child:
                              Text('High'),
                        ),
                      ],
                      onChanged: (value) {
                        setModalState(() {
                          selectedPriority =
                              value!;
                        });
                      },
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Priority',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    SizedBox(
                      width:
                          double.infinity,
                      child:
                          ElevatedButton.icon(
                        icon: const Icon(
                          Icons
                              .calendar_today,
                        ),

                        label: Text(
                          selectedDate ==
                                  null
                              ? 'Pick Due Date'
                              : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                        ),

                        onPressed:
                            () async {
                          DateTime?
                              pickedDate =
                              await showDatePicker(
                            context:
                                context,

                            initialDate:
                                DateTime
                                    .now(),

                            firstDate:
                                DateTime
                                    .now(),

                            lastDate:
                                DateTime(
                                    2030),
                          );

                          if (pickedDate !=
                              null) {
                            setModalState(
                                () {
                              selectedDate =
                                  pickedDate;
                            });
                          }
                        },
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    SizedBox(
                      width:
                          double.infinity,
                      child:
                          ElevatedButton(
                        onPressed:
                            addTask,

                        child:
                            const Text(
                          'Add Task',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void sortByDate() {
    setState(() {
      tasks.sort(
        (a, b) =>
            a.dueDate.compareTo(
          b.dueDate,
        ),
      );
    });
  }

  void sortByPriority() {
    setState(() {
      List<String> order = [
        'High',
        'Medium',
        'Low'
      ];

      tasks.sort(
        (a, b) => order
            .indexOf(a.priority)
            .compareTo(
              order.indexOf(
                  b.priority),
            ),
      );
    });
  }

  Widget buildFilterButton(
      String filterName) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            selectedFilter == filterName
                ? Colors.teal
                : Colors.grey,
      ),

      onPressed: () {
        setState(() {
          selectedFilter = filterName;
        });
      },

      child: Text(filterName),
    );
  }

  Widget buildStatisticColumn(
      String title,
      int value) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(title),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Task> filteredTasks =
        getFilteredTasks();

    int completedTasks = tasks
        .where((task) => task.isCompleted)
        .length;

    int pendingTasks = tasks
        .where((task) => !task.isCompleted)
        .length;

    double progress = tasks.isEmpty
        ? 0
        : completedTasks / tasks.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),

        actions: [
          IconButton(
            icon: const Icon(Icons.sort),

            onPressed: () {
              showModalBottomSheet(
                context: context,

                builder: (context) {
                  return Column(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.date_range,
                        ),

                        title: const Text(
                          'Sort by Due Date',
                        ),

                        onTap: () {
                          sortByDate();

                          Navigator.pop(
                              context);
                        },
                      ),

                      ListTile(
                        leading: const Icon(
                          Icons
                              .priority_high,
                        ),

                        title: const Text(
                          'Sort by Priority',
                        ),

                        onTap: () {
                          sortByPriority();

                          Navigator.pop(
                              context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

          IconButton(
            icon: const Icon(
              Icons.delete_forever,
            ),

            onPressed: () {
              showDialog(
                context: context,

                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Clear All Tasks',
                    ),

                    content: const Text(
                      'Are you sure you want to delete all tasks?',
                    ),

                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                              context);
                        },

                        child: const Text(
                            'Cancel'),
                      ),

                      TextButton(
                        onPressed: () {
                          setState(() {
                            tasks.clear();
                          });

                          Navigator.pop(
                              context);
                        },

                        child: const Text(
                            'Delete'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed:
            showAddTaskBottomSheet,

        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              decoration:
                  const InputDecoration(
                hintText:
                    'Search tasks...',
                prefixIcon:
                    Icon(Icons.search),
                border:
                    OutlineInputBorder(),
              ),

              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Card(
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        15),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(
                        16),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceAround,

                      children: [
                        buildStatisticColumn(
                          'Total',
                          tasks.length,
                        ),

                        buildStatisticColumn(
                          'Completed',
                          completedTasks,
                        ),

                        buildStatisticColumn(
                          'Pending',
                          pendingTasks,
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 15),

                    LinearProgressIndicator(
                      value: progress,
                      minHeight: 10,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceEvenly,

              children: [
                buildFilterButton('All'),

                buildFilterButton(
                    'Pending'),

                buildFilterButton(
                    'Completed'),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: filteredTasks.isEmpty
                  ? const Center(
                      child: Text(
                        'No tasks available',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )

                  : ListView.builder(
                      itemCount:
                          filteredTasks
                              .length,

                      itemBuilder:
                          (context, index) {
                        Task task =
                            filteredTasks[
                                index];

                        return Dismissible(
                          key: Key(
                            task.title +
                                index
                                    .toString(),
                          ),

                          direction:
                              DismissDirection
                                  .endToStart,

                          background:
                              Container(
                            alignment:
                                Alignment
                                    .centerRight,

                            padding:
                                const EdgeInsets
                                    .only(
                              right: 20,
                            ),

                            decoration:
                                BoxDecoration(
                              color:
                                  Colors.red,

                              borderRadius:
                                  BorderRadius
                                      .circular(
                                15,
                              ),
                            ),

                            child:
                                const Icon(
                              Icons.delete,
                              color:
                                  Colors.white,
                            ),
                          ),

                          onDismissed:
                              (direction) {
                            setState(() {
                              tasks.remove(
                                  task);
                            });
                          },

                          child: TaskCard(
                            task: task,

                            onTap: () {
                              Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          TaskDetailScreen(
                                    task: task,

                                    onDelete:
                                        () {
                                      setState(
                                          () {
                                        tasks.remove(
                                            task);
                                      });
                                    },

                                    onToggleComplete:
                                        () {
                                      setState(
                                          () {
                                        task.isCompleted =
                                            !task.isCompleted;
                                      });
                                    },

                                    onEdit:
                                        (
                                      updatedTask,
                                    ) {
                                      setState(
                                          () {
                                        int index =
                                            tasks.indexOf(
                                          task,
                                        );

                                        tasks[index] =
                                            updatedTask;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}