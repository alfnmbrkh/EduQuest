import '../models/question.dart';

const List<Question> quizQuestions = [
  Question(
    category: 'Programming',
    question:
        'Bahasa yang digunakan Flutter untuk mengembangkan aplikasi adalah?',
    options: ['Java', 'Dart', 'Python', 'PHP'],
    correctAnswerIndex: 1,
    explanation: 'Flutter menggunakan bahasa pemrograman Dart.',
  ),
  Question(
    category: 'Technology',
    question: 'Apa kepanjangan dari CPU?',
    options: [
      'Central Processing Unit',
      'Computer Personal Unit',
      'Central Program Utility',
      'Control Processing User',
    ],
    correctAnswerIndex: 0,
    explanation: 'CPU adalah Central Processing Unit yang menjalankan instruksi program.',
  ),
  Question(
    category: 'Science',
    question: 'Planet yang dikenal sebagai Planet Merah adalah?',
    options: ['Venus', 'Jupiter', 'Mars', 'Saturnus'],
    correctAnswerIndex: 2,
    explanation: 'Mars tampak kemerahan karena mineral besi pada permukaannya.',
  ),
  Question(
    category: 'General Knowledge',
    question: 'Berapa jumlah hari dalam satu minggu?',
    options: ['Lima', 'Enam', 'Tujuh', 'Delapan'],
    correctAnswerIndex: 2,
    explanation: 'Satu minggu terdiri dari tujuh hari.',
  ),
  Question(
    category: 'Programming',
    question: 'Apa fungsi utama dari variabel dalam pemrograman?',
    options: [
      'Menyimpan data',
      'Menghapus aplikasi',
      'Mematikan komputer',
      'Mengubah perangkat keras',
    ],
    correctAnswerIndex: 0,
    explanation: 'Variabel digunakan untuk menyimpan nilai yang dapat digunakan program.',
  ),
];
