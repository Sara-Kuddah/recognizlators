//
//  ViewModel.swift
//  Recognizlator
//
//  Created by Sara Khalid BIN kuddah on 05/08/1444 AH.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var languages = [Language]()     // Language list (array)
    @Published var translations = [TranslatedText]()     // Language list (array)
    @Published var input: String = ""           // Text entered by user to translate
    @Published var translation: String = ""     // Translation of input
    @Published var sourceLang: String = "en"    // Language of input
    @Published var targetLang: String = "fr"    // Language of translation

    let apiKey = "5c518b29ebmshcf349ff9f44df5dp126a5fjsna03a7c573f90"
    
//MARK: - Language List API Call
    func getLanguages(completion:@escaping (ListResults) -> ()) {
        
        guard let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2/languages?target=en&rapidapi-key=\(apiKey)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard data != nil else {
                print("TASK ERROR 1: \(String(describing: error))")
                return
            }
            
            do {
                let results = try JSONDecoder().decode(ListResults.self, from: data!)
                
                DispatchQueue.main.async {
                    self.languages = results.data.languages
                    completion(results)
                }
            } catch {
                print("RESULTS ERROR 1: \(error)")
            }
        }
        task.resume()
    }

//MARK: - Translation API Call
    func translate(for input: String, for sourceLang: String, for targetLang: String, completion:@escaping (TranslationResults) -> ()) {
       
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "Accept-Encoding": "application/gzip",
            "X-RapidAPI-Key": "5c518b29ebmshcf349ff9f44df5dp126a5fjsna03a7c573f90",
            "X-RapidAPI-Host": "google-translate1.p.rapidapi.com"
        ]

        let postData = NSMutableData(data: "q=\(input)".data(using: String.Encoding.utf8)!)
        postData.append("&target=\(targetLang)".data(using: String.Encoding.utf8)!)
        postData.append("&source=\(sourceLang)".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "error line 74")
            } else {
                guard data != nil else {
                    print("TASK ERROR 1: \(String(describing: error))")
                    return
                }
                
                do {
                    let results = try JSONDecoder().decode(TranslationResults.self, from: data!)
                    
                    DispatchQueue.main.async {
                        print("targetLang \(targetLang)")
                        self.targetLang = targetLang
                        print("self.targetLang \(self.targetLang)")
                        self.translations = results.data.translations
                        completion(results)
                        print("translations \(self.translations)")
                        
                    }
                } catch {
                    print("RESULTS ERROR 1: \(error)")
                }
//                print("data \(data!)")
//                print("response \(response!)")
                
                let httpResponse = response as? HTTPURLResponse
                print("httpResponse \(httpResponse!)")
            }
        })

        dataTask.resume()
//        self.input = input.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        print("Translating from \(sourceLang) to \(targetLang)")
//        guard let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2?text=\(input)&sl=\(sourceLang)&tl=\(targetLang)&rapidapi-key=\(apiKey)") else {
//            print("Invalid URL")
//            return
//        }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard data != nil else {
//                print("TASK ERROR 2: \(String(describing: error))")
//                return
//            }
//
//            do {
//                let results = try JSONDecoder().decode(TranslationResults.self, from: data!)
//                print("TRANSLATION: \(results.data.translation)")
//
//                DispatchQueue.main.async {
//                    self.translation = results.data.translation
//                    completion(results)
//                }
//            } catch {
//                print("RESULTS ERROR 2: \(error)")
//            }
//        }
//        task.resume()
    }
}
