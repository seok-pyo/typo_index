class Typographymodel {
  final String note,
      simil,
      body,
      word,
      meaning1,
      meaning2,
      meaning3,
      refer,
      subtitle;

  Typographymodel.fromJson(Map<String, dynamic> json)
      : word = json['word'],
        meaning1 = json['meaning1'],
        meaning2 = json['meaning2'],
        meaning3 = json['meaning3'],
        refer = json['refer'],
        subtitle = json['subtitle'],
        body = json['body'] ?? '',
        simil = json['simil'] ?? '',
        note = json['note'] ?? '';
}
