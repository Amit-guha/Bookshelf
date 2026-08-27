class Author {
  const Author({
    required this.key,
    required this.name,
    this.bio,
    this.photoUrl,
    this.birthDate,
    this.deathDate,
  });

  final String key;
  final String name;
  final String? bio;
  final String? photoUrl;
  final String? birthDate;
  final String? deathDate;
}
