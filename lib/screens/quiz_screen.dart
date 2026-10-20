import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        if (quiz.isFinished) {
          return _buildResult(context, quiz);
        }

        final question = quizQuestions[quiz.currentQuestionIndex];
        final selectedAnswer = quiz.selectedAnswer;
        final isLastQuestion =
            quiz.currentQuestionIndex == quiz.totalQuestions - 1;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'EduQuest Quiz',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 650),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                question.category,
                                style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Soal ${quiz.currentQuestionIndex + 1}'
                                ' dari ${quiz.totalQuestions}',
                                style: const TextStyle(
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: quiz.progress,
                              minHeight: 8,
                              backgroundColor: AppTheme.primary.withValues(
                                alpha: 0.12,
                              ),
                              color: AppTheme.primary,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            'Uji Pengetahuanmu!',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.question,
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 24),
                          ...List.generate(question.options.length, (index) {
                            final isSelected = selectedAnswer == index;
                            final isCorrect =
                                index == question.correctAnswerIndex;

                            Color borderColor = Colors.grey.shade300;
                            Color backgroundColor = Colors.white;
                            IconData? trailingIcon;

                            if (selectedAnswer != null && isCorrect) {
                              borderColor = AppTheme.success;
                              backgroundColor = AppTheme.success.withValues(
                                alpha: 0.08,
                              );
                              trailingIcon = Icons.check_circle_rounded;
                            } else if (isSelected && selectedAnswer != null) {
                              borderColor = AppTheme.error;
                              backgroundColor = AppTheme.error.withValues(
                                alpha: 0.08,
                              );
                              trailingIcon = Icons.cancel_rounded;
                            } else if (isSelected) {
                              borderColor = AppTheme.primary;
                              backgroundColor = AppTheme.primary.withValues(
                                alpha: 0.08,
                              );
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Material(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () => quiz.selectAnswer(index),
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: borderColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor: borderColor
                                              .withValues(alpha: 0.15),
                                          child: Text(
                                            String.fromCharCode(65 + index),
                                            style: TextStyle(
                                              color: borderColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(question.options[index]),
                                        ),
                                        if (trailingIcon != null)
                                          Icon(
                                            trailingIcon,
                                            color: borderColor,
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          if (selectedAnswer != null) ...[
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedAnswer ==
                                            question.correctAnswerIndex
                                        ? 'Jawaban benar!'
                                        : 'Belum tepat!',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(question.explanation),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              if (quiz.currentQuestionIndex > 0)
                                OutlinedButton(
                                  onPressed: quiz.previousQuestion,
                                  child: const Text('Sebelumnya'),
                                ),
                              if (quiz.currentQuestionIndex > 0)
                                const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: selectedAnswer == null
                                      ? null
                                      : quiz.nextQuestion,
                                  child: Text(
                                    isLastQuestion
                                        ? 'Lihat Hasil'
                                        : 'Soal Berikutnya',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildResult(BuildContext context, QuizProvider quiz) {
    final percentage = quiz.totalQuestions == 0
        ? 0
        : (quiz.score / quiz.totalQuestions * 100).round();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Hasil Kuis',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.emoji_events_rounded,
                    size: 88,
                    color: AppTheme.primary,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Kuis Selesai!',
                    style: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Kamu berhasil menjawab ${quiz.score} dari '
                    '${quiz.totalQuestions} soal dengan benar.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    '$percentage%',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text('Skor Akhir'),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        quiz.restartQuiz();
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Ulangi Kuis'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.home_rounded),
                      label: const Text('Kembali ke Beranda'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
