//
//  HistoryView.swift
//  Recognizlator
//
//  Created by WadiahAlbuhairi on 01/08/1444 AH.
//
//??++

import SwiftUI
import CoreData

struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(entity: History.entity(), sortDescriptors: []) var data: FetchedResults<History>
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \History.id, ascending: true)],
    animation: .default)
    private var data: FetchedResults<History>

    func createImage(_ value: Data) -> Image {
        let songArtwork: UIImage = UIImage(data: value) ?? UIImage()
        return Image(uiImage: songArtwork)
    }
    var body: some View {
        NavigationView{
            List{
                ForEach(data) { item in
                    
                    VStack {
                        HStack{
                        createImage(item.picture as! Data)
                            .resizable()
                            .frame(width: 50  , height: 50)
                            //*
                            VStack{
                                Text(item.result ?? "Uknown")
                                Text(item.translatedText ?? "Uknown")
                            }
                            
                        }
                    }
                    
                 
                }
                .onDelete(perform: deleteItems)
            }
            .onAppear(perform: {
                print(data.count)
            })
            .listStyle(PlainListStyle())
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                
                ToolbarItem {
                  
                }
            }
            Text("Select an item")
           
            
        }
        
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { data[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
            
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
    
    
    struct HistoryView_Previews: PreviewProvider {
        static var previews: some View {
            HistoryView()
        }
    }
   
