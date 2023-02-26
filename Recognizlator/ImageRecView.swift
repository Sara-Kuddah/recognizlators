//
//  ImageRecView.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//

import SwiftUI
import CoreML
import Vision

struct ImageRecView: View {
    
    @State private var showSheet: Bool = false
    @State private var isshowSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var ishownhome: Bool = false
    @State private var image: UIImage?
    @State private var inputlang = ""
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var classificationLabel: String = ""
    @State private var count : Int = 0
    
    private let classifier = VisionClassifier(mlModel: MobileNetV2().model)
    
    @State var isHideText = false
    @State  private var languages :[String] =
    [NSLocalizedString("English", comment: ""),
     NSLocalizedString("Arabic", comment: ""),
     NSLocalizedString("Chinese", comment: ""),
     NSLocalizedString("French", comment: ""),
     NSLocalizedString("Italian", comment: "")]
    var synthVM = SynthViewModel()
    //for translate
    // View Model
    @ObservedObject var viewModel: ViewModel
    // to take input from ML result
    func takeInput(text : String){
        viewModel.input = text
    }
    // Instances of objects
    @State var viewedLanguages = ViewedLanguages()
    @State var translation = Translation()
    
    // Decides whether to present modal sheet or not
    @State var isPresented: Bool = false
    //MARK: - Header
    let screen = UIScreen.main.bounds
    // end for translate
    @ViewBuilder
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                Text("Selecte Language:")
                    .font(Font.custom("SF Pro", size: 22))
                    .padding(.trailing,150)
                    .accessibilityLabel(Text("Select language"))
                //new slect language butten
                HStack{
                    Spacer()
//                    // First (left) button: English by default
//                    Button(action: {
//                        // Passes to modal sheet that button 1 is being called
//                        viewedLanguages.selection = 1
//                        isPresented.toggle()
//                        
//                    }, label: {
//                        Text(viewedLanguages.firstName)
//                            .bold()
//                            .frame(width: 150, height: 40, alignment: .center)
//                            .background(Color.white)
//                            .foregroundColor(.blue)
//                    }).pickerStyle(.menu)
//                        .accentColor(.black)
//                        .frame(width: 130 , height: 50)
//                        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
//                    
//                    // Switch (middle) button: switches languages between first and second button
//                    Button(action: {
//                        let temp = viewedLanguages.firstName
//                        viewedLanguages.firstName = viewedLanguages.secondName
//                        viewedLanguages.secondName = temp
//                        
//                        let temp2 = viewedLanguages.firstCode
//                        viewedLanguages.firstCode = viewedLanguages.secondCode
//                        viewedLanguages.secondCode = temp2
//                        
//                        let temp3 = viewModel.input
//                        viewModel.input = viewModel.translation
//                        viewModel.translation = temp3
//                        
//                    }, label: {
//                        Image(systemName: "arrow.right.arrow.left")
//                            .frame(width: 75, height: 40, alignment: .center)
//                            .background(Color.white)
//                            .foregroundColor(Color(UIColor.darkGray))
//                    })
                    
                    // Second (right) button: French by default
                    Button(action: {
                        // Passes to modal sheet that button 2 is being called
                        viewedLanguages.selection = 2
                        isPresented.toggle()
                    }, label: {
                        Text(viewedLanguages.secondName)
                            .bold()
                            .frame(width: 150, height: 40, alignment: .center)
                            .background(Color.white)
                            .foregroundColor(.blue)
                    }).pickerStyle(.menu)
                        .accentColor(.black)
                        .frame(width: 130 , height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                    Spacer()
                }
                // old butten
//                HStack{
//
//                    Spacer()
//
//                        Picker("", selection: $inputlang){
//                            ForEach(languages , id: \.self){ language in
//                                Text(language)
//
//                                    .accessibilityLabel(Text(language))
//                            }
//
//                        }
//                        .pickerStyle(.menu)
//                        .accentColor(.black)
//                        .frame(width: 290 , height: 50)
//                        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
//                        .padding(.trailing,50)
//                    Spacer()
//
//                }
                
                
                ZStack{
                    
                    HStack{
                        
                        Button() {
                            // open action sheet
                            self.showSheet = true
                            
                        }label: {
                            
                            Label("Upload a Picture", systemImage: "plus")
                            
                        }
                        .accentColor(.white)
                        .font(Font.custom("SF Pro", size: 18))
                        .frame(width: 270 , height: 50)
                        .background(RoundedRectangle(cornerRadius: 15 ).fill(Color("CusColor")).opacity(1))
                        
                        
                    }
                  
                        RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("CusColor"), style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .overlay(
                                Group {
                                    HStack{
                                        
                                        Button() {
                                            self.showSheet = true
                                        }label: {
                                            
                                            Label("Upload a Picture", systemImage: "plus")
                                            
                                        }
                                        .accentColor(.white)
                                        .font(Font.custom("SF Pro", size: 18))
                                        .frame(width: 270 , height: 50)
                                        .background(RoundedRectangle(cornerRadius: 15 ).fill(Color("CusColor")).opacity(1))
                                        
                                        
                                    }
                                    if image != nil {
                                        Image(uiImage: image!)
                                            .resizable()
                                          //  .scaledToFit()
                                            .frame(width: 350, height:360)
                                            .cornerRadius(15)
                                    }
                                })
                             .frame(width: 350, height:360)
                }
                  
                    .actionSheet(isPresented: $showSheet) {
                        
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                // open photo library
                                self.showPhotoOptions = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                // open camera
                                self.showPhotoOptions = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                        
                }
                    .padding()
                
                VStack{
                    //retake image
                    Button{
                        ishownhome.toggle()
                    } label: {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                        
                        
                        
                    }
                    .fontWeight(.regular)
                    .font(.system(size: 40))
                    .foregroundColor(Color("CusColor"))
                    HStack{
                        //voice
                       
                        // Translate button: passes input to translation API
                        Button(action:{
                            takeInput(text: classificationLabel)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if !viewModel.input.isEmpty {
                                    // Calls API translate function to retrieve translation
                                    ViewModel().translate(for: viewModel.input, for: viewedLanguages.firstCode, for: viewedLanguages.secondCode) { (results) in
                                        viewModel.translation = results.data.translations.first?.translatedText ?? "default value"
                                    }
                                    
                                    
                                }
                            }
                        },label: {
                            
                            Text("Translate")
                            
                        })
                        .accentColor(.white)
                        .font(Font.custom("SF Pro", size: 18))
                        .frame(width: 150 , height: 50)
                        .background(RoundedRectangle(cornerRadius: 15 ).fill(Color("CusColor")).opacity(1))
                    }
                }.padding(.top, -10)
     
                .actionSheet(isPresented:$ishownhome ){
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                // open photo library
                                self.showPhotoOptions = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                // open camera
                                self.showPhotoOptions = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                    }.opacity(isHideText ? 1.0 : 0.0 )
                
                VStack{
                    
                    Text("Translated text:")
                    // 1
                   // Text(classificationLabel)
                    //translate result
                    HStack{
                        Text(viewModel.translation)
                        Spacer(minLength: 15)
                        Button{
                            didchange.toggle()
                        } label: {
                            Image(systemName: "speaker.wave.2.circle.fill")
                            .onChange(of: didchange) { newValue in
                                //synthVM
                                synthVM.speak(text: classificationLabel)
                        }.fontWeight(.regular)
                                .font(.system(size: 40))
                                .foregroundColor(Color("CusColor"))
                            
                        }.opacity(isHideText ? 1.0 : 0.0 )
                    }.padding(.horizontal)
                    
                
                }.font(Font.custom("SF Pro", size: 22))
                    
      
                HStack{
                    Text("upload a photo to get the translate")
                    
                }.font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color("LGray"))
                    .padding(.trailing,10)
                    .opacity(isHideText ? 0.0 : 1.0 )
                //translate result
                VStack () {
                    
                   
//                    ZStack {
//                        // Second text field: where translation is displayed
//
//
//                        TextField("", text: $viewModel.translation)
//                            .frame(width: screen.width * 0.925, height: screen.height * 0.1, alignment: .top)
//                            .padding(.horizontal, 20)
//                            .padding(.vertical, 10)
//                            .background(Color.white)
//                            .border(Color(UIColor.systemGray2), width: 1)
//                            .disabled(true)
//                        HStack {
//                            Spacer()
//
//                            // Translate button: passes input to translation API
//                            Button(action: {
//                                takeInput(text: classificationLabel)
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                    if !viewModel.input.isEmpty {
//                                        // Calls API translate function to retrieve translation
//                                        ViewModel().translate(for: viewModel.input, for: viewedLanguages.firstCode, for: viewedLanguages.secondCode) { (results) in
//                                            viewModel.translation = results.data.translations.first?.translatedText ?? "default value"
//                                        }
//
//
//                                    }
//                                }
//                            }, label: {
//                                Image(systemName: "arrow.right")
//                                    .frame(width: 25, height: 25, alignment: .center)
//                                    .font(.system(size: 15, weight: .bold))
//                                    .foregroundColor(.white)
//                                    .background(Color.blue)
//                                    .clipShape(Circle())
//
//                            }).padding(.trailing, 15)
//                        }
//                    }
                }.sheet(isPresented: $isPresented) {
                    // Modal sheet of available languages
                    LanguagesList(viewedLanguages: $viewedLanguages, isPresented: $isPresented)
                }
            }.padding(.top, -50)

            .navigationBarTitle("Image Recognition")
            
            
        }.padding(.top, -100)
        .sheet(isPresented: $showPhotoOptions) {
            ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
                .onDisappear{
                    if image != nil {
                        classifier?.classify(self.image!) {
                            result in
                            //2
                            self.classificationLabel = result
                           // didchange.toggle()
                            isHideText = true
                            handleData(picture: self.image, result: result)
                        }
                    }
                }
        }
    }
    @State var didchange = false
    
    func handleData(picture: UIImage?, result: String) {
        let context = PersistenceController.shared.container.viewContext
        let newHistory = History(context: context)
        newHistory.date = Date()
        
        let imageData = picture?.jpegData(compressionQuality: 1.0)
            newHistory.picture = imageData
            
        
        newHistory.result = result
        
        PersistenceController.shared.save()
       
        
        
   }
}

struct ImageRecView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            // 1
            ImageRecView(viewModel: ViewModel())
                .environment(\.locale, .init(identifier: "en"))
            // 2
            ImageRecView(viewModel: ViewModel())
                .environment(\.locale, .init(identifier: "ar"))
        }
    }
}

 
import AVKit

class SynthViewModel: NSObject {
  private var speechSynthesizer = AVSpeechSynthesizer()
  
  override init() {
    super.init()
    self.speechSynthesizer.delegate = self
  }
  
  func speak(text: String) {
    let utterance = AVSpeechUtterance(string: text)
    speechSynthesizer.speak(utterance)
  }
}

extension SynthViewModel: AVSpeechSynthesizerDelegate {
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
    print("started")
  }
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) {
    print("paused")
  }
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {}
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {}
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {}
  func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
    print("finished")
  }
}
//
