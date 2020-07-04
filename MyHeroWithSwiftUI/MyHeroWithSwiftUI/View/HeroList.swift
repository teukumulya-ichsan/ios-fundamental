//
//  HeroList.swift
//  MyHeroWithSwiftUI
//
//  Created by Teuku Mulia Ichsan on 03/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI

struct HeroList : View {
    var body: some View {
        List(heroes) { hero in
            ZStack{
                HeroRow(hero: hero)
                NavigationLink(destination: HeroDetail(hero: hero)){
                    EmptyView()
                }
            }
        }.navigationBarTitle(Text("Pahlawan Indonesia"), displayMode: .inline)
    }
}
