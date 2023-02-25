//
//  Model.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 05/08/1444 AH.
//

import Foundation
import SwiftUI

//Model for translations

struct TranslationResults: Codable {
    var data: Translations
}
struct Translations: Codable {
    var translations: [TranslatedText]
}
struct TranslatedText: Codable {
    var translatedText: String
}
//Json
//{
//  "data": {
//    "translations": [
//      {
//        "translatedText": "¡Hola Mundo!"
//      }
//    ]
//  }
//}

//========================
//Model for list of languages
struct ListResults: Codable {
    var data: Languages
}

struct Languages: Codable {
    var languages: [Language]
}

struct Language: Codable {
    var language: String
    var name: String
}

//Json
//{
//  "data": {
//    "languages": [
//      {
//        "language": "af"
//      },
//      {
//        "language": "ak"
//      },
//      {
//        "language": "am"
//      },
//      {
//        "language": "ar"
//      },
//      {
//        "language": "as"
//      },
//      {
//        "language": "ay"
//      },
//      {
//        "language": "az"
//      },
//      {
//        "language": "be"
//      },
//      {
//        "language": "bg"
//      },
//      {
//        "language": "bho"
//      },
//      {
//        "language": "bm"
//      },
//      {
//        "language": "bn"
//      },
//      {
//        "language": "bs"
//      },
//      {
//        "language": "ca"
//      },
//      {
//        "language": "ceb"
//      },
//      {
//        "language": "ckb"
//      },
//      {
//        "language": "co"
//      },
//      {
//        "language": "cs"
//      },
//      {
//        "language": "cy"
//      },
//      {
//        "language": "da"
//      },
//      {
//        "language": "de"
//      },
//      {
//        "language": "doi"
//      },
//      {
//        "language": "dv"
//      },
//      {
//        "language": "ee"
//      },
//      {
//        "language": "el"
//      },
//      {
//        "language": "en"
//      },
//      {
//        "language": "eo"
//      },
//      {
//        "language": "es"
//      },
//      {
//        "language": "et"
//      },
//      {
//        "language": "eu"
//      },
//      {
//        "language": "fa"
//      },
//      {
//        "language": "fi"
//      },
//      {
//        "language": "fr"
//      },
//      {
//        "language": "fy"
//      },
//      {
//        "language": "ga"
//      },
//      {
//        "language": "gd"
//      },
//      {
//        "language": "gl"
//      },
//      {
//        "language": "gn"
//      },
//      {
//        "language": "gom"
//      },
//      {
//        "language": "gu"
//      },
//      {
//        "language": "ha"
//      },
//      {
//        "language": "haw"
//      },
//      {
//        "language": "he"
//      },
//      {
//        "language": "hi"
//      },
//      {
//        "language": "hmn"
//      },
//      {
//        "language": "hr"
//      },
//      {
//        "language": "ht"
//      },
//      {
//        "language": "hu"
//      },
//      {
//        "language": "hy"
//      },
//      {
//        "language": "id"
//      },
//      {
//        "language": "ig"
//      },
//      {
//        "language": "ilo"
//      },
//      {
//        "language": "is"
//      },
//      {
//        "language": "it"
//      },
//      {
//        "language": "iw"
//      },
//      {
//        "language": "ja"
//      },
//      {
//        "language": "jv"
//      },
//      {
//        "language": "jw"
//      },
//      {
//        "language": "ka"
//      },
//      {
//        "language": "kk"
//      },
//      {
//        "language": "km"
//      },
//      {
//        "language": "kn"
//      },
//      {
//        "language": "ko"
//      },
//      {
//        "language": "kri"
//      },
//      {
//        "language": "ku"
//      },
//      {
//        "language": "ky"
//      },
//      {
//        "language": "la"
//      },
//      {
//        "language": "lb"
//      },
//      {
//        "language": "lg"
//      },
//      {
//        "language": "ln"
//      },
//      {
//        "language": "lo"
//      },
//      {
//        "language": "lt"
//      },
//      {
//        "language": "lus"
//      },
//      {
//        "language": "lv"
//      },
//      {
//        "language": "mai"
//      },
//      {
//        "language": "mg"
//      },
//      {
//        "language": "mi"
//      },
//      {
//        "language": "mk"
//      },
//      {
//        "language": "ml"
//      },
//      {
//        "language": "mn"
//      },
//      {
//        "language": "mni-Mtei"
//      },
//      {
//        "language": "mr"
//      },
//      {
//        "language": "ms"
//      },
//      {
//        "language": "mt"
//      },
//      {
//        "language": "my"
//      },
//      {
//        "language": "ne"
//      },
//      {
//        "language": "nl"
//      },
//      {
//        "language": "no"
//      },
//      {
//        "language": "nso"
//      },
//      {
//        "language": "ny"
//      },
//      {
//        "language": "om"
//      },
//      {
//        "language": "or"
//      },
//      {
//        "language": "pa"
//      },
//      {
//        "language": "pl"
//      },
//      {
//        "language": "ps"
//      },
//      {
//        "language": "pt"
//      },
//      {
//        "language": "qu"
//      },
//      {
//        "language": "ro"
//      },
//      {
//        "language": "ru"
//      },
//      {
//        "language": "rw"
//      },
//      {
//        "language": "sa"
//      },
//      {
//        "language": "sd"
//      },
//      {
//        "language": "si"
//      },
//      {
//        "language": "sk"
//      },
//      {
//        "language": "sl"
//      },
//      {
//        "language": "sm"
//      },
//      {
//        "language": "sn"
//      },
//      {
//        "language": "so"
//      },
//      {
//        "language": "sq"
//      },
//      {
//        "language": "sr"
//      },
//      {
//        "language": "st"
//      },
//      {
//        "language": "su"
//      },
//      {
//        "language": "sv"
//      },
//      {
//        "language": "sw"
//      },
//      {
//        "language": "ta"
//      },
//      {
//        "language": "te"
//      },
//      {
//        "language": "tg"
//      },
//      {
//        "language": "th"
//      },
//      {
//        "language": "ti"
//      },
//      {
//        "language": "tk"
//      },
//      {
//        "language": "tl"
//      },
//      {
//        "language": "tr"
//      },
//      {
//        "language": "ts"
//      },
//      {
//        "language": "tt"
//      },
//      {
//        "language": "ug"
//      },
//      {
//        "language": "uk"
//      },
//      {
//        "language": "ur"
//      },
//      {
//        "language": "uz"
//      },
//      {
//        "language": "vi"
//      },
//      {
//        "language": "xh"
//      },
//      {
//        "language": "yi"
//      },
//      {
//        "language": "yo"
//      },
//      {
//        "language": "zh"
//      },
//      {
//        "language": "zh-CN"
//      },
//      {
//        "language": "zh-TW"
//      },
//      {
//        "language": "zu"
//      }
//    ]
//  }
//}

