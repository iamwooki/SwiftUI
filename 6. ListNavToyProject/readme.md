# SwiftUI List & Nav Practice (JSON, Assets)
### 1. JSON형식과 일치하는 구조체/클래스 생성
```JSON
//carData.json
[
    {
        "id": "aa32jj887hhg55",
        "name": "Tesla Model 3",
        "description": "Luxury 4-door all-electic car. Range of 310 miles. 0-60mph in 3.2 seconds",
        "isHybrid": false,
        "imageName": "tesla_model_3"
    }
]
```
```Swift
//Car.swift
import SwiftUI
//Identifiable : ListView에서 식별되도록
struct Car: Codable, Identifiable{
    var id: String
    var name: String
    
    var description: String
    var isHybrid: Bool
    
    var imageName: String
}

```
### 2. JSON을 로드하기 위한 Swift 파일생성
```Swift
//CarData.swift
import UIKit
import SwiftUI

//load json file
var carData : [Car] = loadJson("carData.json")

func loadJson<T: Decodable>(_ filename: String) -> T{
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("\(filename) not found.")
    }
    
    do{
        data = try Data(contentsOf: file)
    } catch{
        fatalError("Could not load \(filename): (error)")
    }
    
    do{
        return try JSONDecoder().decode(T.self, from: data)
    } catch{
        fatalError("Unable to parse \(filename): (Error)")
    }
}

```
### 3. 데이터 저장소 추가
```Swift
//CarStore.swift
import SwiftUI
import Combine
//ObservableObject : 최신 데이터가 사용자에게 항상 표시되도록
class CarStore: ObservableObject{
    //List뷰를 최신 데이터로 유지하기 위해서 게시된 프로퍼티 포함
    @Published var cars: [Car]
    
    init (cars: [Car]){
        self.cars = cars
    }
}

```
### 4. ContentView 설계
```Swift
//ContentView.swift
import SwiftUI
struct ContentView: View {
    //설계에선 ObservableObject -> 사용하기 위한 선언에선 ObservedObject
    @ObservedObject var carStore : CarStore = CarStore(cars:carData)
    
    var body: some View {
        List{
            ForEach(carStore.cars){ car in
                //Extract SubView
                ListCell(car: car)
            }
        }
    }
}
//Extract SubView
struct ListCell: View {
    
    var car: Car
    var body: some View {
        HStack{
            Image(car.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height: 60)
            Text(car.name)
        }
    }
}

```

### 5. 상세 뷰 설계
```Swift
//CarDetail.swift
import SwiftUI

struct CarDetail: View {
    let selectedCar: Car
    
    var body: some View {
        Form{
            Section(header: Text("Car Details")){
                Image(selectedCar.imageName)
                    .resizable()
                    .cornerRadius(12.0)
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text(selectedCar.name)
                    .font(.headline)
                
                Text(selectedCar.description)
                    .font(.body)
                
                HStack{
                    Text("Hybrid")
                        .font(.headline)
                        Spacer()
                        Image(systemName:selectedCar.isHybrid ? "checkmark.circle" : "xmark.circle")
                }
                
                
            }
        }
    }
}

struct CarDetail_Previews: PreviewProvider {
    static var previews: some View {
        CarDetail(selectedCar: carData[0])
    }
}

```
### 6. 내비게이션 추가
```Swift
//ContentView.swift
struct ContentView: View {
    @ObservedObject var carStore : CarStore = CarStore(cars:carData)
    
    var body: some View {
        //네비게이션 뷰
        NavigationView{
            List{
                ForEach(carStore.cars){ car in
                    ListCell(car: car)
                }
            }
        }

    }
}
struct ListCell: View {
    
    var car: Car
    var body: some View {
        //페이지 이동
        NavigationLink(destination: CarDetail(selectedCar: car)){
            HStack{
                //contents
            }
        }

    }
}
```

### 6. 데이터 추가 뷰 설계
```Swift
//AddNewCar.swift
struct AddNewCar: View {

    @ObservedObject var carStore : CarStore
    
    @State var isHybrid = false
    @State var name: String = ""
    @State var description: String = ""
    
    var body: some View {
        Form{
            Section(header: Text("Car Details")){
                Image(systemName: "car.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                DataInput(title: "Model", userInput: $name)
                DataInput(title: "Description", userInput: $description)
                
                Toggle(isOn:$isHybrid){
                    Text("Hybrid").font(.headline)
                }.padding()
                
                Button(action:addNewCar){
                    Text("Add Car")
                }
            }
        }
        
    }
    
    func addNewCar(){
        let newCar = Car(id: UUID().uuidString,
                         name:name, description: description,
                         isHybrid: isHybrid, imageName: "tesla_model_3")
        
        carStore.cars.append(newCar)
        //추가 후 화면전환 필요
    }
}

//sub view
struct DataInput: View{
    var title:String
    @Binding var userInput: String
    
    var body: some View{
        VStack(alignment: HorizontalAlignment.leading){
            Text(title)
                .font(.headline)
            TextField("Enter \(title)", text: $userInput)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
    }
}
struct AddNewCar_Previews: PreviewProvider {
    static var previews: some View {
        //carData 배열이 뷰에 전달되도록
        //@ObservedObject var carStore : CarStore에 대응
        AddNewCar(carStore: CarStore(cars: carData))
    }
}
```
### 7. Add / Edit 버튼 추가
```Swift
struct ContentView: View {
    @ObservedObject var carStore : CarStore = CarStore(cars:carData)
    
    var body: some View {
        NavigationView{
            List{
                ForEach(carStore.cars){ car in
                    ListCell(car: car)
                }
                .onDelete(perform: deleteItems)
                .onMove(perform: moveItems)
            }
            .navigationBarTitle(Text("EV Cars"))
            .navigationBarItems(leading:NavigationLink(destination:AddNewCar(carStore: self.carStore)){
                Text("Add")
                    .foregroundColor(.blue)
            }, trailing: EditButton())
        }
    }
    func deleteItems(at offsets: IndexSet){
        carStore.cars.remove(atOffsets: offsets)
        //contents
    }

    func moveItems(from source:IndexSet, to destination: Int){
        carStore.cars.move(fromOffsets:source, toOffset: destination)
        //contents
    }
}
```