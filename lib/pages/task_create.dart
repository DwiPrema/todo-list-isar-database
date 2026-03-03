import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_isar_database/core/constant/app_color.dart';
import 'package:todo_list_isar_database/model/enum_status.dart';
import 'package:todo_list_isar_database/model/todo.dart';
import 'package:todo_list_isar_database/services/database_service.dart';
import 'package:todo_list_isar_database/widget/text_field.dart';
import 'package:todo_list_isar_database/widget/text_widget.dart';

class TaskCreatePage extends StatefulWidget {
  final Todo? todo;

  const TaskCreatePage({super.key, this.todo});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Status status = Status.pending;

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      titleController.text = widget.todo!.title;
      descriptionController.text = widget.todo!.description ?? "";
      status = widget.todo!.status;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dateNow = DateFormat('EEE, dd MMMM yyyy').format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.white,
              AppColors.white,
              AppColors.white,
              AppColors.secColor,
              AppColors.secColor,
              AppColors.secColor,
            ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(35))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //BACK BUTTON
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.black.withAlpha(50),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.black,
                            ),
                          ),
                        ),

                        //SAVE BUTTON
                        GestureDetector(
                          onTap: () async {
                            if (titleController.text.isNotEmpty) {
                              late Todo newTodo;
                              if (widget.todo != null) {
                                newTodo = widget.todo!.copyWith(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  status: status,
                                  updatedAt: DateTime.now(),
                                );
                              } else {
                                newTodo = Todo().copyWith(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  status: status,
                                  updatedAt: null
                                );
                              }

                              await DatabaseService.db.writeTxn(
                                () async {
                                  await DatabaseService.db.todos.put(newTodo);
                                },
                              );

                              if (!context.mounted) return;
                              Navigator.of(context).pop();
                            }
                          },
                          child: const CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(
                              Icons.check,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    textPoppins(
                        widget.todo != null ? "Edit Task" : "Create Task",
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black),
                    textInter(dateNow,
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: AppColors.black),
                    const SizedBox(
                      height: 42,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.secColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                    ),
                  ),
                  child: Column(children: [
                    DropdownButtonFormField<Status>(
                        value: status,
                        items: Status.values
                            .map((e) => DropdownMenuItem(
                                value: e,
                                child: textInter(e.name,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black)))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            status = value;
                          });
                        }),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFieldTitle(
                        hintText: "Title",
                        textEditingController: titleController),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFieldDesc(
                        hintText: "description...",
                        textEditingController: descriptionController),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
