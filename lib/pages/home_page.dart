import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_isar_database/core/constant/app_color.dart';
import 'package:todo_list_isar_database/model/todo.dart';
import 'package:todo_list_isar_database/pages/task_create.dart';
import 'package:todo_list_isar_database/services/database_service.dart';
import 'package:todo_list_isar_database/widget/button.dart';
import 'package:todo_list_isar_database/widget/snap_effect.dart';
import 'package:todo_list_isar_database/widget/text_widget.dart';
import 'package:todo_list_isar_database/widget/todo_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> todos = [];

  StreamSubscription? todoStream;

  @override
  void initState() {
    super.initState();
    todoStream = DatabaseService.db.todos
        .buildQuery<Todo>()
        .watch(fireImmediately: true)
        .listen((data) {
      setState(() {
        todos = data;
      });
    });
  }

  @override
  void dispose() {
    todoStream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeNow = DateTime.now();
    String day = DateFormat('EEEE').format(dateTimeNow);
    String dateAndMonth = DateFormat('dd MMMM yyyy').format(dateTimeNow);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            physics: const HeavyScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  Center(
                    child: textInter("Task Management",
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        align: TextAlign.center),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textPoppins(day,
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              align: TextAlign.left),
                          textInter(dateAndMonth,
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              align: TextAlign.left),
                        ],
                      ),
                      Button(
                          text: "Add Task",
                          textColor: AppColors.primaryColor,
                          bgColor: AppColors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          borderRadius: BorderRadius.circular(5),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TaskCreatePage()));
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            snap: true,
            initialChildSize: 0.75,
            maxChildSize: 1.0,
            minChildSize: 0.75,
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 16),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35)),
                ),
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.black.withAlpha(50),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                    ...List.generate(todos.length, (index) {
                      final todo = todos[index];

                      final isEdited = todo.updatedAt != null;

                      final displayDate =
                          isEdited ? todo.updatedAt! : todo.createdAt;

                      final locale = Localizations.localeOf(context).toString();

                      final dateNow =
                          DateFormat('EEE, dd MMMM yyyy', locale).format(displayDate);
                      final timeNow = DateFormat.jm(locale).format(displayDate);

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: TodoCard(
                            onTapEdit: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TaskCreatePage(
                                  todo: todo,
                                );
                              }));
                            },
                            onTapRemove: () {
                              return _removeAlert(todo);
                            },
                            title: todo.title,
                            description: todo.description,
                            status: "status : ${todo.status.name}",
                            date: isEdited
                                ? "updated at : $timeNow"
                                : "created at : $timeNow"),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }

  /// use this for remove task alert
  void _removeAlert(Todo todo) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.delete,
              size: 35,
            ),
            title: textPoppins("Are you sure to remove this task ?",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.black),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 24,
                ),
                textInter("Title : ${todo.title}",
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                    align: TextAlign.left),
                const SizedBox(
                  height: 16,
                ),
                textPoppins("Description : ${todo.description}",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                    align: TextAlign.left),
                const SizedBox(
                  height: 16,
                ),
                textPoppins("Status : ${todo.status.name}",
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    color: AppColors.black,
                    align: TextAlign.left),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            actions: [
              Button(
                  text: "remove",
                  textColor: AppColors.white,
                  bgColor: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  borderRadius: BorderRadius.circular(100),
                  onPressed: () async {
                    await DatabaseService.db.writeTxn(
                      () async {
                        await DatabaseService.db.todos.delete(todo.id);
                      },
                    );

                    if (!context.mounted) return;
                    Navigator.pop(context);
                  }),
              Button(
                  text: "cancel",
                  textColor: AppColors.black,
                  bgColor: AppColors.black.withAlpha(50),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  borderRadius: BorderRadius.circular(100),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
