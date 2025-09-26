//
//  EventDetailsScreen.swift
//  EventManagementPlatform
//
//  Created by Animesh Rout on 26/09/25.
//

import SwiftUI

struct EventDetailsScreen: View {
    @StateObject var viewModel = EventDetailsViewModel()
    var eventId : String
    var body: some View {
        
            ZStack{
                TitleText(title:"Event Details")
                GlobalBackButton(color:.gray)
                    .frame(maxWidth:.infinity,alignment:.leading)
            }
            .padding(.top,20)
        ScrollView{
            VStack(spacing: 0) {
                TabView {
                    ForEach(Array(viewModel.items?.data.eventImageUrls.enumerated() ?? [].enumerated()), id: \.offset) { i, item in
                        AsyncImage(url: URL(string: "\(item)?tr=w-800,h-450,c-force")) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 250)
                                    .clipped()
                                    .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .topRight]))
                            } else {
                                Color.gray
                                    .frame(height: 250)
                                    .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .topRight]))
                            }
                        }
                        .tag(i)
                    }
                }
                .frame(height: 250)
                .tabViewStyle(.page)
//                .indexViewStyle(.page(backgroundDisplayMode: .always))
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        DescriptionText(title:viewModel.items?.data.eventName ?? "")
                        Spacer()
                        CategoryText(title:viewModel.items?.data.eventCategory ?? "")
                            .padding(5)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.orange)
                                    .opacity(0.2)
                            }
                    }
                    HStack {
                        BodyText(title: "₹ \(viewModel.items?.data.ticketPrice ?? 0.0)", color: .gray)
                        Spacer()
                        BodyText(title: formatDate(from:viewModel.items?.data.eventDate ?? ""), color: .gray)
                    }
                    BodyText(title:viewModel.items?.data.eventDescription ?? "")
                        .multilineTextAlignment(.leading)
                    
                    VStack(alignment:.leading) {
                        BodyText(title:"Reach out to learn more")
                        BodyText(title:viewModel.items?.data.organizerContact ?? "")
                    }
                    
                    BodyText(title:"\(viewModel.items?.data.numAttendees ?? 0) others are attending!", color:.blue)
                        .frame(maxWidth: .infinity, alignment: .center)

                    Button(action:{}, label: {
                        BodyText(title:"Buy Your Ticket")
                            .frame(maxWidth:.infinity)
                            .frame(height:35)
                            .background(.blue.opacity(0.3))
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                    })
                }
                .padding(10)
            }
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
            }
        }
        .onAppear{
            Task{
                try await viewModel.fetchItems(id:eventId)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

