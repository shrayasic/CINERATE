class Movie {
  final String id;
  final String url;
  final String primaryTitle;
  final String originalTitle;
  final String type;
  final List<String> genres;
  final bool isAdult;
  final int startYear;
  final int? endYear;
  final int runtimeMinutes;
  final double averageRating;
  final int numVotes;
  final String description;
  final String primaryImage;
  final String? contentRating;
  final ReleaseDate? releaseDate;
  final List<String> interests;
  final List<String> countriesOfOrigin;
  final List<String> externalLinks;
  final List<String> spokenLanguages;
  final List<String> filmingLocations;
  final int? budget;
  final int? grossWorldwide;
  final List<Person> directors;
  final List<Person> writers;
  final List<Cast> cast;

  Movie({
    required this.id,
    required this.url,
    required this.primaryTitle,
    required this.originalTitle,
    required this.type,
    required this.genres,
    required this.isAdult,
    required this.startYear,
    this.endYear,
    required this.runtimeMinutes,
    required this.averageRating,
    required this.numVotes,
    required this.description,
    required this.primaryImage,
    this.contentRating,
    this.releaseDate,
    required this.interests,
    required this.countriesOfOrigin,
    required this.externalLinks,
    required this.spokenLanguages,
    required this.filmingLocations,
    this.budget,
    this.grossWorldwide,
    required this.directors,
    required this.writers,
    required this.cast,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      primaryTitle: json['primaryTitle'] ?? '',
      originalTitle: json['originalTitle'] ?? '',
      type: json['type'] ?? '',
      genres: List<String>.from(json['genres'] ?? []),
      isAdult: json['isAdult'] ?? false,
      startYear: json['startYear'] ?? 0,
      endYear: json['endYear'],
      runtimeMinutes: json['runtimeMinutes'] ?? 0,
      averageRating: (json['averageRating'] is int
          ? (json['averageRating'] as int).toDouble()
          : json['averageRating']) ??
          0.0,
      numVotes: json['numVotes'] ?? 0,
      description: json['description'] ?? '',
      primaryImage: json['primaryImage'] ?? '',
      contentRating: json['contentRating'],
      releaseDate: json['releaseDate'] != null
          ? ReleaseDate.fromJson(json['releaseDate'])
          : null,
      interests: List<String>.from(json['interests'] ?? []),
      countriesOfOrigin: List<String>.from(json['countriesOfOrigin'] ?? []),
      externalLinks: List<String>.from(json['externalLinks'] ?? []),
      spokenLanguages: List<String>.from(json['spokenLanguages'] ?? []),
      filmingLocations: List<String>.from(json['filmingLocations'] ?? []),
      budget: json['budget'],
      grossWorldwide: json['grossWorldwide'],
      directors: (json['directors'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      writers: (json['writers'] as List<dynamic>?)
          ?.map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
      cast: (json['cast'] as List<dynamic>?)
          ?.map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

class ReleaseDate {
  final int? day;
  final int? month;
  final int? year;

  ReleaseDate({this.day, this.month, this.year});

  factory ReleaseDate.fromJson(Map<String, dynamic> json) {
    return ReleaseDate(
      day: json['day'],
      month: json['month'],
      year: json['year'],
    );
  }
}

class Person {
  final String id;
  final String url;
  final String fullName;

  Person({required this.id, required this.url, required this.fullName});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }
}

class Cast extends Person {
  final String? job;
  final List<String>? characters;

  Cast({
    required super.id,
    required super.url,
    required super.fullName,
    this.job,
    this.characters,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
      fullName: json['fullName'] ?? '',
      job: json['job'],
      characters:
      json['characters'] != null ? List<String>.from(json['characters']) : null,
    );
  }
}

