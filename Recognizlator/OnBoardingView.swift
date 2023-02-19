//
//  OnBoardingView.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 21/07/1444 AH.
//


import SwiftUI

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let OnBoardingSteps = [

    OnBoardingStep(image: "pic1", title: NSLocalizedString("TRANSLATE IN ONE STEP", comment: ""), description: NSLocalizedString( "Translate things quickly and accurately through your camera", comment: "")),
OnBoardingStep(image: "pic2", title: NSLocalizedString("TAKE OR UPLOAD PHOTO...",comment: ""), description: NSLocalizedString( "Just take or upload photo of the object you want to recognize", comment: "")),
OnBoardingStep(image: "pic3", title: NSLocalizedString(
 """
 ...AND THE TRANSLATION
     HERE IT IS
 """, comment: ""), description: NSLocalizedString( "Your photo will be instantly translated", comment: ""))]

struct OnBoardingView: View {
    @State private var currentStep = 0
    @State private var isshownhome = false
    @State private var ishownhome = false
    init(){
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button{
                    ishownhome.toggle()
                } label: {
                    Text("Skip")
                }
                .fontWeight(.bold)
                .font(Font.custom("SF Pro", size: 20))
                .foregroundColor(Color("CusColor"))
                .padding(20)
                
                
                .fullScreenCover(isPresented:$ishownhome ){
                    ContentView()
                }
            }
            
            TabView(selection: $currentStep){
                ForEach(0..<OnBoardingSteps.count) { step in
                    VStack{
                        Image(OnBoardingSteps[step].image)
                            .resizable()
                            .frame(width:380 ,height: 300)
                            .padding(.bottom)
                            
                        
                        Text(OnBoardingSteps[step].title)
                            .font(.title)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .font(Font.custom("SF Pro", size: 24))
                        
                        
                        Text(OnBoardingSteps[step].description)
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color("Gray"))
                            .font(Font.custom("SF Pro", size: 18))
                            .padding(.horizontal, 32)
                            .padding(.top, 16)
                    }
                    .tag(step)
                }}
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack{
                ForEach(0..<OnBoardingSteps.count) { step in
                    if step == currentStep {
                        Rectangle()
                            .frame(width: 20, height: 10)
                            .cornerRadius(15)
                            .foregroundColor(Color("CusColor"))
                    }
                    else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(Color("Gray"))
                    }
                }
            }
            .padding(.bottom, 24)
            
            if self.currentStep == OnBoardingSteps.count - 1 {
                Button{isshownhome.toggle()}
            label: {
                Text("Get started")
                //    .fontWeight(.bold)
            }
            .padding(16)
            .font(Font.custom("SF Pro", size: 18))
            .frame(maxWidth: .infinity)
            .background(Color("CusColor"))
            .cornerRadius(15)
            .padding(.horizontal, 16)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .buttonStyle(PlainButtonStyle())
            .fullScreenCover(isPresented: $isshownhome)
                {
                    ContentView()
                    
                }
            }
            
        }
    }
    
}
struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            OnBoardingView()
                .environment(\.locale, .init(identifier: "en"))
            
            OnBoardingView()
                .environment(\.locale, .init(identifier: "ar"))
            
        }
    }
}
