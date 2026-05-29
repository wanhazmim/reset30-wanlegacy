import '../models/lesson_model.dart';

const List<Unit> allUnits = [
  Unit(
    id: 'u1',
    titleBM: 'Asas HTML',
    titleEN: 'HTML Basics',
    emoji: '🌐',
    color: '#2196F3',
    lessons: [
      Lesson(
        id: 'u1l1',
        unitId: 'u1',
        titleBM: 'Apa itu HTML?',
        titleEN: 'What is HTML?',
        descBM: 'Kenali bahasa asas untuk membuat halaman web.',
        descEN: 'Learn the base language for web pages.',
        emoji: '🧩',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '📄',
            titleBM: 'HTML adalah bahasa struktur',
            titleEN: 'HTML is a structure language',
            bodyBM: 'HTML (HyperText Markup Language) digunakan untuk membina struktur halaman web.

Ia memberitahu pelayar bagaimana menampilkan tajuk, teks, pautan dan gambar.',
            bodyEN: 'HTML (HyperText Markup Language) is used to build the structure of web pages.

It tells the browser how to display titles, text, links and images.',
          ),
          LearnSlide(
            emoji: '🔖',
            titleBM: 'Tag HTML',
            titleEN: 'HTML tags',
            bodyBM: 'HTML menggunakan tag seperti <html>, <head>, <body>, <h1> dan <p> untuk menyusun kandungan.

Setiap tag mempunyai pembukaan dan penutupan.',
            bodyEN: 'HTML uses tags like <html>, <head>, <body>, <h1> and <p> to organize content.

Each tag has an opening and closing part.',
            codeExample: '<!DOCTYPE html>
<html>
  <body>
    <h1>Halo CODE30</h1>
    <p>Ini adalah halaman pertama saya.</p>
  </body>
</html>',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u1l1e1',
            type: 'mcq',
            questionBM: 'Apakah fungsi HTML?',
            questionEN: 'What is the purpose of HTML?',
            options: [
              'Menghiasi laman web dengan warna',
              'Memberi struktur kepada kandungan web',
              'Menjalankan kod JavaScript',
              'Menyimpan data di pelayan',
            ],
            correctAnswer: '1',
            explanationBM: 'HTML digunakan untuk memberi struktur kepada teks, tajuk, pautan dan gambar dalam laman web.',
            explanationEN: 'HTML is used to give structure to text, headings, links and images on a web page.',
          ),
          Exercise(
            id: 'u1l1e2',
            type: 'truefalse',
            questionBM: 'HTML adalah bahasa untuk membina halaman web.',
            questionEN: 'HTML is a language for building web pages.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul! HTML adalah bahasa markup yang digunakan untuk membina struktur laman web.',
            explanationEN: 'True! HTML is a markup language used to build web page structure.',
          ),
        ],
      ),
      Lesson(
        id: 'u1l2',
        unitId: 'u1',
        titleBM: 'Tag & Struktur',
        titleEN: 'Tags & Structure',
        descBM: 'Pelajari tag paling penting dalam halaman HTML.',
        descEN: 'Learn the most important tags in an HTML page.',
        emoji: '🏗️',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '🧱',
            titleBM: 'Bina halaman web',
            titleEN: 'Build a web page',
            bodyBM: 'Setiap halaman HTML bermula dengan struktur asas: <!DOCTYPE html>, <html>, <head> dan <body>.

Kandungan utama diletakkan dalam <body>.',
            bodyEN: 'Every HTML page starts with the basic structure: <!DOCTYPE html>, <html>, <head>, and <body>.

The main content goes inside the <body>.',
            codeExample: '<!DOCTYPE html>
<html>
  <head>
    <title>Kod Pertama</title>
  </head>
  <body>
    <h1>Selamat Datang</h1>
    <p>Ini adalah contoh.</p>
  </body>
</html>',
          ),
          LearnSlide(
            emoji: '🔍',
            titleBM: 'Heading & Perenggan',
            titleEN: 'Headings & Paragraphs',
            bodyBM: 'Tag <h1> hingga <h6> digunakan untuk tajuk. Tag <p> digunakan untuk perenggan teks.

Anda boleh menulis teks ringkas dengan mudah.',
            bodyEN: 'Tags <h1> to <h6> are used for headings. The <p> tag is used for paragraphs of text.

You can write simple text easily.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u1l2e1',
            type: 'mcq',
            questionBM: 'Tag manakah digunakan untuk perenggan?',
            questionEN: 'Which tag is used for a paragraph?',
            options: ['<h1>', '<img>', '<p>', '<a>'],
            correctAnswer: '2',
            explanationBM: 'Tag <p> digunakan untuk menulis perenggan dalam HTML.',
            explanationEN: 'The <p> tag is used to write paragraphs in HTML.',
          ),
          Exercise(
            id: 'u1l2e2',
            type: 'truefalse',
            questionBM: 'Semua teks perlu berada di dalam tag <body> dalam HTML.',
            questionEN: 'All text should be inside the <body> tag in HTML.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul, kandungan halaman biasanya diletakkan dalam tag <body>.',
            explanationEN: 'True, page content is generally placed inside the <body> tag.',
          ),
        ],
      ),
      Lesson(
        id: 'u1l3',
        unitId: 'u1',
        titleBM: 'Pautan & Gambar',
        titleEN: 'Links & Images',
        descBM: 'Tambahkan pautan dan gambar ke halaman web anda.',
        descEN: 'Add links and images to your web page.',
        emoji: '🔗',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '🖼️',
            titleBM: 'Gambar dalam HTML',
            titleEN: 'Images in HTML',
            bodyBM: 'Tag <img> digunakan untuk memaparkan gambar. Atribut src memberitahu pelayar di mana gambar berada.',
            bodyEN: 'The <img> tag is used to display images. The src attribute tells the browser where the image is located.',
            codeExample: '<img src="https://example.com/gambar.jpg" alt="Gambar contoh">',
          ),
          LearnSlide(
            emoji: '🌍',
            titleBM: 'Pautan web',
            titleEN: 'Web links',
            bodyBM: 'Tag <a> membuat pautan. Atribut href menentukan alamat halaman sasaran.',
            bodyEN: 'The <a> tag creates a link. The href attribute sets the target page address.',
            codeExample: '<a href="https://code30.app">Lawati CODE30</a>',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u1l3e1',
            type: 'mcq',
            questionBM: 'Tag manakah digunakan untuk membuat pautan?',
            questionEN: 'Which tag is used to create a link?',
            options: ['<p>', '<a>', '<img>', '<div>'],
            correctAnswer: '1',
            explanationBM: 'Tag <a> digunakan untuk membuat pautan di halaman web.',
            explanationEN: 'The <a> tag is used to create links on a web page.',
          ),
          Exercise(
            id: 'u1l3e2',
            type: 'truefalse',
            questionBM: 'Tag <img> memerlukan atribut src untuk menunjukkan fail gambar.',
            questionEN: 'The <img> tag requires a src attribute to point to the image file.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul — src memberitahu pelayar lokasi gambar.',
            explanationEN: 'True — src tells the browser where the image is located.',
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u2',
    titleBM: 'Cantik dengan CSS',
    titleEN: 'Style with CSS',
    emoji: '🎨',
    color: '#FF9800',
    lessons: [
      Lesson(
        id: 'u2l1',
        unitId: 'u2',
        titleBM: 'Apa itu CSS?',
        titleEN: 'What is CSS?',
        descBM: 'Belajar bagaimana CSS membuat laman web menjadi cantik.',
        descEN: 'Learn how CSS makes websites look beautiful.',
        emoji: '✨',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '🧠',
            titleBM: 'CSS untuk gaya',
            titleEN: 'CSS for styling',
            bodyBM: 'CSS (Cascading Style Sheets) digunakan untuk menukar warna, saiz teks, jarak dan rupa halaman.',
            bodyEN: 'CSS (Cascading Style Sheets) is used to change colors, text size, spacing and the appearance of a page.',
            codeExample: 'p {
  color: blue;
  font-size: 18px;
}',
          ),
          LearnSlide(
            emoji: '🎯',
            titleBM: 'Hubungkan CSS dengan HTML',
            titleEN: 'Link CSS to HTML',
            bodyBM: 'CSS boleh ditulis terus dalam HTML menggunakan tag <style> atau fail luar dengan <link>.',
            bodyEN: 'CSS can be written inside HTML using the <style> tag or in an external file with <link>.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u2l1e1',
            type: 'mcq',
            questionBM: 'Apakah CSS digunakan untuk?',
            questionEN: 'What is CSS used for?',
            options: ['Menambah interaksi', 'Mengatur susunan data', 'Menukar rupa halaman', 'Menjana grafik 3D'],
            correctAnswer: '2',
            explanationBM: 'CSS digunakan untuk menjadikan halaman web lebih menarik dengan gaya dan warna.',
            explanationEN: 'CSS is used to make web pages more attractive with styles and colors.',
          ),
          Exercise(
            id: 'u2l1e2',
            type: 'truefalse',
            questionBM: 'CSS boleh mengubah saiz teks.',
            questionEN: 'CSS can change the size of text.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul — property font-size dalam CSS mengawal saiz teks.',
            explanationEN: 'True — the CSS property font-size controls text size.',
          ),
        ],
      ),
      Lesson(
        id: 'u2l2',
        unitId: 'u2',
        titleBM: 'Warna & Teks',
        titleEN: 'Colors & Text',
        descBM: 'Gunakan CSS untuk membuat tajuk dan teks lebih menarik.',
        descEN: 'Use CSS to make headings and text more attractive.',
        emoji: '🟦',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '🖌️',
            titleBM: 'Warna dalam CSS',
            titleEN: 'Colors in CSS',
            bodyBM: 'Anda boleh menukar warna latar, teks dan sempadan menggunakan property seperti color dan background-color.',
            bodyEN: 'You can change background, text and border colors using properties like color and background-color.',
            codeExample: 'h1 {
  color: white;
  background-color: teal;
}',
          ),
          LearnSlide(
            emoji: '🅰️',
            titleBM: 'Font & Teks',
            titleEN: 'Fonts & Text',
            bodyBM: 'CSS juga mengawal fon, gaya teks dan penjajaran dengan property seperti text-align dan font-weight.',
            bodyEN: 'CSS also controls font, text style, and alignment with properties like text-align and font-weight.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u2l2e1',
            type: 'mcq',
            questionBM: 'Property manakah mengubah warna teks?',
            questionEN: 'Which property changes text color?',
            options: ['background-color', 'border', 'color', 'margin'],
            correctAnswer: '2',
            explanationBM: 'Property color dalam CSS mengubah warna teks.',
            explanationEN: 'The color property in CSS changes the text color.',
          ),
          Exercise(
            id: 'u2l2e2',
            type: 'truefalse',
            questionBM: 'text-align: center; akan memusatkan teks.',
            questionEN: 'text-align: center; will center the text.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul! text-align: center; memusatkan teks dalam elemen.',
            explanationEN: 'True! text-align: center; centers the text inside the element.',
          ),
        ],
      ),
      Lesson(
        id: 'u2l3',
        unitId: 'u2',
        titleBM: 'Kotak & Susun Atur',
        titleEN: 'Boxes & Layout',
        descBM: 'Pelajari cara mengawal saiz dan ruang elemen HTML.',
        descEN: 'Learn how to control size and spacing of HTML elements.',
        emoji: '📦',
        xpReward: 25,
        slides: [
          LearnSlide(
            emoji: '📏',
            titleBM: 'Margin & Padding',
            titleEN: 'Margin & Padding',
            bodyBM: 'Margin adalah ruang di luar elemen. Padding adalah ruang di dalam elemen. Kedua-duanya membantu menyusun layout.',
            bodyEN: 'Margin is space outside an element. Padding is space inside an element. Both help organize layout.',
            codeExample: 'div {
  padding: 16px;
  margin: 12px;
  border: 2px solid #333;
}',
          ),
          LearnSlide(
            emoji: '📦',
            titleBM: 'Kotak HTML',
            titleEN: 'HTML boxes',
            bodyBM: 'Setiap elemen HTML adalah kotak. CSS membolehkan anda menetapkan lebar, tinggi dan sempadan untuk elemen tersebut.',
            bodyEN: 'Every HTML element is a box. CSS lets you set width, height and borders for each element.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u2l3e1',
            type: 'mcq',
            questionBM: 'Apakah fungsi padding dalam CSS?',
            questionEN: 'What does padding do in CSS?',
            options: ['Menambahkan ruang di antara sempadan dan isi', 'Menukar warna latar belakang', 'Membuat teks tebal', 'Menambah pautan'],
            correctAnswer: '0',
            explanationBM: 'Padding menambah ruang di dalam elemen antara isi dan sempadan.',
            explanationEN: 'Padding adds space inside an element between its content and border.',
          ),
          Exercise(
            id: 'u2l3e2',
            type: 'truefalse',
            questionBM: 'Margin mewujudkan ruang di luar elemen.',
            questionEN: 'Margin creates space outside the element.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul — margin adalah ruang di luar sempadan elemen.',
            explanationEN: 'True — margin is the space outside the element border.',
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 'u3',
    titleBM: 'Asas JavaScript',
    titleEN: 'JavaScript Basics',
    emoji: '⚡',
    color: '#4CAF50',
    lessons: [
      Lesson(
        id: 'u3l1',
        unitId: 'u3',
        titleBM: 'Apa itu JavaScript?',
        titleEN: 'What is JavaScript?',
        descBM: 'Pelajari bahasa yang membuat laman web lebih interaktif.',
        descEN: 'Learn the language that makes web pages interactive.',
        emoji: '⚙️',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '💡',
            titleBM: 'JS untuk interaksi',
            titleEN: 'JS for interaction',
            bodyBM: 'JavaScript digunakan untuk membuat butang, borang dan halaman web menjadi interaktif.

Contohnya, ia boleh menunjukkan mesej apabila anda klik sesuatu.',
            bodyEN: 'JavaScript is used to make buttons, forms and web pages interactive.

For example, it can show a message when you click something.',
            codeExample: 'console.log("Hello CODE30!");',
          ),
          LearnSlide(
            emoji: '🔁',
            titleBM: 'Kod dijalankan secara berturutan',
            titleEN: 'Code runs in order',
            bodyBM: 'JavaScript membaca kod dari atas ke bawah. Baris pertama dieksekusi dahulu, kemudian baris seterusnya.',
            bodyEN: 'JavaScript reads code from top to bottom. The first line runs first, then the next line.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u3l1e1',
            type: 'mcq',
            questionBM: 'Apakah JavaScript digunakan untuk?',
            questionEN: 'What is JavaScript used for?',
            options: ['Mengubah struktur HTML', 'Membuat laman web interaktif', 'Mencetak halaman', 'Menulis dokumen PDF'],
            correctAnswer: '1',
            explanationBM: 'JavaScript membuat laman web menjadi interaktif dengan tindakan seperti klik dan animasi.',
            explanationEN: 'JavaScript makes web pages interactive with actions like clicks and animations.',
          ),
          Exercise(
            id: 'u3l1e2',
            type: 'truefalse',
            questionBM: 'console.log() akan memaparkan teks ke konsol.',
            questionEN: 'console.log() displays text to the console.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul — console.log() digunakan untuk melihat mesej di konsol pembangun.',
            explanationEN: 'True — console.log() is used to view messages in the developer console.',
          ),
        ],
      ),
      Lesson(
        id: 'u3l2',
        unitId: 'u3',
        titleBM: 'Pemboleh Ubah',
        titleEN: 'Variables',
        descBM: 'Gunakan pemboleh ubah untuk menyimpan data dalam JavaScript.',
        descEN: 'Use variables to store data in JavaScript.',
        emoji: '📦',
        xpReward: 20,
        slides: [
          LearnSlide(
            emoji: '🧠',
            titleBM: 'Simpan nilai dengan let',
            titleEN: 'Store values with let',
            bodyBM: 'Dalam JavaScript, anda boleh menggunakan var, let atau const untuk menyimpan nilai dalam pemboleh ubah.',
            bodyEN: 'In JavaScript, you can use var, let or const to store values in variables.',
            codeExample: 'let nama = "Amin";
const umur = 18;
console.log(nama);',
          ),
          LearnSlide(
            emoji: '🔄',
            titleBM: 'Ubah nilai',
            titleEN: 'Change values',
            bodyBM: 'Nilai pemboleh ubah dapat ditukar jika anda menggunakan let atau var.

Const tidak boleh diubah selepas ditetapkan.',
            bodyEN: 'Variable values can be changed if you use let or var.

Const cannot be changed after it is set.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u3l2e1',
            type: 'mcq',
            questionBM: 'Apakah fungsi pemboleh ubah dalam JavaScript?',
            questionEN: 'What is the purpose of a variable in JavaScript?',
            options: ['Menjalankan kod', 'Menyimpan data untuk digunakan kemudian', 'Menjadikan teks berwarna', 'Membuat pautan'],
            correctAnswer: '1',
            explanationBM: 'Pemboleh ubah menyimpan data supaya ia boleh digunakan semula dalam kod.',
            explanationEN: 'Variables store data so it can be reused in code.',
          ),
          Exercise(
            id: 'u3l2e2',
            type: 'truefalse',
            questionBM: 'const tidak boleh diubah selepas ia ditetapkan.',
            questionEN: 'const cannot be changed once it is set.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul — const adalah tetap dan tidak boleh diberi nilai baru selepas ditetapkan.',
            explanationEN: 'True — const is fixed and cannot be reassigned after it is set.',
          ),
        ],
      ),
      Lesson(
        id: 'u3l3',
        unitId: 'u3',
        titleBM: 'Keputusan Jika',
        titleEN: 'If statements',
        descBM: 'Gunakan if untuk membuat keputusan dalam kod anda.',
        descEN: 'Use if to make decisions in your code.',
        emoji: '🧩',
        xpReward: 25,
        slides: [
          LearnSlide(
            emoji: '🤔',
            titleBM: 'Buat keputusan dengan if',
            titleEN: 'Make decisions with if',
            bodyBM: 'If membolehkan JavaScript memilih jalan berbeza berdasarkan syarat.

Contohnya, jika skor >= 10, tunjukkan mesej hebat.',
            bodyEN: 'If lets JavaScript choose different paths based on a condition.

For example, if score >= 10, show a great message.',
            codeExample: 'let skor = 10;
if (skor >= 10) {
  console.log("Tahniah!");
}',
          ),
          LearnSlide(
            emoji: '⚖️',
            titleBM: 'True atau False',
            titleEN: 'True or False',
            bodyBM: 'Syarat if biasanya menghasilkan true atau false.

Jika syarat true, blok kod akan dijalankan.',
            bodyEN: 'An if condition usually results in true or false.

If the condition is true, the code block runs.',
          ),
        ],
        exercises: [
          Exercise(
            id: 'u3l3e1',
            type: 'mcq',
            questionBM: 'Apakah syarat if berikut akan lakukan? if (umur >= 18) { ... }',
            questionEN: 'What does this if condition do? if (age >= 18) { ... }',
            options: ['Menjalankan kod hanya jika umur kurang dari 18', 'Menjalankan kod jika umur sama atau lebih daripada 18', 'Sentiasa menjalankan kod', 'Tidak menjalankan kod langsung'],
            correctAnswer: '1',
            explanationBM: 'Kod akan dijalankan apabila umur adalah 18 atau lebih.',
            explanationEN: 'The code runs when age is 18 or greater.',
          ),
          Exercise(
            id: 'u3l3e2',
            type: 'truefalse',
            questionBM: 'If hanya berjalan apabila syarat adalah true.',
            questionEN: 'If only runs when the condition is true.',
            options: [],
            correctAnswer: 'true',
            explanationBM: 'Betul — if hanya mengaktifkan blok kod ketika syarat true.',
            explanationEN: 'True — if only executes the code block when the condition is true.',
          ),
        ],
      ),
    ],
  ),
];
