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
    
    private let classifier = VisionClassifier(mlModel: MobileNetV2().model)
    
    @State var isHideText = false
    @State  private var languages :[String] =
    [NSLocalizedString("English", comment: ""),
     NSLocalizedString("Arabic", comment: ""),
     NSLocalizedString("Chinese", comment: ""),
     NSLocalizedString("French", comment: ""),
     NSLocalizedString("Italian", comment: "")]
    var synthVM = SynthViewModel()
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                Text("Selecte Language:")
                    .font(Font.custom("SF Pro", size: 22))
                    .padding(.trailing,150)
                    .accessibilityLabel(Text("Select language"))
                
                
                HStack{
                    
                    Spacer()
                    
                        Picker("", selection: $inputlang){
                            ForEach(languages , id: \.self){ language in
                                Text(language)
                                    
                                    .accessibilityLabel(Text(language))
                            }
                            
                        }
                        .pickerStyle(.menu)
                        .accentColor(.black)
                        .frame(width: 290 , height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                        .padding(.trailing,50)
                    Spacer()
                       
                }
                
                
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
                
                HStack{
                    
                    Button{
                        ishownhome.toggle()
                    } label: {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            
                            
                            
                    }
                    .fontWeight(.regular)
                    .font(.system(size: 40))
                    .foregroundColor(Color("CusColor"))
                }
                    
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
                    }
                
                HStack{
                    
                    Text("Translated text:")
                    // 1
                    Text(classificationLabel)
                        .onChange(of: didchange) { newValue in
                            //synthVM
                            synthVM.speak(text: classificationLabel)
                        }
                        
                        
                }.font(Font.custom("SF Pro", size: 22))
                    
      
                HStack{
                    Text("upload a photo to get the translate")
                    
                }.font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color("LGray"))
                    .padding(.trailing,10)
                    .opacity(isHideText ? 0.0 : 1.0 )
      
            }

            .navigationBarTitle("Image Recognition")
            
        }
        .sheet(isPresented: $showPhotoOptions) {
            ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
                .onDisappear{
                    if image != nil {
                        classifier?.classify(self.image!) {
                            result in
                            //2
                            self.classificationLabel = result
                            didchange.toggle()
                            isHideText = true
                        }
                    }
                }
        }
    }
    @State var didchange = false
}

struct ImageRecView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            // 1
            ImageRecView()
                .environment(\.locale, .init(identifier: "en"))
            // 2
            ImageRecView()
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
