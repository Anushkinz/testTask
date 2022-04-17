//
//  profile.swift
//  testTask
//
//  Created by anushkinz on 16/4/22.
//

import SwiftUI

struct profile: View {
    
    @State private var shouldShowImagePicker = false
    @State private var shouldShowCarImagePicker = false
    @State private var textField = true
    @State private var image: UIImage?
    @State private var carimage: UIImage?
    @State private var text = ""
    @State private var changeContent = ""
    @State private var textButton = "edit"
    
    var body: some View {
        
        NavigationView{
            ScrollView{
                VStack{
                    
                    Group{
                        VStack{
                            HStack{
                                Text("Profile pirture")
                                Spacer()
                                Button("edit"){
                                    shouldShowImagePicker.toggle()
                                }

                            }.padding()
                            Group{
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 172, height: 172)
                                        .clipShape(Circle())
                                }else{
                                    Image("ava")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                        .frame(width: 172, height: 172, alignment: .center)
                                }
                            }

                        }.onAppear{
                            loadImage(key: "ava")
                        }
                    }
                    
                    Divider()
                    
                    Group{
                        VStack{
                            HStack{
                                Text("Cover photo")
                                Spacer()
                                Button("edit"){
                                    shouldShowCarImagePicker.toggle()
                                }
                            }.padding()
                            Group{
                                if let Carimage = self.carimage {
                                    Image(uiImage: Carimage)
                                        .resizable()
                                        .scaledToFill()
                                        .edgesIgnoringSafeArea(.all)

                                }else{
                                    Image("car")

                                }
                            }.frame(width: 345, height: 195, alignment: .center)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding()
                        }.onAppear{
                            loadImage(key: "car")
                        }
                    }
                    
                    
                    Group{
                        HStack{
                            Text("Bio")
                            Spacer()
                            Button(textButton){
                                if textButton == "edit"{
                                    textField = false
                                }else{
                                    textField = true
                                    textButton = "edit"
                                    UserDefaults.standard.set(text, forKey: "bio")
                                }
                            }
                        }.padding()
                        Divider()
                        Group{
                            TextField("Describe yourself...", text: $text)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(textField)
                                .disabled(textField)
                                .onChange(of: text){text in
                                    print("YEs")
                                    textButton = "save"
                                }
                        }
                        .padding()
                        .onAppear{
                            self.textButton = "edit"
                            self.text = UserDefaults.standard.object(forKey: "bio") as? String ?? ""
                        }
                    }
                    
                    Divider()
                    
                }
                
                .navigationViewStyle(StackNavigationViewStyle())
                .fullScreenCover(isPresented: $shouldShowImagePicker, onDismiss: nil) {
                    ImagePicker(image: $image, key: "ava")
                        .ignoresSafeArea()
                }
                .fullScreenCover(isPresented: $shouldShowCarImagePicker, onDismiss: nil) {
                    ImagePicker(image: $carimage, key: "car")
                        .ignoresSafeArea()
            }
            
            }
            
        }
        
    }
    
    func loadImage(key: String){
        guard let data = UserDefaults.standard.data(forKey: key) else {return}
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        if (key == "ava"){
            image = UIImage(data: decoded)
        }else{
            carimage = UIImage(data: decoded)
        }
    }
    
    
    
    struct profile_Previews: PreviewProvider {
        static var previews: some View {
            profile()
        }
    }
    
    struct ImagePicker: UIViewControllerRepresentable {
        
        @Binding var image: UIImage?
        var key: String?
        
        private let controller = UIImagePickerController()
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(parent: self)
        }
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            
            let parent: ImagePicker
            
            init(parent: ImagePicker) {
                self.parent = parent
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                parent.image = info[.originalImage] as? UIImage
                guard let data = parent.image!.jpegData(compressionQuality: 0.5) else {return}
                let encode = try! PropertyListEncoder().encode(data)
                UserDefaults.standard.set(encode, forKey: parent.key!)
                picker.dismiss(animated: true)
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true)
            }
            
        }
        
        func makeUIViewController(context: Context) -> some UIViewController {
            controller.delegate = context.coordinator
            return controller
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        
    }
}
