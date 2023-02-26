//
//  TextRecView.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 27/07/1444 AH.
//

import Foundation
import SwiftUI
import CoreML
import Vision
import Speech 

struct TextRecView: View {
   
    @State private var showSheet: Bool = false
    @State private var isshowSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var ishownhome: Bool = false
    @State private var image: UIImage?
    @State private var inputlang = ""
    @State private var outputlang = ""
    @State private var swaplang = ""
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var classificationLabel: String = ""
    var synthVM = SynthViewModel()
    
    private let classifier = VisionClassifier(mlModel: MobileNetV2().model)
    @State var isHideText = false
    @State  private var languages :[String] =
    [NSLocalizedString("English", comment: ""),
     NSLocalizedString("Arabic", comment: ""),
     NSLocalizedString("Chinese", comment: ""),
     NSLocalizedString("French", comment: ""),
     NSLocalizedString("Italian", comment: "")]
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                Text("Selecte Language:")
                    .font(Font.custom("SF Pro", size: 22))
                    .padding(.trailing,150)
                    .accessibilityLabel(Text("Select language"))
                
                
                HStack(spacing:35){
                    
                    Picker("", selection: $inputlang){
                        ForEach(languages , id: \.self){ language in
                            Text(language)
                                
                                .accessibilityLabel(Text(language))
                                .font(.footnote.weight(.bold))
                            
                        }
                    }
                    
                    .pickerStyle(.menu)
                    .accentColor(.black)
                    .frame(width: 130 , height: 39)
                    .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                   
                   // .labelsHidden()
                    
                    Button {
                        
                        //Swap between inputUnit And OutputUnit
                        swaplang = inputlang
                        inputlang = outputlang
                        outputlang = swaplang
                        
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundColor(Color("CusColor"))
                            .font(.system(size: 20))
                    }.buttonStyle(.plain).accessibilityLabel(Text("Switch between 2 units you picked"))
                    
                    
                    Picker("", selection: $outputlang){
                        ForEach(languages , id: \.self){ language in
                            Text(language)
                                
                                .accessibilityLabel(Text(language))
                                .font(.footnote.weight(.bold))
                            
                        }
                    }
                    
                    .pickerStyle(.menu)
                    .accentColor(.black)
                    .frame(width: 130 , height: 39)
                    .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                 //   .labelsHidden()
            
                }
                .frame(width: 50)
                
                
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
                        
                    }
                 
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
                    }.opacity(isHideText ? 1.0 : 0.0 )
                
                HStack{
                    
                    Text("Translated text:")
                    Text(classificationLabel)
                  
                        
                }.font(Font.custom("SF Pro", size: 22))
                    
      
                HStack{
                    Text("upload a photo to get the translate")
                    
                }.font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color("LGray"))
                    .padding(.trailing,10)
                    .opacity(isHideText ? 0.0 : 1.0 )
            }

            .navigationBarTitle("Text Recognition")
            
        }
        .sheet(isPresented: $showPhotoOptions) {
            ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
                .onDisappear{
                    
                    if image != nil {
                        classifier?.classify(self.image!) {
                            result in
                                self.classificationLabel = result
                            handleData(picture: self.image, result: result, translatedText: "translatedText")
                            isHideText = true
                        }
                    }
                }
        }
        
    }
    @State var didchange = false
    
    func handleData(picture: UIImage?, result: String, translatedText: String) {
        let context = PersistenceController.shared.container.viewContext
        let newHistory = History(context: context)
        newHistory.date = Date()
       // let cgImage = CIContext(options: nil).createCGImage(picture.ciImage!, from: picture.ciImage!.extent)
        //let uiImage = UIImage(cgImage: picture)
        
        // Compress the UIImage to a Data object
        let imageData = picture?.jpegData(compressionQuality: 1.0)
            newHistory.picture = imageData
            
        
        newHistory.result = result
        
        PersistenceController.shared.save()
       
        
        
   }
}

struct TextRecView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            // 1
            TextRecView()
                .environment(\.locale, .init(identifier: "en"))
            // 2
            TextRecView()
                .environment(\.locale, .init(identifier: "ar"))
        }
    }
}

 
