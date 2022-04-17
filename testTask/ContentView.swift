//
//  ContentView.swift
//  testTask
//
//  Created by anushkinz on 16/4/22.
//

import SwiftUI



struct ContentView: View {
    
    @State private var selectedView = 1
    
    var body: some View {
        TabView(selection: $selectedView){
            home()
                .tabItem{
                    Image("house")
                    Text("Home")
                }.tag(1)
            profile()
                .tabItem{
                    Image("person")
                    Text("Profile")
                }.tag(2)
            
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
}
