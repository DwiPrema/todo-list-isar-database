import 'package:flutter/material.dart';
import 'package:todo_list_isar_database/core/constant/app_color.dart';
import 'package:todo_list_isar_database/widget/button.dart';
import 'package:todo_list_isar_database/widget/snap_effect.dart';
import 'package:todo_list_isar_database/widget/text_widget.dart';
import 'package:todo_list_isar_database/widget/todo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                          textPoppins("Sunday",
                              fontSize: 24,
                              fontWeight: FontWeight.w300,
                              align: TextAlign.left),
                          textInter("11 August",
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
                          onPressed: () {}),
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
                    ...List.generate(11, 
                    (index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom : 16),
                        child: TodoCard(
                            title: "Task Title",
                            description:
                                "here is the place for description, but it is opsional, you can display the description or not, but max 2 lines, the overflow use elipsis",
                            status: "status : pending",
                            date: "created at : 11 augustr"),
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
}
