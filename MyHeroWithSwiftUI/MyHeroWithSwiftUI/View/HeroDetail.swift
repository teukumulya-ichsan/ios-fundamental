//
//  HeroDetail.swift
//  MyHeroWithSwiftUI
//
//  Created by Teuku Mulia Ichsan on 03/07/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import SwiftUI


struct HeroDetail : View {
    var hero : Hero
    
    var body: some View {
        ScrollView{
            VStack {
                // Hero Name title
                Spacer(minLength: 20)
                Text(hero.name)
                    .font(.system(size:25)).bold()
                
                // Photo hero
                Spacer(minLength: 70)
                Image(hero.photo)
                    .resizable().scaledToFit().frame(width:240, height: 240,alignment: .center)
                
                // Desc Hero
                Spacer(minLength: 30)
                Text(hero.description)
                    .font(.system(size: 16)).multilineTextAlignment(.center)
            }
        }.padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
    }
}


struct HeroDetail_Previews: PreviewProvider {
    static var previews: some View {
        HeroDetail(hero: heroes[0])
    }
}
