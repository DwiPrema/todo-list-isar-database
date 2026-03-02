import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_list_isar_database/core/constant/app_color.dart';
import 'package:todo_list_isar_database/widget/text_widget.dart';

class TodoCard extends StatelessWidget {
  final String title;
  final String? description;
  final String status;
  final String date;

  const TodoCard(
      {super.key,
      required this.title,
      required this.description,
      required this.status,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.secColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withAlpha(55),
              blurRadius: 2,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textInter(title,
                        fontSize: 14,
                        color: AppColors.black,
                        fontWeight: FontWeight.w800),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      description ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          color: AppColors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Row(
                children: [
                  Icon(
                    Icons.delete,
                    size: 22,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 8,),
                  Icon(
                    Icons.edit_square,
                    size: 22,
                    color: AppColors.black,
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textPoppins(date,
                  fontSize: 8,
                  color: AppColors.black.withAlpha(120),
                  fontWeight: FontWeight.w300),
              textPoppins(status,
                  fontSize: 8,
                  color: AppColors.black.withAlpha(120),
                  fontWeight: FontWeight.w300),
            ],
          ),
        ],
      ),
    );
  }
}
