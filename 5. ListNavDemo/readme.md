# List
- (Container) 리스트 셀은 컴포넌트 종류 개수 제한이 없음
- (Navigation) 일반적으로 ListView는 다른 화면으로 이동하는 수단으로 사용
>>: List선언부를 NavigationView로 감싸고 각 행을 NavigationLink로 감싸서 구현
###  1. Dynamic List
: ```Identifiable``` 프로토콜을 따르는 클래스 또는 구조체 내에 포함되어야 함

> 프로토콜을 사용하려면 리스트에서 각 항목을 고유하게 식별하는 id라는 이름의 프로퍼티가 객체가 있어야 함, 수백 개의 다른 표준 스위프트 타입뿐만 아니라 String, Int, UUID 타입을 포함한 ```Hashable``` 프로토콜을 따르는 모든 스위프트 타입이나 커스텀 타입이 id프로퍼티가 될 수 있다. 
>> UUID를 사용하면 ```UUID()``` 메소드는 항목마다 고유한 ID를 자동으로 생성하는데 사용
Define)
```swift
struct ToDoItem  : Identifiable{
    var id = UUID()
    //뷰 이동의 경우 task: View로 설정하면 됨
    var task: String
    var imageName: String
}
```
Use)
```Swift
.
.
.
    var listData: [ToDoItem] = [
        ToDoItem(task: "Take out trash", imageName: "trash.circle.fill"),
        ToDoItem(task: "Pick up the kids", imageName: "person.2.fill"),
        ToDoItem(task: "Wash the car", imageName: "car.fill")
    ]

struct ContentView: View{
    var body: some View{
        //case 1)
        List(listData){ item in
            HStack{
                Image(systemName:item.imageName)
                Text(item.task)
            }
        }
        //case 2)
        List{
            ForEach (listData){ item in
                HStack{
                    Image(systemName:item.imageName)
                    Text(item.task)
                }
            }
        }
    }
}
.
.
.
```
### 2. Toggle & Section
```Swift
struct ContentView: View{
    @State var toggleStatus = true

    var body : some View{
        List{
            Section(header: Text("Settings")){
                Toggle(isOn: $toggleStatus){
                    Text("Allow Notifications")
                }
            }
            Section(header: Text("To Do Tasks")){
                ForEach (listData){ item in
                    HStack{
                        Image(systemName:item.imageName)
                        Text(item.task)
                    }
                }
            }
        }
    }
}
```

### 3. NavigationView & NavigationLink
Define)
```Swift
NavigationView{
    List{
        //contents
    }
    .navigationBarTitle(Text("To Do List")) //상위 내비게이션 이름
    .navigationBarItems(trailing: Button(action: addTask){
        Text("Add") //오른쪽 추가버튼 생각
    })    
}
//action complement
func addTask(){

}
```
Use)
```Swift
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
```