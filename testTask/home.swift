//
//  home.swift
//  testTask
//
//  Created by anushkinz on 16/4/22.
//

import SwiftUI

struct home: View {
    
    @State private var image: UIImage?
    @State private var carimage: UIImage?
    @State private var text = ""
    
    var body: some View {
        // first view
        ScrollView{
            ZStack {
                VStack{
                    VStack{
                        if let Carimage = self.carimage {
                            Image(uiImage: Carimage)
                                .resizable()
                                .scaledToFill()
                                .edgesIgnoringSafeArea(.all)
                        }else{
                            Image("car")
                        }
                    }
                    .frame(width: 345, height: 195, alignment: .center)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .onAppear{
                        loadImage(key: "car")
                        
                    }
                    VStack{
                        Group{
                            Group{
                                if let image = self.image {
                                    Image(uiImage: image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                }else{
                                    Image("ava")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipShape(Circle())
                                }
                            }
                            .frame(width: 172, height: 172, alignment: .center)
                        }
                        .frame(width: 192, height: 192, alignment: .center)
                        .background(Color.white)
                        .cornerRadius(100)
                            
                        Text("John Doe")
                            .font(.largeTitle)
                        Text(text)
                            .onAppear{
                                self.text = UserDefaults.standard.object(forKey: "bio") as? String ?? "This is Bio"
                            }
                    }.onAppear{
                        loadImage(key: "ava")
                    }
                    .offset(y: -100)
                    Divider()
                        .padding()
                    VStack{
                        HStack{
                            Text("Posts")
                                .padding(.leading)
                            Spacer()
                        }
                        HStack{
                            Group{
                                Group{
                                    Image("ava")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                                .frame(width: 40, height: 40, alignment: .center)
                                    .clipShape(Circle())
                                Text("John Doe")
                            }
                            Spacer()
                            
                        }.padding()
                        Text("If you're looking for a cute dessert for a party or even just a little pick-me up, try making some of @bakedbyjosie's bite sized cheesecakes! For more delicious baked goods, watch Baked by Josie")
                            .padding()
                        HStack{
                            Image("ava")
                        }
                    }.padding(.bottom, 60)
                    VStack{
                        HStack{
                            Group{
                                Group{
                                    Image("ava")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                }
                                .frame(width: 40, height: 40, alignment: .center)
                                    .clipShape(Circle())
                                Text("John Doe")
                            }
                            Spacer()
                            
                        }.padding()
                        Text("If you're looking for a cute dessert for a party or even just a little pick-me up, try making some of @bakedbyjosie's bite sized cheesecakes! For more delicious baked goods, watch Baked by Josie")
                            .padding()
                        HStack{
                            Image("ava")
                        }
                    }.padding(.bottom, 20)
                }
            }
        }.tag(1)
        
        
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
}

struct home_Previews: PreviewProvider {
    static var previews: some View {
        home()
    }
}
