//
//  ContentView.swift
//  MyHeroWithSwiftUI
//
//  Created by Teuku Mulia Ichsan on 03/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            HeroList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
