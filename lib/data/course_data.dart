import '../models/lesson_model.dart';

const List<Unit> allUnits = [
  // ─────────────────────────── UNIT 1 ───────────────────────────
  Unit(
    id: 'u1',
    titleBM: 'Asas Coding',
    titleEN: 'Coding Basics',
    emoji: '🖥️',
    color: '#4CAF50',
    lessons: [
      // ── Lesson 1-1 ──
      Lesson(
        id: 'u1l1',
        unitId: 'u1',
        titleBM: 'Apa itu Coding?',
        titleEN: 'What is Coding?',
        descBM: 'Kenali apakah itu coding dan program komputer.',
        descEN: 'Learn what coding and computer programs are.',
        emoji: '🤔',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u1l1e1',
            type: 'mcq',
            questionBM: 'Apa yang dilakukan oleh sebuah program komputer?',
            questionEN: 'What does a computer program do?',
            options: [
              'Memberikan arahan kepada komputer',
              'Memperbaiki komputer',
              'Menyimpan gambar sahaja',
              'Memainkan muzik sahaja',
            ],
            correctAnswer: '0',
            explanationBM:
                'Program komputer adalah satu set arahan yang memberitahu komputer apa yang perlu dilakukan.',
            explanationEN:
                'A computer program is a set of instructions that tells the computer what to do.',
          ),
          Exercise(
            id: 'u1l1e2',
            type: 'truefalse',
            questionBM: 'Coding adalah cara untuk berkomunikasi dengan komputer menggunakan bahasa khas.',
            questionEN: 'Coding is a way to communicate with a computer using a special language.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! Coding menggunakan bahasa pengaturcaraan — bahasa khas yang difahami oleh komputer.',
            explanationEN:
                'True! Coding uses programming languages — special languages that computers understand.',
          ),
          Exercise(
            id: 'u1l1e3',
            type: 'mcq',
            questionBM: 'Antara berikut, yang manakah merupakan contoh bahasa pengaturcaraan?',
            questionEN: 'Which of the following is an example of a programming language?',
            options: ['Bahasa Melayu', 'Python', 'Microsoft Word', 'Google'],
            correctAnswer: '1',
            explanationBM:
                'Python adalah bahasa pengaturcaraan yang popular dan mudah dipelajari oleh pemula.',
            explanationEN:
                'Python is a popular programming language that is easy for beginners to learn.',
          ),
          Exercise(
            id: 'u1l1e4',
            type: 'truefalse',
            questionBM: 'Hanya pakar sahaja boleh belajar coding.',
            questionEN: 'Only experts can learn coding.',
            options: [],
            correctAnswer: 'false',
            explanationBM:
                'Salah! Sesiapa sahaja boleh belajar coding. Ia bermula dengan langkah kecil, seperti yang anda lakukan sekarang!',
            explanationEN:
                'False! Anyone can learn coding. It starts with small steps, just like what you are doing now!',
          ),
          Exercise(
            id: 'u1l1e5',
            type: 'mcq',
            questionBM: 'Apakah tujuan utama menulis kod (code)?',
            questionEN: 'What is the main purpose of writing code?',
            options: [
              'Untuk menghias komputer',
              'Untuk memberitahu komputer apa yang perlu dilakukan',
              'Untuk mencetak dokumen',
              'Untuk menyambungkan ke internet',
            ],
            correctAnswer: '1',
            explanationBM:
                'Kod ditulis untuk memberikan arahan kepada komputer supaya ia boleh menjalankan tugas yang kita mahu.',
            explanationEN:
                'Code is written to give instructions to the computer so it can perform the tasks we want.',
          ),
        ],
      ),

      // ── Lesson 1-2 ──
      Lesson(
        id: 'u1l2',
        unitId: 'u1',
        titleBM: 'Pemboleh Ubah',
        titleEN: 'Variables',
        descBM: 'Fahami konsep pemboleh ubah dalam pengaturcaraan.',
        descEN: 'Understand the concept of variables in programming.',
        emoji: '📦',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u1l2e1',
            type: 'mcq',
            questionBM: 'Apakah fungsi pemboleh ubah (variable) dalam pengaturcaraan?',
            questionEN: 'What is the function of a variable in programming?',
            options: [
              'Untuk memadam data',
              'Untuk menyimpan data atau nilai',
              'Untuk mencetak teks',
              'Untuk melukis gambar',
            ],
            correctAnswer: '1',
            explanationBM:
                'Pemboleh ubah digunakan untuk menyimpan data atau nilai supaya boleh digunakan semula dalam program.',
            explanationEN:
                'A variable is used to store data or values so they can be reused in the program.',
          ),
          Exercise(
            id: 'u1l2e2',
            type: 'truefalse',
            questionBM: 'Nama pemboleh ubah boleh bermula dengan angka, contohnya: 1nama.',
            questionEN: 'A variable name can start with a number, for example: 1name.',
            options: [],
            correctAnswer: 'false',
            codeSample: '// ❌ Salah / Wrong:\nint 1nama = 5;\n\n// ✅ Betul / Correct:\nint nama1 = 5;',
            explanationBM:
                'Nama pemboleh ubah tidak boleh bermula dengan angka. Ia mesti bermula dengan huruf atau garis bawah (_).',
            explanationEN:
                'A variable name cannot start with a number. It must start with a letter or underscore (_).',
          ),
          Exercise(
            id: 'u1l2e3',
            type: 'mcq',
            questionBM: 'Dalam kod berikut, apakah nilai yang disimpan dalam pemboleh ubah "umur"?\n\nint umur = 15;',
            questionEN: 'In the following code, what value is stored in the variable "umur"?\n\nint umur = 15;',
            options: ['umur', 'int', '15', '='],
            correctAnswer: '2',
            codeSample: 'int umur = 15;',
            explanationBM:
                'Nilai 15 disimpan dalam pemboleh ubah bernama "umur". "int" adalah jenis data, bukan nilainya.',
            explanationEN:
                'The value 15 is stored in the variable named "umur". "int" is the data type, not the value.',
          ),
          Exercise(
            id: 'u1l2e4',
            type: 'mcq',
            questionBM: 'Bayangkan pemboleh ubah seperti sebuah kotak. Apa yang kita simpan di dalam kotak itu?',
            questionEN: 'Imagine a variable as a box. What do we store inside the box?',
            options: ['Kotak lain', 'Data atau nilai', 'Komputer', 'Program'],
            correctAnswer: '1',
            explanationBM:
                'Pemboleh ubah adalah seperti kotak berlabel — kita simpan data di dalamnya dan boleh ambil semula bila-bila masa.',
            explanationEN:
                'A variable is like a labelled box — we store data inside it and can retrieve it at any time.',
          ),
          Exercise(
            id: 'u1l2e5',
            type: 'truefalse',
            questionBM: 'Nilai dalam pemboleh ubah boleh ditukar semasa program sedang berjalan.',
            questionEN: 'The value in a variable can be changed while the program is running.',
            options: [],
            correctAnswer: 'true',
            codeSample: 'int skor = 0;\nskor = 10; // nilai ditukar / value changed',
            explanationBM:
                'Betul! Pemboleh ubah boleh dikemas kini dengan nilai baru pada bila-bila masa semasa program berjalan.',
            explanationEN:
                'True! Variables can be updated with new values at any time while the program is running.',
          ),
        ],
      ),

      // ── Lesson 1-3 ──
      Lesson(
        id: 'u1l3',
        unitId: 'u1',
        titleBM: 'Jenis Data',
        titleEN: 'Data Types',
        descBM: 'Kenali jenis-jenis data dalam pengaturcaraan.',
        descEN: 'Learn about different data types in programming.',
        emoji: '🔢',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u1l3e1',
            type: 'mcq',
            questionBM: 'Jenis data manakah yang digunakan untuk menyimpan nombor bulat seperti 5, 10, 100?',
            questionEN: 'Which data type is used to store whole numbers like 5, 10, 100?',
            options: ['String', 'Boolean', 'Integer (int)', 'Float'],
            correctAnswer: '2',
            explanationBM:
                'Integer (int) digunakan untuk menyimpan nombor bulat tanpa titik perpuluhan.',
            explanationEN:
                'Integer (int) is used to store whole numbers without decimal points.',
          ),
          Exercise(
            id: 'u1l3e2',
            type: 'mcq',
            questionBM: 'Apakah jenis data untuk teks seperti "Hello" atau "Nama saya Ali"?',
            questionEN: 'What data type is used for text like "Hello" or "My name is Ali"?',
            options: ['int', 'String', 'boolean', 'double'],
            correctAnswer: '1',
            codeSample: 'String nama = "Ali";\nString ucapan = "Hello, dunia!";',
            explanationBM:
                'String digunakan untuk menyimpan teks atau gabungan aksara. Ia ditulis dalam tanda petikan.',
            explanationEN:
                'String is used to store text or a combination of characters. It is written in quotation marks.',
          ),
          Exercise(
            id: 'u1l3e3',
            type: 'truefalse',
            questionBM: 'Boolean hanya boleh menyimpan dua nilai: benar (true) atau salah (false).',
            questionEN: 'Boolean can only store two values: true or false.',
            options: [],
            correctAnswer: 'true',
            codeSample: 'bool sudahSelesai = true;\nbool sedangHujan = false;',
            explanationBM:
                'Betul! Boolean hanya ada dua nilai — true (benar) atau false (salah). Ia berguna untuk membuat keputusan.',
            explanationEN:
                'True! Boolean only has two values — true or false. It is useful for making decisions.',
          ),
          Exercise(
            id: 'u1l3e4',
            type: 'mcq',
            questionBM: 'Jenis data manakah yang sesuai untuk harga barang seperti 19.99?',
            questionEN: 'Which data type is suitable for a price like 19.99?',
            options: ['int', 'String', 'bool', 'double'],
            correctAnswer: '3',
            codeSample: 'double harga = 19.99;',
            explanationBM:
                'Double digunakan untuk nombor dengan titik perpuluhan (nombor nyata), seperti harga atau ukuran.',
            explanationEN:
                'Double is used for numbers with decimal points (real numbers), like prices or measurements.',
          ),
          Exercise(
            id: 'u1l3e5',
            type: 'mcq',
            questionBM: 'Antara berikut, yang manakah merupakan nilai String yang sah?',
            questionEN: 'Which of the following is a valid String value?',
            options: ['42', '"Selamat pagi"', 'true', '3.14'],
            correctAnswer: '1',
            explanationBM:
                'String mesti ditulis dalam tanda petikan. "Selamat pagi" adalah contoh String yang sah.',
            explanationEN:
                'Strings must be written in quotation marks. "Selamat pagi" is an example of a valid String.',
          ),
        ],
      ),

      // ── Lesson 1-4 (Challenge) ──
      Lesson(
        id: 'u1l4',
        unitId: 'u1',
        titleBM: 'Cabaran Unit 1',
        titleEN: 'Unit 1 Challenge',
        descBM: 'Uji kefahaman anda tentang asas coding!',
        descEN: 'Test your understanding of coding basics!',
        emoji: '🏆',
        xpReward: 30,
        exercises: [
          Exercise(
            id: 'u1l4e1',
            type: 'mcq',
            questionBM: 'Apakah nama untuk satu set arahan yang diberikan kepada komputer?',
            questionEN: 'What is the name for a set of instructions given to a computer?',
            options: ['Dokumen', 'Program', 'Gambar', 'Muzik'],
            correctAnswer: '1',
            explanationBM:
                'Program adalah satu set arahan bertulis yang memberitahu komputer apa yang perlu dilakukan.',
            explanationEN:
                'A program is a written set of instructions that tells the computer what to do.',
          ),
          Exercise(
            id: 'u1l4e2',
            type: 'truefalse',
            questionBM: 'Pemboleh ubah digunakan untuk menyimpan maklumat yang boleh digunakan semula.',
            questionEN: 'Variables are used to store information that can be reused.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! Itulah tujuan utama pemboleh ubah — menyimpan data dan menggunakannya semula dalam program.',
            explanationEN:
                'True! That is the main purpose of variables — to store data and reuse it in the program.',
          ),
          Exercise(
            id: 'u1l4e3',
            type: 'mcq',
            questionBM: 'Lihat kod ini:\nString warna = "merah";\nApakah jenis data yang digunakan?',
            questionEN: 'Look at this code:\nString warna = "merah";\nWhat data type is being used?',
            options: ['int', 'bool', 'String', 'double'],
            correctAnswer: '2',
            codeSample: 'String warna = "merah";',
            explanationBM:
                '"String" adalah jenis data untuk teks. Nilai "merah" adalah teks, jadi String digunakan.',
            explanationEN:
                '"String" is the data type for text. The value "merah" is text, so String is used.',
          ),
          Exercise(
            id: 'u1l4e4',
            type: 'mcq',
            questionBM: 'Manakah antara berikut bukan jenis data asas dalam pengaturcaraan?',
            questionEN: 'Which of the following is NOT a basic data type in programming?',
            options: ['int', 'String', 'bool', 'folder'],
            correctAnswer: '3',
            explanationBM:
                '"folder" bukan jenis data dalam pengaturcaraan. int, String, dan bool adalah jenis data asas.',
            explanationEN:
                '"folder" is not a data type in programming. int, String, and bool are basic data types.',
          ),
          Exercise(
            id: 'u1l4e5',
            type: 'truefalse',
            questionBM: 'Bahasa pengaturcaraan seperti Python dan Dart boleh digunakan untuk membuat aplikasi.',
            questionEN: 'Programming languages like Python and Dart can be used to build applications.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! Python, Dart, Java, dan banyak lagi bahasa pengaturcaraan digunakan untuk membina pelbagai aplikasi.',
            explanationEN:
                'True! Python, Dart, Java, and many more programming languages are used to build various applications.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────── UNIT 2 ───────────────────────────
  Unit(
    id: 'u2',
    titleBM: 'Logic & Syarat',
    titleEN: 'Logic & Conditions',
    emoji: '🔀',
    color: '#2196F3',
    lessons: [
      // ── Lesson 2-1 ──
      Lesson(
        id: 'u2l1',
        unitId: 'u2',
        titleBM: 'Betul & Salah',
        titleEN: 'True & False',
        descBM: 'Fahami logik boolean dalam pengaturcaraan.',
        descEN: 'Understand boolean logic in programming.',
        emoji: '✅',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u2l1e1',
            type: 'mcq',
            questionBM: 'Dalam logik pengaturcaraan, berapa nilai yang boleh dimiliki oleh boolean?',
            questionEN: 'In programming logic, how many values can a boolean have?',
            options: ['Satu', 'Dua', 'Tiga', 'Tidak terhad'],
            correctAnswer: '1',
            explanationBM:
                'Boolean hanya mempunyai dua nilai: true (benar) dan false (salah).',
            explanationEN:
                'Boolean only has two values: true and false.',
          ),
          Exercise(
            id: 'u2l1e2',
            type: 'truefalse',
            questionBM: '5 > 3 adalah benar (true).',
            questionEN: '5 > 3 is true.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! 5 adalah lebih besar daripada 3, jadi ungkapan 5 > 3 bernilai true.',
            explanationEN:
                'True! 5 is greater than 3, so the expression 5 > 3 evaluates to true.',
          ),
          Exercise(
            id: 'u2l1e3',
            type: 'mcq',
            questionBM: 'Jika bool isHujan = false; apakah nilai isHujan?',
            questionEN: 'If bool isRaining = false; what is the value of isRaining?',
            options: ['true', 'false', '0', 'null'],
            correctAnswer: '1',
            codeSample: 'bool isHujan = false;',
            explanationBM:
                'Nilai yang ditetapkan kepada isHujan adalah false. Ia bermaksud hari ini tidak hujan.',
            explanationEN:
                'The value assigned to isRaining is false. It means it is not raining today.',
          ),
          Exercise(
            id: 'u2l1e4',
            type: 'truefalse',
            questionBM: '10 == 10 menghasilkan nilai false.',
            questionEN: '10 == 10 produces the value false.',
            options: [],
            correctAnswer: 'false',
            explanationBM:
                'Salah! 10 == 10 adalah benar (true) kerana kedua-dua nilai adalah sama.',
            explanationEN:
                'False! 10 == 10 is true because both values are equal.',
          ),
          Exercise(
            id: 'u2l1e5',
            type: 'mcq',
            questionBM: 'Apakah hasil daripada: !true (NOT true)?',
            questionEN: 'What is the result of: !true (NOT true)?',
            options: ['true', 'false', '1', 'null'],
            correctAnswer: '1',
            explanationBM:
                'Operator ! (NOT) membalikkan nilai boolean. Jadi !true menjadi false.',
            explanationEN:
                'The ! (NOT) operator inverts a boolean value. So !true becomes false.',
          ),
        ],
      ),

      // ── Lesson 2-2 ──
      Lesson(
        id: 'u2l2',
        unitId: 'u2',
        titleBM: 'Jika... Maka...',
        titleEN: 'If...Then...',
        descBM: 'Belajar cara membuat keputusan dalam kod.',
        descEN: 'Learn how to make decisions in code.',
        emoji: '🤷',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u2l2e1',
            type: 'mcq',
            questionBM: 'Apakah kegunaan pernyataan "if" dalam pengaturcaraan?',
            questionEN: 'What is the purpose of the "if" statement in programming?',
            options: [
              'Untuk menyimpan data',
              'Untuk membuat keputusan berdasarkan syarat',
              'Untuk memapar teks',
              'Untuk mengira nombor',
            ],
            correctAnswer: '1',
            explanationBM:
                'Pernyataan "if" membolehkan program membuat keputusan — jika syarat dipenuhi, lakukan sesuatu tindakan.',
            explanationEN:
                '"if" statement allows a program to make decisions — if a condition is met, perform an action.',
          ),
          Exercise(
            id: 'u2l2e2',
            type: 'truefalse',
            questionBM: 'Blok "else" akan dijalankan apabila syarat "if" adalah false.',
            questionEN: 'The "else" block will run when the "if" condition is false.',
            options: [],
            correctAnswer: 'true',
            codeSample: 'if (hujan) {\n  bawaBayung();\n} else {\n  pakaiSunglasses();\n}',
            explanationBM:
                'Betul! "else" adalah pilihan alternatif — ia dijalankan hanya apabila syarat "if" tidak dipenuhi.',
            explanationEN:
                'True! "else" is the alternative — it runs only when the "if" condition is not met.',
          ),
          Exercise(
            id: 'u2l2e3',
            type: 'mcq',
            questionBM: 'Lihat kod berikut. Bila akan "Lulus!" dipaparkan?\n\nif (markah >= 50) {\n  print("Lulus!");\n}',
            questionEN: 'Look at this code. When will "Pass!" be displayed?\n\nif (score >= 50) {\n  print("Pass!");\n}',
            options: [
              'Bila markah kurang dari 50',
              'Bila markah sama dengan 0',
              'Bila markah 50 atau lebih',
              'Sentiasa dipaparkan',
            ],
            correctAnswer: '2',
            codeSample: 'if (markah >= 50) {\n  print("Lulus!");\n}',
            explanationBM:
                '"Lulus!" akan dipaparkan hanya apabila nilai markah adalah 50 atau lebih tinggi (>= bermaksud lebih besar atau sama).',
            explanationEN:
                '"Pass!" will be displayed only when the score value is 50 or higher (>= means greater than or equal to).',
          ),
          Exercise(
            id: 'u2l2e4',
            type: 'mcq',
            questionBM: 'Apakah fungsi "else if" dalam kod?',
            questionEN: 'What does "else if" do in code?',
            options: [
              'Mengakhiri program',
              'Menyemak syarat tambahan jika syarat pertama gagal',
              'Mengulangi kod',
              'Menyimpan data',
            ],
            correctAnswer: '1',
            explanationBM:
                '"else if" digunakan untuk menyemak syarat kedua (atau lebih) jika syarat pertama tidak dipenuhi.',
            explanationEN:
                '"else if" is used to check a second (or more) condition if the first condition is not met.',
          ),
          Exercise(
            id: 'u2l2e5',
            type: 'truefalse',
            questionBM: 'Kod di dalam blok if akan sentiasa dijalankan tanpa mengira syarat.',
            questionEN: 'Code inside an if block will always run regardless of the condition.',
            options: [],
            correctAnswer: 'false',
            explanationBM:
                'Salah! Kod di dalam blok if HANYA dijalankan jika syaratnya adalah true. Itulah tujuan if!',
            explanationEN:
                'False! Code inside an if block ONLY runs if the condition is true. That is the whole point of if!',
          ),
        ],
      ),

      // ── Lesson 2-3 ──
      Lesson(
        id: 'u2l3',
        unitId: 'u2',
        titleBM: 'Bandingkan',
        titleEN: 'Compare',
        descBM: 'Belajar cara membandingkan nilai menggunakan operator perbandingan.',
        descEN: 'Learn how to compare values using comparison operators.',
        emoji: '⚖️',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u2l3e1',
            type: 'mcq',
            questionBM: 'Apakah maksud operator "==" dalam pengaturcaraan?',
            questionEN: 'What does the "==" operator mean in programming?',
            options: [
              'Tetapkan nilai',
              'Periksa sama ada dua nilai adalah sama',
              'Tambah dua nilai',
              'Bahagikan dua nilai',
            ],
            correctAnswer: '1',
            explanationBM:
                '"==" adalah operator persamaan. Ia memeriksa sama ada dua nilai adalah sama, dan menghasilkan true atau false.',
            explanationEN:
                '"==" is the equality operator. It checks if two values are equal, and returns true or false.',
          ),
          Exercise(
            id: 'u2l3e2',
            type: 'truefalse',
            questionBM: '3 != 5 menghasilkan true (kerana 3 tidak sama dengan 5).',
            questionEN: '3 != 5 produces true (because 3 is not equal to 5).',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! "!=" bermaksud "tidak sama dengan". Kerana 3 memang tidak sama dengan 5, hasilnya adalah true.',
            explanationEN:
                'True! "!=" means "not equal to". Since 3 is indeed not equal to 5, the result is true.',
          ),
          Exercise(
            id: 'u2l3e3',
            type: 'mcq',
            questionBM: 'Operator manakah yang bermaksud "lebih besar daripada atau sama dengan"?',
            questionEN: 'Which operator means "greater than or equal to"?',
            options: ['>', '<', '>=', '<='],
            correctAnswer: '2',
            explanationBM:
                '">=" bermaksud lebih besar daripada atau sama dengan. Contoh: 5 >= 5 adalah true, dan 6 >= 5 juga true.',
            explanationEN:
                '">=" means greater than or equal to. Example: 5 >= 5 is true, and 6 >= 5 is also true.',
          ),
          Exercise(
            id: 'u2l3e4',
            type: 'mcq',
            questionBM: 'Apakah hasil daripada: 10 < 8?',
            questionEN: 'What is the result of: 10 < 8?',
            options: ['true', 'false', '2', 'error'],
            correctAnswer: '1',
            explanationBM:
                '10 < 8 adalah false kerana 10 adalah lebih besar daripada 8, bukan lebih kecil.',
            explanationEN:
                '10 < 8 is false because 10 is greater than 8, not less than.',
          ),
          Exercise(
            id: 'u2l3e5',
            type: 'truefalse',
            questionBM: '"=" dan "==" mempunyai fungsi yang sama dalam pengaturcaraan.',
            questionEN: '"=" and "==" have the same function in programming.',
            options: [],
            correctAnswer: 'false',
            codeSample: 'int x = 5;   // tetapkan nilai\nif (x == 5)  // semak sama ada sama',
            explanationBM:
                'Salah! "=" digunakan untuk menetapkan nilai kepada pemboleh ubah. "==" digunakan untuk menyemak sama ada dua nilai adalah sama.',
            explanationEN:
                'False! "=" is used to assign a value to a variable. "==" is used to check if two values are equal.',
          ),
        ],
      ),

      // ── Lesson 2-4 (Challenge) ──
      Lesson(
        id: 'u2l4',
        unitId: 'u2',
        titleBM: 'Cabaran Unit 2',
        titleEN: 'Unit 2 Challenge',
        descBM: 'Uji kefahaman anda tentang logik dan syarat!',
        descEN: 'Test your understanding of logic and conditions!',
        emoji: '🏆',
        xpReward: 30,
        exercises: [
          Exercise(
            id: 'u2l4e1',
            type: 'mcq',
            questionBM: 'Kod berikut akan mencetak apa?\n\nint markah = 75;\nif (markah >= 80) {\n  print("Cemerlang");\n} else {\n  print("Baik");\n}',
            questionEN: 'What will this code print?\n\nint score = 75;\nif (score >= 80) {\n  print("Excellent");\n} else {\n  print("Good");\n}',
            options: ['Cemerlang / Excellent', 'Baik / Good', 'Tiada output', 'Error'],
            correctAnswer: '1',
            codeSample: 'int markah = 75;\nif (markah >= 80) {\n  print("Cemerlang");\n} else {\n  print("Baik");\n}',
            explanationBM:
                'Markah adalah 75, yang kurang daripada 80. Jadi syarat if gagal dan blok else ("Baik") dijalankan.',
            explanationEN:
                'The score is 75, which is less than 80. So the if condition fails and the else block ("Good") runs.',
          ),
          Exercise(
            id: 'u2l4e2',
            type: 'truefalse',
            questionBM: 'Operator ">" bermaksud "lebih kecil daripada".',
            questionEN: 'The ">" operator means "less than".',
            options: [],
            correctAnswer: 'false',
            explanationBM:
                'Salah! ">" bermaksud "lebih besar daripada". Operator "kurang daripada" adalah "<".',
            explanationEN:
                'False! ">" means "greater than". The "less than" operator is "<".',
          ),
          Exercise(
            id: 'u2l4e3',
            type: 'mcq',
            questionBM: 'Manakah antara berikut yang menghasilkan true?',
            questionEN: 'Which of the following produces true?',
            options: ['5 == 6', '3 > 10', '7 != 8', '4 < 2'],
            correctAnswer: '2',
            explanationBM:
                '7 != 8 adalah true kerana 7 memang tidak sama dengan 8. Yang lain semuanya false.',
            explanationEN:
                '7 != 8 is true because 7 is indeed not equal to 8. All others are false.',
          ),
          Exercise(
            id: 'u2l4e4',
            type: 'mcq',
            questionBM: 'Apakah kegunaan pernyataan "if-else" dalam pengaturcaraan?',
            questionEN: 'What is the purpose of the "if-else" statement in programming?',
            options: [
              'Mengulangi kod',
              'Membuat pilihan antara dua laluan berbeza',
              'Menyimpan data dalam fail',
              'Mengira purata',
            ],
            correctAnswer: '1',
            explanationBM:
                '"if-else" membolehkan program memilih antara dua tindakan bergantung kepada sama ada syarat adalah true atau false.',
            explanationEN:
                '"if-else" allows a program to choose between two actions depending on whether the condition is true or false.',
          ),
          Exercise(
            id: 'u2l4e5',
            type: 'truefalse',
            questionBM: 'bool aktif = (10 > 5); — Nilai aktif adalah true.',
            questionEN: 'bool active = (10 > 5); — The value of active is true.',
            options: [],
            correctAnswer: 'true',
            codeSample: 'bool aktif = (10 > 5);',
            explanationBM:
                'Betul! 10 > 5 adalah benar (true), jadi pemboleh ubah aktif disimpan dengan nilai true.',
            explanationEN:
                'True! 10 > 5 is true, so the variable active is stored with the value true.',
          ),
        ],
      ),
    ],
  ),

  // ─────────────────────────── UNIT 3 ───────────────────────────
  Unit(
    id: 'u3',
    titleBM: 'Gelung',
    titleEN: 'Loops',
    emoji: '🔄',
    color: '#FF9800',
    lessons: [
      // ── Lesson 3-1 ──
      Lesson(
        id: 'u3l1',
        unitId: 'u3',
        titleBM: 'Pengulangan',
        titleEN: 'Repetition',
        descBM: 'Fahami mengapa gelung penting dalam pengaturcaraan.',
        descEN: 'Understand why loops are important in programming.',
        emoji: '🔁',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u3l1e1',
            type: 'mcq',
            questionBM: 'Apakah fungsi utama gelung (loop) dalam pengaturcaraan?',
            questionEN: 'What is the main function of a loop in programming?',
            options: [
              'Menyimpan data',
              'Mengulangi tindakan beberapa kali',
              'Membuat keputusan',
              'Memapar teks',
            ],
            correctAnswer: '1',
            explanationBM:
                'Gelung digunakan untuk mengulangi satu blok kod beberapa kali tanpa menulis kod yang sama berulang kali.',
            explanationEN:
                'A loop is used to repeat a block of code multiple times without writing the same code over and over.',
          ),
          Exercise(
            id: 'u3l1e2',
            type: 'truefalse',
            questionBM: 'Tanpa gelung, kita perlu menulis print("Hello") sebanyak 100 kali untuk mencetak "Hello" 100 kali.',
            questionEN: 'Without loops, we would need to write print("Hello") 100 times to print "Hello" 100 times.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! Itulah sebabnya gelung sangat berguna — ia menjimatkan masa dan mengelakkan kod yang berulang.',
            explanationEN:
                'True! That is why loops are so useful — they save time and avoid repetitive code.',
          ),
          Exercise(
            id: 'u3l1e3',
            type: 'mcq',
            questionBM: 'Apakah yang dimaksudkan dengan "iterasi" dalam konteks gelung?',
            questionEN: 'What does "iteration" mean in the context of loops?',
            options: [
              'Menghentikan program',
              'Satu pusingan pelaksanaan dalam gelung',
              'Jenis pemboleh ubah',
              'Operator matematik',
            ],
            correctAnswer: '1',
            explanationBM:
                'Iterasi merujuk kepada satu pusingan atau satu ulangan dalam gelung. Jika gelung berjalan 5 kali, ia mempunyai 5 iterasi.',
            explanationEN:
                'Iteration refers to one round or one repetition in a loop. If a loop runs 5 times, it has 5 iterations.',
          ),
          Exercise(
            id: 'u3l1e4',
            type: 'mcq',
            questionBM: 'Dua jenis gelung yang paling biasa dalam pengaturcaraan adalah?',
            questionEN: 'The two most common types of loops in programming are?',
            options: [
              'if dan else',
              'true dan false',
              'while dan for',
              'start dan stop',
            ],
            correctAnswer: '2',
            explanationBM:
                '"while" dan "for" adalah dua jenis gelung yang paling biasa. Kedua-duanya mengulangi kod, tetapi dengan cara yang sedikit berbeza.',
            explanationEN:
                '"while" and "for" are the two most common loop types. Both repeat code, but in slightly different ways.',
          ),
          Exercise(
            id: 'u3l1e5',
            type: 'truefalse',
            questionBM: 'Gelung tanpa had akhir (infinite loop) adalah sesuatu yang kita inginkan dalam program.',
            questionEN: 'An infinite loop (loop without an end condition) is something we want in a program.',
            options: [],
            correctAnswer: 'false',
            explanationBM:
                'Salah! Infinite loop menyebabkan program tersekat dan tidak berhenti. Kita sentiasa mesti pastikan gelung ada syarat untuk berhenti.',
            explanationEN:
                'False! An infinite loop causes the program to get stuck and never stop. We must always make sure loops have a stop condition.',
          ),
        ],
      ),

      // ── Lesson 3-2 ──
      Lesson(
        id: 'u3l2',
        unitId: 'u3',
        titleBM: 'While Loop',
        titleEN: 'While Loop',
        descBM: 'Belajar cara menggunakan while loop.',
        descEN: 'Learn how to use the while loop.',
        emoji: '⏳',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u3l2e1',
            type: 'mcq',
            questionBM: 'Gelung while akan terus berjalan selagi?',
            questionEN: 'A while loop will keep running as long as?',
            options: [
              'Komputer dihidupkan',
              'Syaratnya adalah true',
              'Syaratnya adalah false',
              'Tiada pemboleh ubah',
            ],
            correctAnswer: '1',
            codeSample: 'while (syarat) {\n  // kod diulang\n}',
            explanationBM:
                'Gelung while memeriksa syarat sebelum setiap ulangan. Ia terus berjalan selagi syarat adalah true.',
            explanationEN:
                'A while loop checks the condition before each repetition. It keeps running as long as the condition is true.',
          ),
          Exercise(
            id: 'u3l2e2',
            type: 'truefalse',
            questionBM: 'Kod berikut akan mencetak "1 2 3 4 5":\n\nint i = 1;\nwhile (i <= 5) {\n  print(i);\n  i++;\n}',
            questionEN: 'This code will print "1 2 3 4 5":\n\nint i = 1;\nwhile (i <= 5) {\n  print(i);\n  i++;\n}',
            options: [],
            correctAnswer: 'true',
            codeSample: 'int i = 1;\nwhile (i <= 5) {\n  print(i);\n  i++;\n}',
            explanationBM:
                'Betul! Gelung bermula di i=1, mencetak nilai i, kemudian menambah i sebanyak 1 (i++). Ia berhenti apabila i > 5.',
            explanationEN:
                'True! The loop starts at i=1, prints i, then increases i by 1 (i++). It stops when i > 5.',
          ),
          Exercise(
            id: 'u3l2e3',
            type: 'mcq',
            questionBM: 'Apakah "i++" dalam konteks gelung?',
            questionEN: 'What is "i++" in the context of a loop?',
            options: [
              'Mengurangkan i sebanyak 1',
              'Menambah i sebanyak 1',
              'Menetapkan i kepada 0',
              'Mencetak nilai i',
            ],
            correctAnswer: '1',
            explanationBM:
                '"i++" adalah singkatan untuk i = i + 1. Ia menambah nilai i sebanyak 1 setiap kali dijalankan.',
            explanationEN:
                '"i++" is shorthand for i = i + 1. It increases the value of i by 1 each time it runs.',
          ),
          Exercise(
            id: 'u3l2e4',
            type: 'mcq',
            questionBM: 'Berapa kali gelung berikut akan berjalan?\n\nint i = 0;\nwhile (i < 3) {\n  i++;\n}',
            questionEN: 'How many times will this loop run?\n\nint i = 0;\nwhile (i < 3) {\n  i++;\n}',
            options: ['2 kali / 2 times', '3 kali / 3 times', '4 kali / 4 times', 'Tidak pernah / Never'],
            correctAnswer: '1',
            codeSample: 'int i = 0;\nwhile (i < 3) {\n  i++;\n}',
            explanationBM:
                'Gelung berjalan apabila i=0, i=1, i=2 (3 kali). Apabila i=3, syarat i<3 adalah false dan gelung berhenti.',
            explanationEN:
                'The loop runs when i=0, i=1, i=2 (3 times). When i=3, the condition i<3 is false and the loop stops.',
          ),
          Exercise(
            id: 'u3l2e5',
            type: 'truefalse',
            questionBM: 'Jika syarat while loop adalah sentiasa true, gelung akan berjalan selama-lamanya (infinite loop).',
            questionEN: 'If the while loop condition is always true, the loop will run forever (infinite loop).',
            options: [],
            correctAnswer: 'true',
            codeSample: '// Infinite loop — elakkan ini!\nwhile (true) {\n  print("Hello");\n}',
            explanationBM:
                'Betul! while (true) akan berjalan selama-lamanya. Pastikan syarat gelung anda akan menjadi false pada suatu masa.',
            explanationEN:
                'True! while (true) will run forever. Make sure your loop condition will eventually become false.',
          ),
        ],
      ),

      // ── Lesson 3-3 ──
      Lesson(
        id: 'u3l3',
        unitId: 'u3',
        titleBM: 'For Loop',
        titleEN: 'For Loop',
        descBM: 'Belajar cara menggunakan for loop.',
        descEN: 'Learn how to use the for loop.',
        emoji: '🔢',
        xpReward: 20,
        exercises: [
          Exercise(
            id: 'u3l3e1',
            type: 'mcq',
            questionBM: 'Apakah tiga bahagian dalam gelung for?\n\nfor (mulakan; syarat; kemas kini)',
            questionEN: 'What are the three parts of a for loop?\n\nfor (initialize; condition; update)',
            options: [
              'Nama, nilai, jenis',
              'Permulaan, syarat, kemas kini',
              'Input, proses, output',
              'Mula, tengah, akhir',
            ],
            correctAnswer: '1',
            codeSample: 'for (int i = 0; i < 5; i++) {\n  // kod\n}',
            explanationBM:
                'Gelung for terdiri daripada: (1) permulaan (int i=0), (2) syarat (i<5), dan (3) kemas kini (i++).',
            explanationEN:
                'A for loop consists of: (1) initialization (int i=0), (2) condition (i<5), and (3) update (i++).',
          ),
          Exercise(
            id: 'u3l3e2',
            type: 'truefalse',
            questionBM: 'Gelung for lebih sesuai apabila kita tahu berapa kali gelung perlu diulang.',
            questionEN: 'A for loop is more suitable when we know how many times the loop needs to repeat.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! for loop biasanya digunakan apabila bilangan ulangan sudah diketahui. while loop lebih sesuai apabila bilangan ulangan bergantung kepada syarat.',
            explanationEN:
                'True! A for loop is typically used when the number of repetitions is already known. A while loop is more suitable when the number depends on a condition.',
          ),
          Exercise(
            id: 'u3l3e3',
            type: 'mcq',
            questionBM: 'Berapa kali gelung ini berjalan?\n\nfor (int i = 1; i <= 4; i++) {\n  print(i);\n}',
            questionEN: 'How many times does this loop run?\n\nfor (int i = 1; i <= 4; i++) {\n  print(i);\n}',
            options: ['3 kali / 3 times', '4 kali / 4 times', '5 kali / 5 times', '1 kali / 1 time'],
            correctAnswer: '1',
            codeSample: 'for (int i = 1; i <= 4; i++) {\n  print(i);\n}',
            explanationBM:
                'Gelung berjalan apabila i=1, 2, 3, 4 — iaitu 4 kali. Ia berhenti apabila i=5 (kerana 5 <= 4 adalah false).',
            explanationEN:
                'The loop runs when i=1, 2, 3, 4 — that is 4 times. It stops when i=5 (because 5 <= 4 is false).',
          ),
          Exercise(
            id: 'u3l3e4',
            type: 'mcq',
            questionBM: 'Apakah kegunaan gelung for untuk senarai (list) dalam pengaturcaraan?',
            questionEN: 'What is the use of a for loop for a list in programming?',
            options: [
              'Menghapus senarai',
              'Mengakses setiap elemen dalam senarai satu per satu',
              'Menambah elemen baharu',
              'Menyusun senarai',
            ],
            correctAnswer: '1',
            codeSample: 'List<String> buah = ["Epal", "Mangga", "Betik"];\nfor (int i = 0; i < buah.length; i++) {\n  print(buah[i]);\n}',
            explanationBM:
                'Gelung for sangat berguna untuk mengakses setiap elemen dalam senarai, satu per satu, dari mula hingga akhir.',
            explanationEN:
                'A for loop is very useful for accessing each element in a list, one by one, from start to end.',
          ),
          Exercise(
            id: 'u3l3e5',
            type: 'truefalse',
            questionBM: 'Gelung for dan while boleh melakukan perkara yang sama, hanya sintaksnya berbeza.',
            questionEN: 'For loops and while loops can do the same things, just with different syntax.',
            options: [],
            correctAnswer: 'true',
            explanationBM:
                'Betul! Kedua-dua jenis gelung boleh melakukan pengulangan yang sama. Pilihan bergantung kepada situasi dan gaya penulisan kod.',
            explanationEN:
                'True! Both types of loops can perform the same repetitions. The choice depends on the situation and coding style.',
          ),
        ],
      ),

      // ── Lesson 3-4 (Challenge) ──
      Lesson(
        id: 'u3l4',
        unitId: 'u3',
        titleBM: 'Cabaran Unit 3',
        titleEN: 'Unit 3 Challenge',
        descBM: 'Uji kefahaman anda tentang gelung!',
        descEN: 'Test your understanding of loops!',
        emoji: '🏆',
        xpReward: 30,
        exercises: [
          Exercise(
            id: 'u3l4e1',
            type: 'mcq',
            questionBM: 'Apakah output kod berikut?\n\nfor (int i = 0; i < 3; i++) {\n  print("Go!");\n}',
            questionEN: 'What is the output of this code?\n\nfor (int i = 0; i < 3; i++) {\n  print("Go!");\n}',
            options: [
              '"Go!" sekali / once',
              '"Go!" dua kali / twice',
              '"Go!" tiga kali / three times',
              '"Go!" tiada / not at all',
            ],
            correctAnswer: '2',
            codeSample: 'for (int i = 0; i < 3; i++) {\n  print("Go!");\n}',
            explanationBM:
                'Gelung berjalan apabila i=0, 1, 2 (3 kali). Jadi "Go!" dicetak tiga kali.',
            explanationEN:
                'The loop runs when i=0, 1, 2 (3 times). So "Go!" is printed three times.',
          ),
          Exercise(
            id: 'u3l4e2',
            type: 'truefalse',
            questionBM: 'while loop memeriksa syaratnya SELEPAS menjalankan blok kod (post-check).',
            questionEN: 'A while loop checks its condition AFTER running the code block (post-check).',
            options: [],
            correctAnswer: 'false',
            explanationBM:
                'Salah! while loop memeriksa syaratnya SEBELUM menjalankan blok kod. Jika syarat false dari awal, kod tidak akan dijalankan langsung.',
            explanationEN:
                'False! A while loop checks its condition BEFORE running the code block. If the condition is false from the start, the code will never run.',
          ),
          Exercise(
            id: 'u3l4e3',
            type: 'mcq',
            questionBM: 'Apakah perbezaan utama antara for loop dan while loop?',
            questionEN: 'What is the main difference between a for loop and a while loop?',
            options: [
              'For loop lebih pantas / For loops are faster',
              'For loop biasanya digunakan bila bilangan ulangan diketahui / For is typically used when the number of repetitions is known',
              'While loop tidak boleh digunakan / While loops cannot be used',
              'Tiada perbezaan langsung / No difference at all',
            ],
            correctAnswer: '1',
            explanationBM:
                'For loop paling sesuai apabila bilangan ulangan diketahui terlebih dahulu. While loop lebih fleksibel untuk syarat yang tidak diketahui hadnya.',
            explanationEN:
                'For loops are best when the number of repetitions is known in advance. While loops are more flexible for conditions with unknown boundaries.',
          ),
          Exercise(
            id: 'u3l4e4',
            type: 'mcq',
            questionBM: 'Apakah yang berlaku jika anda terlupa untuk mengemas kini pemboleh ubah dalam gelung?',
            questionEN: 'What happens if you forget to update the variable in a loop?',
            options: [
              'Program berjalan lebih laju',
              'Program mungkin terperangkap dalam infinite loop',
              'Program berhenti serta-merta',
              'Tiada kesan',
            ],
            correctAnswer: '1',
            explanationBM:
                'Jika pemboleh ubah gelung tidak dikemas kini, syarat mungkin tidak pernah menjadi false, menyebabkan infinite loop.',
            explanationEN:
                'If the loop variable is not updated, the condition may never become false, causing an infinite loop.',
          ),
          Exercise(
            id: 'u3l4e5',
            type: 'truefalse',
            questionBM: 'Gelung boleh diletakkan di dalam gelung lain (nested loops).',
            questionEN: 'Loops can be placed inside other loops (nested loops).',
            options: [],
            correctAnswer: 'true',
            codeSample: 'for (int i = 1; i <= 3; i++) {\n  for (int j = 1; j <= 3; j++) {\n    print(i * j);\n  }\n}',
            explanationBM:
                'Betul! Nested loops (gelung bersarang) adalah apabila satu gelung berada di dalam gelung lain. Ia berguna untuk data berbilang dimensi.',
            explanationEN:
                'True! Nested loops are when one loop is inside another. They are useful for multi-dimensional data.',
          ),
        ],
      ),
    ],
  ),
];
