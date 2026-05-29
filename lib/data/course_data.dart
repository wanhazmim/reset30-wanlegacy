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
        slides: [
          LearnSlide(
            emoji: '🖥️',
            titleBM: 'Apa itu Coding?',
            titleEN: 'What is Coding?',
            bodyBM: 'Coding (atau pengaturcaraan) adalah cara kita memberi ARAHAN kepada komputer.\n\nSama seperti kita bagi arahan kepada orang — "pergi ke kedai, beli susu" — kita bagi arahan kepada komputer menggunakan bahasa khas yang difahaminya.',
            bodyEN: 'Coding (or programming) is how we give INSTRUCTIONS to a computer.\n\nJust like we give instructions to people — "go to the shop, buy milk" — we give instructions to the computer using a special language it understands.',
          ),
          LearnSlide(
            emoji: '🗣️',
            titleBM: 'Bahasa Pengaturcaraan',
            titleEN: 'Programming Languages',
            bodyBM: 'Komputer tidak faham bahasa Melayu atau Inggeris. Ia memerlukan bahasa khas seperti:\n\n🐍 Python — mudah untuk pemula\n☕ JavaScript — untuk laman web\n📱 Dart — untuk apps phone\n\nDalam kursus ini, kita akan guna Python sebagai contoh!',
            bodyEN: 'Computers don\'t understand Malay or English. They need special languages like:\n\n🐍 Python — easy for beginners\n☕ JavaScript — for websites\n📱 Dart — for phone apps\n\nIn this course, we\'ll use Python as examples!',
          ),
          LearnSlide(
            emoji: '👋',
            titleBM: 'Program Pertama Kamu',
            titleEN: 'Your First Program',
            bodyBM: 'Program paling mudah dalam dunia adalah "Hello, World!" — ia hanya mencetak teks ke skrin.\n\nCuba tengok kod di bawah. Ia memberitahu komputer: "Tunjukkan perkataan Hello, World!"',
            bodyEN: 'The simplest program in the world is "Hello, World!" — it just prints text to the screen.\n\nLook at the code below. It tells the computer: "Show the words Hello, World!"',
            codeExample: '# Program pertama saya\nprint("Hello, World!")\n\n# Output:\n# Hello, World!',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '📦',
            titleBM: 'Apa itu Pemboleh Ubah?',
            titleEN: 'What is a Variable?',
            bodyBM: 'Bayangkan pemboleh ubah sebagai sebuah KOTAK berlabel.\n\nKotak itu boleh menyimpan sebarang nilai — nombor, nama, atau teks. Label pada kotak itu adalah NAMA pemboleh ubah kita.',
            bodyEN: 'Think of a variable as a labeled BOX.\n\nThe box can store any value — a number, a name, or some text. The label on the box is the NAME of our variable.',
          ),
          LearnSlide(
            emoji: '✏️',
            titleBM: 'Cara Buat Pemboleh Ubah',
            titleEN: 'How to Create a Variable',
            bodyBM: 'Dalam Python, cara paling mudah untuk buat pemboleh ubah adalah:\n\n  nama = nilai\n\nTanda "=" bermakna "SIMPAN nilai ini dalam pemboleh ubah ini".',
            bodyEN: 'In Python, the easiest way to create a variable is:\n\n  name = value\n\nThe "=" sign means "STORE this value in this variable".',
            codeExample: '# Simpan umur saya\numur = 20\n\n# Simpan nama saya\nnama = "Ali"\n\n# Cetak nilai\nprint(umur)   # Output: 20\nprint(nama)   # Output: Ali',
          ),
          LearnSlide(
            emoji: '🔄',
            titleBM: 'Ubah Nilai Pemboleh Ubah',
            titleEN: 'Changing Variable Values',
            bodyBM: 'Nilai dalam pemboleh ubah boleh DIUBAH pada bila-bila masa. Itulah sebabnya ia dipanggil "pemboleh ubah" — nilainya boleh berubah!',
            bodyEN: 'The value in a variable can be CHANGED at any time. That\'s why it\'s called a "variable" — its value can vary!',
            codeExample: '# Mula dengan 10\npoin = 10\nprint(poin)   # Output: 10\n\n# Kemas kini kepada 25\npoin = 25\nprint(poin)   # Output: 25',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🔢',
            titleBM: 'Nombor (Integer & Float)',
            titleEN: 'Numbers (Integer & Float)',
            bodyBM: 'Dalam pengaturcaraan, ada DUA jenis nombor:\n\n• Integer (int) — nombor BULAT tanpa titik perpuluhan\n• Float — nombor dengan titik perpuluhan\n\nGuna int untuk kiraan, float untuk ukuran tepat.',
            bodyEN: 'In programming, there are TWO types of numbers:\n\n• Integer (int) — WHOLE numbers without decimal point\n• Float — numbers WITH decimal point\n\nUse int for counting, float for precise measurements.',
            codeExample: 'umur = 20          # int\ntinggi = 1.75      # float\nprint(type(umur))  # <class "int">\nprint(type(tinggi))# <class "float">',
          ),
          LearnSlide(
            emoji: '📝',
            titleBM: 'Teks (String)',
            titleEN: 'Text (String)',
            bodyBM: 'String adalah jenis data untuk menyimpan TEKS — perkataan, ayat, atau sebarang aksara.\n\nString sentiasa ditulis di dalam tanda petik " " atau \' \'.',
            bodyEN: 'String is the data type for storing TEXT — words, sentences, or any characters.\n\nStrings are always written inside quotation marks " " or \' \'.',
            codeExample: 'nama = "Ahmad"\nsalam = \'Hello, World!\'\n\nprint(nama)   # Ahmad\nprint(salam)  # Hello, World!',
          ),
          LearnSlide(
            emoji: '✅',
            titleBM: 'Benar/Palsu (Boolean)',
            titleEN: 'True/False (Boolean)',
            bodyBM: 'Boolean hanya ada DUA nilai: True atau False.\n\nIa digunakan apabila kita perlu membuat KEPUTUSAN dalam program — contohnya, adakah pengguna sudah log masuk?',
            bodyEN: 'Boolean only has TWO values: True or False.\n\nIt\'s used when we need to make DECISIONS in a program — for example, is the user logged in?',
            codeExample: 'sudah_makan = True\nhujan = False\n\nprint(sudah_makan)  # True\nprint(hujan)        # False',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🏆',
            titleBM: 'Masa untuk Cabaran!',
            titleEN: 'Time for a Challenge!',
            bodyBM: 'Tahniah kerana berjaya habiskan Unit 1!\n\nSekarang kita akan uji semua yang telah kamu pelajari:\n✅ Apa itu coding\n✅ Pemboleh ubah\n✅ Jenis data\n\nSiap? Jom mulakan!',
            bodyEN: 'Congratulations for completing Unit 1!\n\nNow let\'s test everything you\'ve learned:\n✅ What is coding\n✅ Variables\n✅ Data types\n\nReady? Let\'s go!',
          ),
        ],
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
  // ─────────────────────────── UNIT 4 (Web Asas) ───────────────────────────
  Unit(
    id: 'u4',
    titleBM: 'Web Asas (HTML/CSS/JS)',
    titleEN: 'Web Basics (HTML/CSS/JS)',
    emoji: '🌐',
    color: '#9C27B0',
    lessons: [
      Lesson(
        id: 'u4l1',
        unitId: 'u4',
        titleBM: 'Pengenalan HTML',
        titleEN: 'Intro to HTML',
        descBM: 'Belajar struktur asas halaman web dengan HTML.',
        descEN: 'Learn basic web page structure with HTML.',
        emoji: '🔤',
        xpReward: 25,
        slides: [
          LearnSlide(
            emoji: '📄',
            titleBM: 'Apa itu HTML?',
            titleEN: 'What is HTML?',
            bodyBM: 'HTML adalah bahasa untuk struktur halaman web. Ia menggunakan "tag" untuk memberitahu pelayar apa yang harus dipaparkan seperti tajuk, perenggan, dan pautan.',
            bodyEN: 'HTML is the language for web page structure. It uses "tags" to tell the browser what to display like headings, paragraphs, and links.',
            codeExample: '<!DOCTYPE html>\n<html>\n  <head><title>Halaman Saya</title></head>\n  <body>\n    <h1>Helo Dunia</h1>\n    <p>Ini adalah paragraf.</p>\n  </body>\n</html>',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u4l1e1',
            type: 'mcq',
            questionBM: 'Tag HTML manakah digunakan untuk tajuk utama?',
            questionEN: 'Which HTML tag is used for the main heading?',
            options: ['<p>', '<h1>', '<div>', '<a>'],
            correctAnswer: '1',
            explanationBM: '<h1> digunakan untuk tajuk utama halaman.',
            explanationEN: '<h1> is used for the main heading of a page.',
          ),
        ],
      ),

      Lesson(
        id: 'u4l2',
        unitId: 'u4',
        titleBM: 'Gaya Dengan CSS',
        titleEN: 'Styling with CSS',
        descBM: 'Tambah gaya dan warna ke halaman web menggunakan CSS.',
        descEN: 'Add style and color to web pages using CSS.',
        emoji: '🎨',
        xpReward: 25,
        slides: [
          LearnSlide(
            emoji: '🎨',
            titleBM: 'Apa itu CSS?',
            titleEN: 'What is CSS?',
            bodyBM: 'CSS (Cascading Style Sheets) mengawal rupa halaman — warna, fon, jarak, dan susun atur. HTML adalah struktur; CSS adalah gaya.',
            bodyEN: 'CSS controls how the page looks — colors, fonts, spacing, and layout. HTML is structure; CSS is style.',
            codeExample: 'h1 {\n  color: #4CAF50;\n  font-size: 28px;\n}',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u4l2e1',
            type: 'mcq',
            questionBM: 'CSS digunakan untuk?',
            questionEN: 'CSS is used for?',
            options: ['Struktur halaman', 'Gaya dan susun atur', 'Menjalankan kod di pelayan', 'Menyimpan data'],
            correctAnswer: '1',
            explanationBM: 'CSS digunakan untuk memberi gaya kepada elemen HTML.',
            explanationEN: 'CSS is used to style HTML elements.',
          ),
        ],
      ),

      Lesson(
        id: 'u4l3',
        unitId: 'u4',
        titleBM: 'Interaktif Dengan JavaScript',
        titleEN: 'Interactivity with JavaScript',
        descBM: 'Tambah interaksi seperti klik butang menggunakan JavaScript.',
        descEN: 'Add interactions like button clicks using JavaScript.',
        emoji: '⚡',
        xpReward: 30,
        slides: [
          LearnSlide(
            emoji: '⚡',
            titleBM: 'Apa itu JavaScript?',
            titleEN: 'What is JavaScript?',
            bodyBM: 'JavaScript adalah bahasa yang membuat halaman web menjadi interaktif — mengendalikan klik, menukar kandungan, dan banyak lagi.',
            bodyEN: 'JavaScript is the language that makes web pages interactive — handling clicks, changing content, and more.',
            codeExample: '<button onclick="alert(\'Helo\')">Klik Saya</button>',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u4l3e1',
            type: 'mcq',
            questionBM: 'JavaScript biasanya digunakan untuk?',
            questionEN: 'JavaScript is typically used for?',
            options: ['Menambah gaya', 'Membuat interaksi dinamik', 'Menyusun data di server', 'Menetapkan struktur dokumen'],
            correctAnswer: '1',
            explanationBM: 'JavaScript membuat halaman web menjadi interaktif dan dinamik.',
            explanationEN: 'JavaScript makes web pages interactive and dynamic.',
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
        slides: [
          LearnSlide(
            emoji: '🔘',
            titleBM: 'Boolean — Hanya Dua Nilai',
            titleEN: 'Boolean — Only Two Values',
            bodyBM: 'Boolean adalah jenis data yang paling mudah — ia hanya ada DUA nilai:\n\n• True (Betul)\n• False (Salah)\n\nIa digunakan untuk mewakili keadaan ya/tidak, hidup/mati, ada/tiada.',
            bodyEN: 'Boolean is the simplest data type — it only has TWO values:\n\n• True\n• False\n\nIt is used to represent yes/no, on/off, exist/not exist states.',
            codeExample: 'lampu_hidup = True\nhujan = False\n\nprint(lampu_hidup)  # True\nprint(hujan)        # False',
          ),
          LearnSlide(
            emoji: '⚡',
            titleBM: 'Operator Logik',
            titleEN: 'Logical Operators',
            bodyBM: 'Ada 3 operator logik utama:\n\n• AND — kedua-dua mesti True\n• OR — sekurang-kurangnya satu True\n• NOT — membalikkan nilai',
            bodyEN: 'There are 3 main logical operators:\n\n• AND — both must be True\n• OR — at least one must be True\n• NOT — reverses the value',
            codeExample: 'print(True and False)  # False\nprint(True or False)   # True\nprint(not True)        # False',
          ),
          LearnSlide(
            emoji: '🧩',
            titleBM: 'Boolean dalam Kehidupan',
            titleEN: 'Boolean in Real Life',
            bodyBM: 'Kita guna logik boolean setiap hari tanpa sedar!\n\nContoh:\n• Lampu isyarat: Hijau = True (boleh jalan)\n• ATM: Kod betul = True (boleh masuk)\n• Pintu automatik: Ada orang = True (buka)',
            bodyEN: 'We use boolean logic every day without realizing it!\n\nExamples:\n• Traffic light: Green = True (can go)\n• ATM: Correct PIN = True (can enter)\n• Automatic door: Person detected = True (open)',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🚦',
            titleBM: 'Membuat Keputusan',
            titleEN: 'Making Decisions',
            bodyBM: 'Program komputer perlu membuat KEPUTUSAN — macam manusia juga!\n\n"JIKA hujan, MAKA bawa payung. JIKA tidak, pakai topi."\n\nDalam kod, kita guna pernyataan IF untuk buat keputusan ini.',
            bodyEN: 'Computer programs need to make DECISIONS — just like humans!\n\n"IF it rains, THEN bring an umbrella. IF NOT, wear a hat."\n\nIn code, we use the IF statement to make these decisions.',
          ),
          LearnSlide(
            emoji: '📋',
            titleBM: 'Cara Tulis If/Else',
            titleEN: 'How to Write If/Else',
            bodyBM: 'Format asas:\n\nif syarat:\n    lakukan ini\nelse:\n    lakukan itu\n\nPerhatikan: kod di dalam if/else perlu ada inden (tab) supaya Python tahu ia di dalam blok tersebut.',
            bodyEN: 'Basic format:\n\nif condition:\n    do this\nelse:\n    do that\n\nNote: code inside if/else needs indentation (tab) so Python knows it\'s inside that block.',
            codeExample: 'umur = 18\n\nif umur >= 18:\n    print("Boleh mengundi!")\nelse:\n    print("Belum boleh mengundi.")',
          ),
          LearnSlide(
            emoji: '🔗',
            titleBM: 'Elif — Lebih Banyak Syarat',
            titleEN: 'Elif — More Conditions',
            bodyBM: 'Kalau ada BANYAK syarat, kita guna "elif" (else if):\n\nif syarat1:\n    ...\nelif syarat2:\n    ...\nelse:\n    ...',
            bodyEN: 'If there are MANY conditions, we use "elif" (else if):\n\nif condition1:\n    ...\nelif condition2:\n    ...\nelse:\n    ...',
            codeExample: 'markah = 75\n\nif markah >= 90:\n    print("A")\nelif markah >= 80:\n    print("B")\nelif markah >= 70:\n    print("C")\nelse:\n    print("Perlu cuba lagi")',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '⚖️',
            titleBM: 'Operator Perbandingan',
            titleEN: 'Comparison Operators',
            bodyBM: 'Operator perbandingan digunakan untuk MEMBANDINGKAN dua nilai. Hasilnya sentiasa True atau False.\n\n== sama dengan\n!= tidak sama\n> lebih besar\n< lebih kecil\n>= lebih besar atau sama\n<= lebih kecil atau sama',
            bodyEN: 'Comparison operators are used to COMPARE two values. The result is always True or False.\n\n== equals\n!= not equal\n> greater than\n< less than\n>= greater than or equal\n<= less than or equal',
          ),
          LearnSlide(
            emoji: '⚠️',
            titleBM: '= vs == (Jangan Keliru!)',
            titleEN: '= vs == (Don\'t Confuse!)',
            bodyBM: 'Ini kesilapan paling biasa untuk pemula!\n\n• = (satu tanda sama) = SIMPAN nilai\n• == (dua tanda sama) = BANDINGKAN nilai\n\nContoh: x = 5 bermakna simpan 5 dalam x\nx == 5 bermakna "adakah x sama dengan 5?"',
            bodyEN: 'This is the most common mistake for beginners!\n\n• = (one equals sign) = ASSIGN value\n• == (two equals signs) = COMPARE values\n\nExample: x = 5 means store 5 in x\nx == 5 means "is x equal to 5?"',
            codeExample: 'x = 10        # simpan 10 dalam x\nprint(x == 10) # True\nprint(x == 5)  # False\nprint(x > 7)   # True\nprint(x != 10) # False',
          ),
          LearnSlide(
            emoji: '🧪',
            titleBM: 'Guna Dalam If/Else',
            titleEN: 'Use in If/Else',
            bodyBM: 'Operator perbandingan paling berguna apabila diguna bersama if/else untuk membuat keputusan dalam program.',
            bodyEN: 'Comparison operators are most useful when used with if/else to make decisions in a program.',
            codeExample: 'suhu = 35\n\nif suhu > 30:\n    print("Panas! Minum air banyak.")\nelif suhu > 20:\n    print("Cuaca selesa.")\nelse:\n    print("Sejuk! Pakai baju tebal.")',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🏆',
            titleBM: 'Cabaran Unit 2!',
            titleEN: 'Unit 2 Challenge!',
            bodyBM: 'Hebat! Kamu dah habiskan Unit 2!\n\nMasa untuk uji semua yang dah dipelajari:\n✅ Boolean (True/False)\n✅ If/Else\n✅ Operator perbandingan\n\nSiap? Jom tunjukkan kehebatan kamu!',
            bodyEN: 'Great! You\'ve completed Unit 2!\n\nTime to test everything you\'ve learned:\n✅ Boolean (True/False)\n✅ If/Else\n✅ Comparison operators\n\nReady? Let\'s show your skills!',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🔁',
            titleBM: 'Kenapa Perlu Pengulangan?',
            titleEN: 'Why Do We Need Repetition?',
            bodyBM: 'Bayangkan kamu perlu cetak "Helo" sebanyak 100 kali. Adakah kamu nak tulis print("Helo") 100 kali?\n\nTentu tidak! Gelung (loop) membolehkan kita mengulangi arahan secara automatik tanpa menulis kod yang sama berulang kali.',
            bodyEN: 'Imagine you need to print "Hello" 100 times. Would you write print("Hello") 100 times?\n\nOf course not! Loops let us repeat instructions automatically without writing the same code over and over.',
            codeExample: '# Tanpa gelung — membosankan!\nprint("Helo")\nprint("Helo")\nprint("Helo")  # ... 97 kali lagi\n\n# Dengan gelung — mudah!\nfor i in range(100):\n    print("Helo")',
          ),
          LearnSlide(
            emoji: '🌍',
            titleBM: 'Gelung dalam Kehidupan',
            titleEN: 'Loops in Real Life',
            bodyBM: 'Gelung digunakan di mana-mana dalam apps yang kita guna setiap hari:\n\n📱 Instagram — scroll tak habis-habis = gelung\n🎵 Spotify — ulang lagu = gelung\n🎮 Games — pergerakan watak = gelung\n📧 Email — semak mesej baru = gelung',
            bodyEN: 'Loops are used everywhere in apps we use every day:\n\n📱 Instagram — endless scroll = loop\n🎵 Spotify — repeat song = loop\n🎮 Games — character movement = loop\n📧 Email — check new messages = loop',
          ),
          LearnSlide(
            emoji: '📚',
            titleBM: 'Dua Jenis Gelung',
            titleEN: 'Two Types of Loops',
            bodyBM: 'Dalam Python, ada dua gelung utama:\n\n🔄 While Loop\n• Ulang SELAGI syarat masih True\n• Guna apabila tidak tahu berapa kali nak ulang\n\n🔢 For Loop\n• Ulang untuk SETIAP item dalam senarai\n• Guna apabila tahu bilangan ulangan',
            bodyEN: 'In Python, there are two main loops:\n\n🔄 While Loop\n• Repeat WHILE condition is True\n• Use when you don\'t know how many times to repeat\n\n🔢 For Loop\n• Repeat for EACH item in a list\n• Use when you know the number of repetitions',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '⏳',
            titleBM: 'While Loop — Gelung Bersyarat',
            titleEN: 'While Loop — Conditional Loop',
            bodyBM: 'While loop akan terus berulang SELAGI syarat yang diberikan masih True.\n\nBayangkan: "Selagi ada nasi, terus makan."\n\nApabila nasi habis (syarat jadi False), gelung berhenti.',
            bodyEN: 'A while loop keeps repeating AS LONG AS the given condition is True.\n\nThink of it as: "While there is rice, keep eating."\n\nWhen the rice runs out (condition becomes False), the loop stops.',
          ),
          LearnSlide(
            emoji: '📝',
            titleBM: 'Cara Tulis While Loop',
            titleEN: 'How to Write a While Loop',
            bodyBM: 'Format while loop:\n\nwhile syarat:\n    lakukan sesuatu\n    kemas kini pemboleh ubah\n\nPERHATIAN: Pastikan syarat akhirnya jadi False, atau gelung akan berterusan selamanya!',
            bodyEN: 'While loop format:\n\nwhile condition:\n    do something\n    update variable\n\nWARNING: Make sure the condition eventually becomes False, or the loop will run forever!',
            codeExample: 'kiraan = 1\n\nwhile kiraan <= 5:\n    print(kiraan)\n    kiraan = kiraan + 1\n\n# Output: 1, 2, 3, 4, 5',
          ),
          LearnSlide(
            emoji: '⚠️',
            titleBM: 'Elak Gelung Tak Terhenti',
            titleEN: 'Avoid Infinite Loops',
            bodyBM: 'Gelung tak terhenti berlaku apabila syarat TIDAK PERNAH jadi False.\n\nIni menyebabkan program "hang" — tidak boleh berhenti!\n\nSentiasa pastikan ada sesuatu dalam gelung yang akan mengubah syarat kepada False.',
            bodyEN: 'An infinite loop happens when the condition NEVER becomes False.\n\nThis causes the program to "hang" — it cannot stop!\n\nAlways make sure there\'s something inside the loop that will change the condition to False.',
            codeExample: '# ⚠️ JANGAN buat ini!\nkiraan = 1\nwhile kiraan > 0:  # Sentiasa True!\n    print("Tak habis-habis...")\n    # kiraan tidak berubah!\n\n# ✅ Cara betul:\nwhile kiraan <= 5:\n    kiraan += 1  # Tambah setiap kali',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🔢',
            titleBM: 'For Loop — Gelung Berkira',
            titleEN: 'For Loop — Counted Loop',
            bodyBM: 'For loop digunakan apabila kita TAHU berapa kali nak ulang.\n\nContoh: "Ulang 10 kali" atau "Untuk setiap pelajar dalam kelas, cetak nama mereka".\n\nIn Python, kita sering guna range() bersama for loop.',
            bodyEN: 'For loop is used when we KNOW how many times to repeat.\n\nExample: "Repeat 10 times" or "For each student in class, print their name".\n\nIn Python, we often use range() with for loops.',
            codeExample: '# Cetak 1 hingga 5\nfor i in range(1, 6):\n    print(i)\n\n# Output:\n# 1\n# 2\n# 3\n# 4\n# 5',
          ),
          LearnSlide(
            emoji: '📋',
            titleBM: 'Gelung Melalui Senarai',
            titleEN: 'Loop Through a List',
            bodyBM: 'For loop sangat berguna untuk melalui setiap item dalam senarai (list).\n\nCara bacanya: "Untuk setiap buah dalam senarai buah-buahan, cetak nama buah tersebut."',
            bodyEN: 'For loops are great for going through each item in a list.\n\nRead it as: "For each fruit in the fruit list, print the fruit\'s name."',
            codeExample: 'buahan = ["Epal", "Mangga", "Durian"]\n\nfor buah in buahan:\n    print(buah)\n\n# Output:\n# Epal\n# Mangga\n# Durian',
          ),
          LearnSlide(
            emoji: '⚡',
            titleBM: 'While vs For Loop',
            titleEN: 'While vs For Loop',
            bodyBM: 'Bila nak guna yang mana?\n\n🔄 While Loop:\n• Tidak tahu berapa kali nak ulang\n• Ulang sehingga sesuatu berlaku\n• Contoh: tunggu sehingga pengguna masukkan nombor betul\n\n🔢 For Loop:\n• Tahu berapa kali nak ulang\n• Melalui setiap item dalam senarai\n• Contoh: proses 10 nama pelajar',
            bodyEN: 'When to use which?\n\n🔄 While Loop:\n• Don\'t know how many times to repeat\n• Repeat until something happens\n• Example: wait until user enters correct number\n\n🔢 For Loop:\n• Know how many times to repeat\n• Go through each item in a list\n• Example: process 10 student names',
          ),
        ],
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
        slides: [
          LearnSlide(
            emoji: '🏆',
            titleBM: 'Cabaran Akhir!',
            titleEN: 'Final Challenge!',
            bodyBM: 'Luar biasa! Kamu hampir habiskan semua unit!\n\nMasa untuk buktikan kamu dah kuasai:\n✅ Gelung (Loops)\n✅ While Loop\n✅ For Loop\n\nIni adalah cabaran terakhir. Bagi yang terbaik! 💪',
            bodyEN: 'Amazing! You\'re almost done with all units!\n\nTime to prove you\'ve mastered:\n✅ Loops\n✅ While Loop\n✅ For Loop\n\nThis is the final challenge. Give it your best! 💪',
          ),
        ],
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
