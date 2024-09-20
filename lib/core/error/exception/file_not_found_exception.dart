class FileNotFoundException implements Exception {
  const FileNotFoundException([this.message = 'File not found']);

  final String message;

  @override
  String toString() => "FileNotFoundException: $message";
}
