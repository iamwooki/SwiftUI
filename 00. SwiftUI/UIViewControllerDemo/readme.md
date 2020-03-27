# SwiftUI & UIViewController
- ```UIViewControllerRepresentable``` 프로토콜 이용

### UIImagePickerController 래핑

```Swift
//MyImagePicker.swift
import SwiftUI
//UIViewCOntrollerRepresentable 프로토콜
struct MyImagePicker: UIViewControllerRepresentable{
    func makeUIViewController(context: UIViewControllerRepresentableContext<MyImagePicker>) -> UIImagePickerController{
        let picker = UIImagePickerController()
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<MyImagePicker>) {
        //conents
        
    }
}

struct MyImagePicker_Previews: PreviewProvider{
    static var previews: some View{
        MyImagePicker()
    }
}
```

### ContentView 설계
> 버튼을 클릭하면 이미지를 선택할 수 있도록 MyImagePicker 뷰가 VStack 위로 표시될 것(ZStack)

```Swift
struct ContentView: View {
    @State var imagePickerVisible: Bool = false
    @State var selectedImage: Image? = Image(systemName:"photo")
    
    var body: some View {
        ZStack{
            VStack{
                selectedImage?
                    .resizable()
                    .aspectRatio(contentMode:.fit)
                
                Button(action:{
                    withAnimation{
                        self.imagePickerVisible.toggle()
                    }
                }){
                    Text("Select an Image")
                }
            }.padding()
            
            if (imagePickerVisible){
                MyImagePicker()
            }
        }
    }
}
```

### MyImagePicker 완성
1. MyImagePicker.swift 파일을 완성하기 위해 ContentView 상태 프로퍼티에 대한 바인딩 선언 필요
```Swift
struct MyImagePicker: UIViewControllerRepresentable{
    @Binding var imagePickerVisible: Bool
    @Binding var selectedImage: Image?
```
2. 코디네이터를 UIImagePickerView 인스턴스에 대한 델리게이트로 동작하도록 구현
>> ```UINavigationControllerDelegate```, ```UIImagePickerControllerDelegate``` 프로토콜 준수

>> (알림:이미지가 선택되거나 취소될 때) ```imagePickerControllerDidCancel```delegate, ```didFinishPickingMediaWithInfo```delegate 메소드 구현
3.상태 프로퍼티 바인딩에 대한 로컬 복사본
```Swift
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        @Binding var imagePickerVisible: Bool
        @Binding var selectedImage: Image?
        
        //Binding 초기화
        init(imagePickerVisible: Binding<Bool>, selectedImage: Binding<Image?>){
            _imagePickerVisible = imagePickerVisible
            _selectedImage = selectedImage
        }
        //imagePickerController 이미지를 선택한 경우
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            //선택된 img가 전달될 것이므로 프로퍼티에 할당
            selectedImage = Image(uiImage: uiImage)
            imagePickerVisible = false
        }
        //imagePickerController 취소 버튼을 누를 경우
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            imagePickerVisible = false
        }
    }
```

4. 상태 프로퍼티 바인딩을 통해 전달
```Swift
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
    }
```
5. ```makeUIViewController()```메소드를 수정해서 델리게이트로 코디네이터 할당
```Swift
//struct MyImagePicker
    func makeUIViewController(context: UIViewControllerRepresentableContext<MyImagePicker>) -> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
```
6. 두 개의 상태 프로퍼티 ```MyImagePicker``` 인스턴스로 전달하기
```Swift
//ContentView.swift
if (imagePickerVisible){
    MyImagePicker(imagePickerVisible: $imagePickerVisible, selectedImage: $selectedImage)
}
```