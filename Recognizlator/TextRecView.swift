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
    
    var body: some View {
        
        NavigationView {
            
            VStack{
                
                Text("Selecte Language:")
                    .font(Font.custom("SF Pro", size: 22))
                    .padding(.trailing,150)
                    .accessibilityLabel(Text("Select language"))
                //new select language button
                HStack(spacing:35){
                    
                    
                    // First (left) button: English by default
                    Button(action: {
                        // Passes to modal sheet that button 1 is being called
                        viewedLanguages.selection = 1
                        isPresented.toggle()
                        
                    }, label: {
                        Text(viewedLanguages.firstName)
                            .font(.footnote.weight(.light))
                            .bold()
                        // .frame(width: 150, height: 40, alignment: .center)
                        //                                .bold()
                        //                                .frame(width: 150, height: 40, alignment: .center)
                        //                                .background(Color.white)
                        //                                .foregroundColor(.blue)
                    }).pickerStyle(.menu)
                        .accentColor(.black)
                        .frame(width: 130 , height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                    
                    // Switch (middle) button: switches languages between first and second button
                    Button(action: {
                        let temp = viewedLanguages.firstName
                        viewedLanguages.firstName = viewedLanguages.secondName
                        viewedLanguages.secondName = temp
                        
                        let temp2 = viewedLanguages.firstCode
                        viewedLanguages.firstCode = viewedLanguages.secondCode
                        viewedLanguages.secondCode = temp2
                        
                        let temp3 = viewModel.input
                        viewModel.input = viewModel.translation
                        viewModel.translation = temp3
                        
                    }, label: {
                        Image(systemName: "arrow.right.arrow.left")
                            .foregroundColor(Color("CusColor"))
                            .font(.system(size: 20))
                        //                                .frame(width: 75, height: 40, alignment: .center)
                        //                                .background(Color.white)
                        //                                .foregroundColor(Color(UIColor.darkGray))
                    })
                    
                    // Second (right) button: French by default
                    Button(action: {
                        // Passes to modal sheet that button 2 is being called
                        viewedLanguages.selection = 2
                        isPresented.toggle()
                    }, label: {
                        Text(viewedLanguages.secondName)
                        // .accessibilityLabel(Text(language))
                            .font(.footnote.weight(.bold))
                            .bold()
                        // .frame(width: 150, height: 40, alignment: .center)
                        //                                .background(Color.white)
                        //                                .foregroundColor(.blue)
                    }).pickerStyle(.menu)
                        .accentColor(.black)
                        .frame(width: 130 , height: 50)
                        .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                    
                }
                //old select language button
                //                HStack(spacing:35){
                //
                //                    Picker("", selection: $inputlang){
                //                        ForEach(languages , id: \.self){ language in
                //                            Text(language)
                //
                //                                .accessibilityLabel(Text(language))
                //                                .font(.footnote.weight(.bold))
                //
                //                        }
                //                    }
                //
                //                    .pickerStyle(.menu)
                //                    .accentColor(.black)
                //                    .frame(width: 130 , height: 39)
                //                    .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                //
                //                   // .labelsHidden()
                //
                //                    Button {
                //
                //                        //Swap between inputUnit And OutputUnit
                //                        swaplang = inputlang
                //                        inputlang = outputlang
                //                        outputlang = swaplang
                //
                //                    } label: {
                //                        Image(systemName: "arrow.left.arrow.right")
                //                            .foregroundColor(Color("CusColor"))
                //                            .font(.system(size: 20))
                //                    }.buttonStyle(.plain).accessibilityLabel(Text("Switch between 2 units you picked"))
                //
                //
                //                    Picker("", selection: $outputlang){
                //                        ForEach(languages , id: \.self){ language in
                //                            Text(language)
                //
                //                                .accessibilityLabel(Text(language))
                //                                .font(.footnote.weight(.bold))
                //
                //                        }
                //                    }
                //
                //                    .pickerStyle(.menu)
                //                    .accentColor(.black)
                //                    .frame(width: 130 , height: 39)
                //                    .background(RoundedRectangle(cornerRadius: 15).strokeBorder(Color("CusColor")))
                //                 //   .labelsHidden()
                //
                //                }
                //                .frame(width: 50)
                
                
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
                VStack{
                    
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
                    Spacer()
                    Text("Translated text:")
                   // Text(classificationLabel)
                    
                    Text(viewModel.translation)
                    Spacer(minLength: 15)
                  
                        
                }.font(Font.custom("SF Pro", size: 22))
                    
      
                HStack{
                    Text("upload a photo to get the translate")
                    
                }.font(Font.custom("SF Pro", size: 14))
                    .foregroundColor(Color("LGray"))
                    .padding(.trailing,10)
                    .opacity(isHideText ? 0.0 : 1.0 )
                //translate result
                VStack () {
                    
                    // Top text field: where user enters input to be translated
    //                ZStack {
    //                    TextField("Enter text", text: $viewModel.input)
    //                        .frame(width: screen.width * 0.925, height: screen.height * 0.1, alignment: .top)
    //                        .padding(.horizontal, 20)
    //                        .padding(.vertical, 10)
    //                        .background(Color.white)
    //                        .border(Color(UIColor.systemGray2), width: 1)
    //                    HStack {
    //                        Spacer()
    //
    //                        // Delete button: deletes any input entered by user
    //                        Button(action: {
    //                            viewModel.input = ""
    //                        }, label: {
    //                            Image(systemName: "multiply")
    //                                .frame(width: 25, height: 25, alignment: .center)
    //                                .font(.system(size: 24))
    //                                .foregroundColor(.black)
    //                        }).padding(.trailing, 15)
    //                    }
    //                }
                    
                    //TranslatedView(viewModel: viewModel )
                    ZStack {
                        // Second text field: where translation is displayed
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
//                                        // Waits 4 seconds after button has been pressed before saving to Core Data
//                                        //                                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//                                        //                                    if !viewModel.translation.isEmpty {
//                                        //                                        translation.input = viewModel.input
//                                        //                                        translation.translation = viewModel.translation
//                                        ////                                        save(translation: translation)
//                                        //                                    }
//                                        //                                }
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
             }
                }.sheet(isPresented: $isPresented) {
                    // Modal sheet of available languages
                    LanguagesList(viewedLanguages: $viewedLanguages, isPresented: $isPresented)
                }
      
            }.padding(.top, -30)

            .navigationBarTitle("Text Recognition")
            
        }.padding(.top, -100)
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
            TextRecView( viewModel: ViewModel())
                .environment(\.locale, .init(identifier: "en"))
            // 2
            TextRecView(viewModel: ViewModel())
                .environment(\.locale, .init(identifier: "ar"))
        }
    }
}

 
