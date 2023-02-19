//
//  History.swift
//  Recognizlator
//
//  Created by sara ayed albogami on 27/07/1444 AH.
//

import Foundation
import SwiftUI
import CoreData

class History : ObservableObject {
    
//    @Published var isShowingAddView = false
//    @Published var isShowingShare = false
//    @Published var isEditing = false
//    @Published var isPresented = false
    @Published var savedEntity: [Item] = []
    @Published var selectedItem : Item?
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Recognizlator")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
        }
        FetchRequest()
    }
    
    func FetchRequest(){
        let request = NSFetchRequest<Item>(entityName: "Item")
        do{
           savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addItem(TranslatedText: String, Image: UIImage? , time: Date) {
        let newContact = Item(context: container.viewContext)
        newContact.translateText = TranslatedText
        newContact.image = Image
        newContact.time = time
        SaveData()
        
    }
    
    func SaveData(){
        do {
            try container.viewContext.save()
            FetchRequest()
        } catch {
          print("Error Saving..\(error) ")
        }
    }
    
    func deleteItem(index: Array<Item>.Index){
       // guard let index = indexSet.first else {return}
//        let entity = savedEntity[index]
//        container.viewContext.delete(entity)
        savedEntity.map{_ in savedEntity[index]}.forEach(container.viewContext.delete)
        
        SaveData()
    }
//    func deleteContacts(offsets: IndexSet) {
//        offsets.map { items[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
}



//    .sheet(isPresented: $CoDa.isPresented, content: {
//        Share(translateText: CoDa.selectedItem?.translateText ?? "",
//              image: CoDa.selectedItem?.image ?? UIImage(named: "AppIcon")! ) })
