class SongDataModel {
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
    this.releaseDate,
    this.soundCloudUrl,
    this.spotifyUrl,
    this.youTubeUrl,
  });

  factory SongDataModel.fromJson(Map json) {
    return SongDataModel(
      //problem with spotify url becuase of media lenth
      id: json['response']['song']['id'].toString(),

      album: json['response']?['song']?['album']?['full_title'] ?? "Unknown",
      //     ? 'unknown'
      //     : json['response']['song']['album']['full_title'],
      title: json['response']?['song']?['title'] ?? 'unknown',
      artist:
          json['response']?['song']?['primary_artist']?['name'] ?? 'unknown',

      // json['response']?['song']?['album']?['artist']?['name']?.toString() ??     "unknown",
      imageUrl: json['response']?['song']?['song_art_image_url'],
      releaseDate:
          json['response']?['song']?['release_date_for_display'] ?? 'unknown',

/*import 'dart:convert';
void main() {
 List a=[{"native_uri": "spotify:track:7BKLCZ1jbUBVqRi2FVlTVw","provider": "spotify","type": "audio","url": "https://open.spotify.com/track/7BKLCZ1jbUBVqRi2FVlTVw"},{"attribution": "thechainsmokers","provider": "soundcloud","type": "audio","url": "https://soundcloud.com/thechainsmokers/closer"},{"provider": "youtube","start": 0,"type": "video","url": "http://www.youtube.com/watch?v=0zGcUoRlhmw"}];
var map1 = Map.fromIterable((a), key: (e) => e["provider"], value: (e) => e["url"]);

print(map1["spotify"]);
}
 */

      soundCloudUrl: (Map.fromIterable(json['response']['song']['media'],
              key: (e) => e["provider"],
              value: (e) => e["url"]))["soundcloud"] ??
          "unknown",

      spotifyUrl: (Map.fromIterable(json['response']['song']['media'],
          key: (e) => e["provider"], value: (e) => e["url"]))["spotify"],
      //json['response']?['song']?['media']?[0]?['url'] ?? 'unknown',
      youTubeUrl: (Map.fromIterable(json['response']['song']['media'],
              key: (e) => e["provider"], value: (e) => e["url"]))["youtube"] ??
          "unknown",
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
}
