abstract class LibraryItem {
  final String title;
  final int year;

  const LibraryItem({required this.title, required this.year});

  String describe();
}

class Book extends LibraryItem {
  final String author;

  const Book({required super.title, required super.year, required this.author});

  @override
  String describe() => '$title ($year) — $author';

  @override
  String toString() => 'Book(title: $title, year: $year, author: $author)';
}

class Magazine extends LibraryItem {
  final int issueNumber;

  const Magazine({
    required super.title,
    required super.year,
    required this.issueNumber,
  });

  @override
  String describe() => '$title ($year), випуск $issueNumber';

  @override
  String toString() =>
      'Magazine(title: $title, year: $year, issueNumber: $issueNumber)';
}

class Library {
  final List<LibraryItem> _items = [];

  void addItem(LibraryItem item) => _items.add(item);

  List<LibraryItem> findByYear(int year) =>
      _items.where((item) => item.year == year).toList();

  List<String> get allDescriptions =>
      _items.map((item) => item.describe()).toList();

  LibraryItem? findOldest() {
    if (_items.isEmpty) return null;
    return _items.reduce((oldest, item) => item.year < oldest.year ? item : oldest);
  }
}

void main() {
  final library = Library()
    ..addItem(const Book(title: 'Dart у дії', year: 2022, author: 'І. Петренко'))
    ..addItem(const Magazine(title: 'Mobile Dev', year: 2023, issueNumber: 5))
    ..addItem(const Book(title: 'Flutter для всіх', year: 2022, author: 'О. Коваль'));

  print(library.findByYear(2022));
  print(library.allDescriptions);
  print(library.findOldest());
}
