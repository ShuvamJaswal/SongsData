class SongDataModel {
  /// A unique songId.
  final String id;

  /// The album this media item belongs to.
  final String album;

  /// The title of this media item.
  final String title;

  /// The artist of this media item.
  final String? artist;
  final String? imageUrl;

  /// The genre of this media item.
  // final String? genre;

  /// The duration of this media item.
  // final Duration? duration;

  /// The artwork for this media item as a uri.
  //final Uri? artUri;

  /// Whether this is playable (i.e. not a folder).
  //final bool? playable;

  /// Override the default title for display purposes.
  // final String? displayTitle;

  /// Override the default subtitle for display purposes.
  // final String? displaySubtitle;

  /// Override the default description for display purposes.
  // final String? displayDescription;

  /// The rating of the MediaItem.
  //final Rating? rating;
  const SongDataModel({
    required this.id,
    required this.album,
    required this.title,
    this.artist,
    this.imageUrl,
    // this.genre,
    // this.duration,
    // this.artUri,
    // this.playable = true,
    // this.displayTitle,
    // this.displaySubtitle,
    //   this.displayDescription,
//    this.rating,
  });

  factory SongDataModel.fromJson(Map json) => SongDataModel(
      id: json['response']['song']['id'].toString(),
      album: json['response']['song']['album']?['full_title'] ?? 'unknown',
      title: json['response']['song']?['title'] ?? 'unknown',
      artist: json['response']['song']['primary_artist']['name'],

      // json['response']['song']['album']['artist']['name']?.toString() ??     "unknown",
      imageUrl: json['response']['song']['custom_song_art_image_url']
      // genre: raw['genre'],
      // duration: raw['duration'] != null
      //     ? Duration(milliseconds: raw['duration'])
      //     : null,
      // artUri: raw['artUri'] != null ? Uri.parse(raw['artUri']) : null,
      // playable: raw['playable'],
      // displayTitle: raw['displayTitle'],
      // displaySubtitle: raw['displaySubtitle'],
      // displayDescription: raw['displayDescription'],
      // rating: raw['rating'] != null ? Rating._fromRaw(raw['rating']) : null,
      // extras: raw['extras']?.cast<String, dynamic>(),
      );
}
