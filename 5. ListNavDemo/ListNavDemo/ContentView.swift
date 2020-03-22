//
//  ContentView.swift
//  ListNavDemo
//
//  Created by HyunWook Hong on 2020/03/22.
//  Copyright © 2020 HyunWook Hong. All rights reserved.
//

import SwiftUI

//리스트 구조체 정의
struct ToDoItem: Identifiable{
    var id = UUID()
    var task: String
    var imageName: String
}

var listData: [ToDoItem] = [
    ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
    ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
    ToDoItem(task: "Wash the car", imageName: "car.fill")
]

struct ContentView: View {
    @State var toggleStatus = true
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("Settings")){
                    Toggle(isOn: $toggleStatus){
                        Text("Allow Notifications")
                    }
                }
                Section(header: Text("To Do Tasks")){
                    ForEach (listData){ item in
                        HStack{
                            NavigationLink(destination: Text(item.task)){ //each ContentView
                                Image(systemName:item.imageName)
                                Text(item.task)
                            }
                        }

                    }//삭제 구현
                    .onDelete(perform: deleteItem)
                    //요소 이동 구현
                    .onMove(perform: moveItem)
                    
                }
            }
            .navigationBarTitle(Text("To Do List"))
            .navigationBarItems(trailing: EditButton())
        }
        
    
    }
}
func deleteItem(at offsets: IndexSet){
    //contents
    //데이터 소스에서 항목을 삭제하는 코드가 여기 온다.
}

func moveItem(from source: IndexSet, to destination: Int){
    //contents
    //항목을 재배열하는 코드가 온다.
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
