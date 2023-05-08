//
//  CheerLogView.swift
//  mc2-DreamLog
//
//  Created by KimTaeHyung on 2023/05/04.
//

import SwiftUI
import CoreData

struct CheerLogView: View {
    var body: some View {
        BgColorGeoView { geo in
            VStack {
                Text("나를 향한 응원 로그를 남겨보세요")
                    .brownText()
                    .padding(.top, 20)
                    .padding(.bottom, 4)
                Text("나를 향한 응원 한마디가 기록됩니다.")
                    .grayText(fontSize: 12)
                
                Spacer()
                
                CheerList()
            }
        }
    }
}



struct CheerList: View {
    
    @StateObject var model = dataModel()
    
    var body: some View {
        VStack {
            
            List{
                
                ForEach(model.data, id: \.objectID) { obj in
                    //Extracting data from obj
                    Text(model.getValue(obj: obj))
                }
                .onDelete(perform: model.deleteData(indexSet:))
            }
            .listStyle(InsetGroupedListStyle())
            .onAppear {
                model.readData()
            }
        }
    }
}



class dataModel: ObservableObject {
    @Published var data: [NSManagedObject] = []
    @Published var cheerText = ""
    let context = persistentContainer.viewContext
    
    init() {
        readData()
    }
    
    func readData() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CheerData")
        
        do {
            let results = try context.fetch(request)
            
            self.data = results as! [NSManagedObject]
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func writeData() {
        let entity = NSEntityDescription.insertNewObject(forEntityName: "CheerData", into: context)
        
        entity.setValue(cheerText, forKey: "cheer")
        
        do {
            try context.save()
            
            self.data.append(entity)
            
            cheerText = ""
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteData(indexSet: IndexSet) {
        
        for index in indexSet {
            
            do {
                let obj = data[index]
                context.delete(obj)
            
                try context.save()
                
                let index = data.firstIndex(of: obj)
                data.remove(at: index!)
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
    func getValue(obj: NSManagedObject) -> String {
        
        return obj.value(forKey: "cheer") as! String
    }
    
    
}




struct CheerLogView_Previews: PreviewProvider {
    static var previews: some View {
        CheerLogView()
    }
}
