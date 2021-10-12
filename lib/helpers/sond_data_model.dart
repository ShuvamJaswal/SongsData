class SongDataModel {
  final String? lyricsURL;

  /// A unique songId.
  final String id;
  final String? spotifyUrl;
  final String? youTubeUrl;
  final String? soundCloudUrl;

  /// The album this media item belongs to.
  final String? album;

  /// The title of this media item.
  final String? title;

  /// The artist of this media item.
  final String? artist;
  final String? imageUrl;
  final String? releaseDate;
  const SongDataModel({
    required this.id,
    required this.album,
    required this.title,
    this.artist,
    this.lyricsURL,
    this.imageUrl,
    this.releaseDate,
    this.soundCloudUrl,
    this.spotifyUrl,
    this.youTubeUrl,
  });

  factory SongDataModel.fromJson(Map json) {
    return SongDataModel(
      lyricsURL: json['response']?['song']['url'],
      id: json['response']['song']['id'].toString(),
      album: json['response']?['song']?['album']?['full_title'] ?? "Unknown",
      title: json['response']?['song']?['title'] ?? 'unknown',
      artist:
          json['response']?['song']?['primary_artist']?['name'] ?? 'unknown',
      imageUrl: json['response']?['song']?['song_art_image_url'],
      releaseDate:
          json['response']?['song']?['release_date_for_display'] ?? 'unknown',
      soundCloudUrl: (Map.fromIterable(json['response']['song']['media'],
              key: (e) => e["provider"],
              value: (e) => e["url"]))["soundcloud"] ??
          "unknown",
      spotifyUrl: (Map.fromIterable(json['response']['song']['media'],
          key: (e) => e["provider"], value: (e) => e["url"]))["spotify"],
      youTubeUrl: (Map.fromIterable(json['response']['song']['media'],
              key: (e) => e["provider"], value: (e) => e["url"]))["youtube"] ??
          "unknown",
    );
  }
}
