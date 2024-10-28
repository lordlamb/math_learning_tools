import 'package:flutter/material.dart';
import 'package:math_learning_tools/component/radio_button.dart';
import 'screen_adaptation.dart';
import 'calculation_data.dart';

class Calculation extends StatefulWidget {
  const Calculation({super.key});

  @override
  State<StatefulWidget> createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  QuizCount? quizCount;
  Stage stage = Stage.selectQuiz;
  List<String> quiz = [];
  int startTime = 0;
  int endTime = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.px)
          .add(EdgeInsets.only(bottom: 20.px)),
      alignment: Alignment.center,
      child: stage == Stage.selectQuiz
          ? _buildSelectQuiz(context)
          : stage == Stage.completeQuiz
              ? _buildQuiz(context)
              : _buildEnd(context),
    );
  }

  Widget _buildSelectQuiz(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RadioButton(
                isChecked: quizCount == QuizCount.q20,
                title: '5以内加减法',
                onValueChanged: (value) {
                  if (value) {
                    setState(() {
                      quizCount = QuizCount.q20;
                    });
                  }
                },
              ),
              RadioButton(
                isChecked: quizCount == QuizCount.q70,
                title: '10以内加减法',
                onValueChanged: (value) {
                  if (value) {
                    setState(() {
                      quizCount = QuizCount.q70;
                    });
                  }
                },
              ),
              RadioButton(
                isChecked: quizCount == QuizCount.q36,
                title: '20以内进位加减',
                onValueChanged: (value) {
                  if (value) {
                    setState(() {
                      quizCount = QuizCount.q36;
                    });
                  }
                },
              ),
              RadioButton(
                isChecked: quizCount == QuizCount.all,
                title: '全部',
                onValueChanged: (value) {
                  if (value) {
                    setState(() {
                      quizCount = QuizCount.all;
                    });
                  }
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40.px,
        ),
        GestureDetector(
          onTap: () {
            if (quizCount != null) {
              switch (quizCount!) {
                case QuizCount.q20:
                  quiz = CalculationData.quiz20;
                case QuizCount.q70:
                  quiz = CalculationData.quiz70;
                case QuizCount.q36:
                  quiz = CalculationData.quiz36;
                case QuizCount.all:
                  quiz = List.of(CalculationData.quiz20)
                    ..addAll(CalculationData.quiz70)
                    ..addAll(CalculationData.quiz36);
              }
              quiz.shuffle();
              stage = Stage.completeQuiz;
              startTime = DateTime.now().millisecondsSinceEpoch;
              setState(() {});
            }
          },
          child: Container(
            width: 120.px,
            height: 40.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border.all(
                color: Colors.lightBlue,
                width: 1.px,
              ),
              borderRadius: BorderRadius.circular(4.px),
            ),
            child: Text(
              "开始",
              style: TextStyle(fontSize: 24.px),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuiz(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: _buildQuizContent(context),
        ),
        SizedBox(
          height: 10.px,
        ),
        GestureDetector(
          onTap: () {
            endTime = DateTime.now().millisecondsSinceEpoch;
            stage = Stage.completed;
            setState(() {});
          },
          child: Container(
            width: 120.px,
            height: 40.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border.all(
                color: Colors.lightBlue,
                width: 1.px,
              ),
              borderRadius: BorderRadius.circular(4.px),
            ),
            child: Text(
              "结束",
              style: TextStyle(fontSize: 24.px),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEnd(BuildContext context) {
    final time = (endTime - startTime) / 1000;
    final min = time ~/ 60;
    final second = (time % 60).ceil();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: Text(
              "$min分$second秒",
              style: TextStyle(fontSize: 24.px),
            ),
          ),
        ),
        SizedBox(
          height: 20.px,
        ),
        GestureDetector(
          onTap: () {
            startTime = 0;
            endTime = 0;
            stage = Stage.selectQuiz;
            setState(() {});
          },
          child: Container(
            width: 120.px,
            height: 40.px,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              border: Border.all(
                color: Colors.lightBlue,
                width: 1.px,
              ),
              borderRadius: BorderRadius.circular(4.px),
            ),
            child: Text(
              "再做一次",
              style: TextStyle(fontSize: 24.px),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuizContent(BuildContext context) {
    if (quizCount == null) {
      return Container();
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        final contentWidth = 580.px;
        final contentHeight = constraints.maxHeight - 10.px;
        double horizontalSpacing = 10.px;
        double verticalSpacing = 10.px;
        int horizontalCount = 0;
        int verticalCount = 0;
        double fontSize = 18.px;

        switch (quizCount!) {
          case QuizCount.q20:
            horizontalCount = 5;
            verticalCount = 4;
          case QuizCount.q70:
            horizontalCount = 10;
            verticalCount = 7;
            horizontalSpacing = 5.px;
            verticalSpacing = 5.px;
          case QuizCount.q36:
            horizontalCount = 6;
            verticalCount = 6;
          case QuizCount.all:
            horizontalCount = 9;
            verticalCount = 14;
            fontSize = 16.px;
            horizontalSpacing = 4.px;
            verticalSpacing = 2.px;
        }

        final width =
            (contentWidth - (horizontalCount - 1) * horizontalSpacing) /
                horizontalCount;
        final height = (contentHeight - (verticalCount - 1) * verticalSpacing) /
            verticalCount;

        return Container(
          height: contentHeight,
          width: contentWidth,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: width,
              crossAxisSpacing: horizontalSpacing,
              mainAxisSpacing: verticalSpacing,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.px,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                quiz[index],
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            primary: false,
            shrinkWrap: true,
            itemCount: quiz.length,
          ),
        );
      });
    }
  }
}
