//
//  EventDetailsScreen.swift
//  EventManagementPlatform
//
//  Created by Animesh Rout on 26/09/25.
//

import SwiftUI

struct EventDetailsScreen: View {
    var body: some View {
        
            ZStack{
                TitleText(title:"Event Details")
                GlobalBackButton(color:.gray)
                    .frame(maxWidth:.infinity,alignment:.leading)
            }
        VStack{
            
//            TabView(selection: $index) {
//                      ForEach(Array(items.enumerated()), id: \.element.id) { i, item in
//                          content(item)
//                              .tag(i)
//                      }
//                  }
//                  .tabViewStyle(.page) // paging + dots
//                  .indexViewStyle(.page(backgroundDisplayMode: .interactive))
//                  .onAppear { startAutoScrollIfNeeded() }
//                  .onDisappear { stopAutoScroll() }
            
            Spacer()
        }
        .onAppear{
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

