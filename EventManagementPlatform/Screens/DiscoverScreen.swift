//
//  DiscoverScreen.swift
//  EventManagementPlatform
//
//  Created by Mansi Laad on 25/09/25.
//

import SwiftUI

struct DiscoverScreen: View {
    @StateObject var viewModel = DiscoverEventsViewModel()
    var body: some View {
        VStack{
            HeaderView(viewModel:viewModel)
            SearchBar(viewModel:viewModel)
            ResultsView(viewModel:viewModel)
        }
        .padding(.all,10)
            .onAppear{
                Task{
                    try await viewModel.fetchItems()
                }
            }
    }
}

struct HeaderView: View {
    @ObservedObject var viewModel : DiscoverEventsViewModel
    var body: some View {
        ZStack{
            TitleText(title:"Discover")
            Image(systemName:"map")
                .foregroundStyle(.blue)
                .frame(maxWidth:.infinity,alignment:.trailing)
        }
    }
}

struct SearchBar: View {
    @ObservedObject var viewModel : DiscoverEventsViewModel
    var body: some View {
        HStack(spacing:10){
            Image(systemName:"magnifyingglass")
            TextField("Search", text: $viewModel.searchedText)
        }
        .frame(maxWidth:.infinity,alignment: .leading)
        .padding(.all,10)
        .background{
            RoundedRectangle(cornerRadius:20)
                .fill(.white)
                .shadow(radius:5)
        }
    }
}

struct ResultsView: View {
    @ObservedObject var viewModel : DiscoverEventsViewModel
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
        ScrollView(.vertical,showsIndicators:false){
            
            ForEach(viewModel.items?.data.results ?? [],id:\.eventID){event in
                HStack(spacing:10){
                    AsyncImage(url: URL(string:"\(event.eventImageURL)")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width:80,height:80)
                        }
                        else{
                            Color.gray
                        }
                    }
                    HStack{
                        VStack(alignment:.leading){
                            DescriptionText(title:event.eventName)
                            BodyText(title:"₹ \(event.ticketPrice)", color:.gray)
                        }
                        Spacer()
                        VStack{
                            CategoryText(title:event.eventCategory)
                        }
                    }
                }
                .padding(.trailing,10)
                .background{
                    RoundedRectangle(cornerRadius:20)
                        .fill(.white)
                        .shadow(radius:5)
                }
            }
        }
    }
}
