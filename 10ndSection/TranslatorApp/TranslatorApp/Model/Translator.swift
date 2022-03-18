//
//  Translator.swift
//  TranslatorApp
//
//  Created by Sabir Myrzaev on 18/3/22.
//

import Foundation
import RealmSwift

class Translator: Object {
    static var wordsList = [Translator]()

    @objc dynamic var inputWord: String = ""
    @objc dynamic var outputWord: String = ""
    @objc dynamic var checkLanguage: Bool = false
    
    convenience init(input: String, output: String, check: Bool) {
       self.init()
        self.inputWord = input
        self.outputWord = output
        self.checkLanguage = check
    }
}


