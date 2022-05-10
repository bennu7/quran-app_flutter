// API Surh URL : https://api.quran.sutanlab.id/surah/114
// GET detail ayat dalam Al-Quran

// import 'dart:convert';

// Ayat ayatFromJson(String str) => Ayat.fromJson(json.decode(str));

// String ayatToJson(Ayat data) => json.encode(data.toJson());

// class Ayat {
//   Ayat({
//     this.number,
//     // this.meta,
//     // this.text,
//     this.translation,
//     // this.audio,
//     this.tafsir,
//   });

//   Number? number;
//   // Meta? meta;
//   // Text? text;
//   Translation? translation;
//   // Audio? audio;
//   Tafsir? tafsir;

//   factory Ayat.fromJson(Map<String, dynamic>? json) => Ayat(
//         number: Number.fromJson(json?["number"]),
//         // meta: Meta.fromJson(json?["meta"]),
//         // text: Text.fromJson(json?["text"]),
//         translation: Translation.fromJson(json?["translation"]),
//         // audio: Audio.fromJson(json?["audio"]),
//         tafsir: Tafsir.fromJson(json?["tafsir"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "number": number?.toJson(),
//         // "meta": meta?.toJson(),
//         // "text": text?.toJson(),
//         "translation": translation?.toJson(),
//         // "audio": audio?.toJson(),
//         "tafsir": tafsir?.toJson(),
//       };
// }

// class Audio {
//   Audio({
//     this.primary,
//     this.secondary,
//   });

//   String? primary;
//   List<String>? secondary;

//   factory Audio.fromJson(Map<String, dynamic>? json) => Audio(
//         primary: json?["primary"],
//         secondary: json?["secondary"] == null
//             ? null
//             : List<String>.from(json!["secondary"].map((x) => x)),
//       );

//   Map<String, dynamic> toJson() => {
//         "primary": primary,
//         "secondary": secondary == null
//             ? null
//             : List<dynamic>.from(secondary!.map((x) => x)),
//       };
// }

// class Meta {
//   Meta({
//     this.juz,
//     this.page,
//     this.manzil,
//     this.ruku,
//     this.hizbQuarter,
//     this.sajda,
//   });

//   int? juz;
//   int? page;
//   int? manzil;
//   int? ruku;
//   int? hizbQuarter;
//   Sajda? sajda;

//   factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
//         juz: json?["juz"],
//         page: json?["page"],
//         manzil: json?["manzil"],
//         ruku: json?["ruku"],
//         hizbQuarter: json?["hizbQuarter"],
//         sajda: Sajda.fromJson(json?["sajda"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "juz": juz,
//         "page": page,
//         "manzil": manzil,
//         "ruku": ruku,
//         "hizbQuarter": hizbQuarter,
//         "sajda": sajda?.toJson(),
//       };
// }

// class Sajda {
//   Sajda({
//     this.recommended,
//     this.obligatory,
//   });

//   bool? recommended;
//   bool? obligatory;

//   factory Sajda.fromJson(Map<String, dynamic>? json) => Sajda(
//         recommended: json?["recommended"],
//         obligatory: json?["obligatory"],
//       );

//   Map<String, dynamic> toJson() => {
//         "recommended": recommended,
//         "obligatory": obligatory,
//       };
// }

// class Number {
//   Number({
//     this.inQuran,
//     this.inSurah,
//   });

//   int? inQuran;
//   int? inSurah;

//   factory Number.fromJson(Map<String, dynamic>? json) => Number(
//         inQuran: json?["inQuran"],
//         inSurah: json?["inSurah"],
//       );

//   Map<String, dynamic> toJson() => {
//         "inQuran": inQuran,
//         "inSurah": inSurah,
//       };
// }

// class Tafsir {
//   Tafsir({
//     this.id,
//   });

//   Id? id;

//   factory Tafsir.fromJson(Map<String, dynamic>? json) => Tafsir(
//         id: Id.fromJson(json?["id"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id?.toJson(),
//       };
// }

// class Id {
//   Id({
//     this.short,
//     this.long,
//   });

//   String? short;
//   String? long;

//   factory Id.fromJson(Map<String, dynamic>? json) => Id(
//         short: json?["short"],
//         long: json?["long"],
//       );

//   Map<String, dynamic> toJson() => {
//         "short": short,
//         "long": long,
//       };
// }

// class Text {
//   Text({
//     this.arab,
//     this.transliteration,
//   });

//   String? arab;
//   Transliteration? transliteration;

//   factory Text.fromJson(Map<String, dynamic>? json) => Text(
//         arab: json?["arab"],
//         transliteration: Transliteration.fromJson(json?["transliteration"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "arab": arab,
//         "transliteration": transliteration?.toJson(),
//       };
// }

// class Transliteration {
//   Transliteration({
//     this.en,
//   });

//   String? en;

//   factory Transliteration.fromJson(Map<String, dynamic>? json) =>
//       Transliteration(
//         en: json?["en"],
//       );

//   Map<String, dynamic> toJson() => {
//         "en": en,
//       };
// }

// class Translation {
//   Translation({
//     this.en,
//     this.id,
//   });

//   String? en;
//   String? id;

//   factory Translation.fromJson(Map<String, dynamic>? json) => Translation(
//         en: json?["en"],
//         id: json?["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "en": en,
//         "id": id,
//       };
// }

class Ayat {
  Number? number;
  Meta? meta;
  Text? text;
  Translation? translation;
  Audio? audio;
  Tafsir? tafsir;

  Ayat(
      {this.number,
      this.meta,
      this.text,
      this.translation,
      this.audio,
      this.tafsir});

  Ayat.fromJson(Map<String, dynamic> json) {
    number =
        json['number'] != null ? new Number.fromJson(json['number']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    text = json['text'] != null ? new Text.fromJson(json['text']) : null;
    translation = json['translation'] != null
        ? new Translation.fromJson(json['translation'])
        : null;
    audio = json['audio'] != null ? new Audio.fromJson(json['audio']) : null;
    tafsir =
        json['tafsir'] != null ? new Tafsir.fromJson(json['tafsir']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.number != null) {
      data['number'] = this.number!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.text != null) {
      data['text'] = this.text!.toJson();
    }
    if (this.translation != null) {
      data['translation'] = this.translation!.toJson();
    }
    if (this.audio != null) {
      data['audio'] = this.audio!.toJson();
    }
    if (this.tafsir != null) {
      data['tafsir'] = this.tafsir!.toJson();
    }
    return data;
  }
}

class Number {
  int? inQuran;
  int? inSurah;

  Number({this.inQuran, this.inSurah});

  Number.fromJson(Map<String, dynamic> json) {
    inQuran = json['inQuran'];
    inSurah = json['inSurah'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inQuran'] = this.inQuran;
    data['inSurah'] = this.inSurah;
    return data;
  }
}

class Meta {
  int? juz;
  int? page;
  int? manzil;
  int? ruku;
  int? hizbQuarter;
  Sajda? sajda;

  Meta(
      {this.juz,
      this.page,
      this.manzil,
      this.ruku,
      this.hizbQuarter,
      this.sajda});

  Meta.fromJson(Map<String, dynamic> json) {
    juz = json['juz'];
    page = json['page'];
    manzil = json['manzil'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    sajda = json['sajda'] != null ? new Sajda.fromJson(json['sajda']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['juz'] = this.juz;
    data['page'] = this.page;
    data['manzil'] = this.manzil;
    data['ruku'] = this.ruku;
    data['hizbQuarter'] = this.hizbQuarter;
    if (this.sajda != null) {
      data['sajda'] = this.sajda!.toJson();
    }
    return data;
  }
}

class Sajda {
  bool? recommended;
  bool? obligatory;

  Sajda({this.recommended, this.obligatory});

  Sajda.fromJson(Map<String, dynamic> json) {
    recommended = json['recommended'];
    obligatory = json['obligatory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recommended'] = this.recommended;
    data['obligatory'] = this.obligatory;
    return data;
  }
}

class Text {
  String? arab;
  Transliteration? transliteration;

  Text({this.arab, this.transliteration});

  Text.fromJson(Map<String, dynamic> json) {
    arab = json['arab'];
    transliteration = json['transliteration'] != null
        ? new Transliteration.fromJson(json['transliteration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arab'] = this.arab;
    if (this.transliteration != null) {
      data['transliteration'] = this.transliteration!.toJson();
    }
    return data;
  }
}

class Transliteration {
  String? en;

  Transliteration({this.en});

  Transliteration.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    return data;
  }
}

class Translation {
  String? en;
  String? id;

  Translation({this.en, this.id});

  Translation.fromJson(Map<String, dynamic> json) {
    en = json['en'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['en'] = this.en;
    data['id'] = this.id;
    return data;
  }
}

class Audio {
  String? primary;
  List<String>? secondary;

  Audio({this.primary, this.secondary});

  Audio.fromJson(Map<String, dynamic> json) {
    primary = json['primary'];
    secondary = json['secondary'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['primary'] = this.primary;
    data['secondary'] = this.secondary;
    return data;
  }
}

class Tafsir {
  Id? id;

  Tafsir({this.id});

  Tafsir.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.id != null) {
      data['id'] = this.id!.toJson();
    }
    return data;
  }
}

class Id {
  String? short;
  String? long;

  Id({this.short, this.long});

  Id.fromJson(Map<String, dynamic> json) {
    short = json['short'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['short'] = this.short;
    data['long'] = this.long;
    return data;
  }
}
