import SwiftUI
import MapKit

struct EventLocation: Identifiable {
    let id: String
    let eventName: String
    let eventImageURL: String
    let latitude: Double
    let longitude: Double
}

struct MapLocation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct EventMapScreen: View {
    @ObservedObject var viewModel: DiscoverEventsViewModel
    @State var selectedIndex = 0
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        // Default region based on the first event
        let coordinate = CLLocationCoordinate2D(
            latitude: viewModel.items?.data.results[selectedIndex].latitude ?? 0.0,
            longitude: viewModel.items?.data.results[selectedIndex].longitude ?? 0.0
        )
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        
        ZStack{
            TitleText(title:"Event Maps")
            GlobalBackButton(color:.gray)
                .frame(maxWidth:.infinity,alignment:.leading)
        }
        .padding(.top,20)
        
        ZStack{
            // Map with dynamic region based on selected event
            Map(coordinateRegion: .constant(region),
                interactionModes: .all,
                annotationItems: viewModel.items?.data.results.map { event in
                MapLocation(coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude))
            } ?? []) { location in
                MapAnnotation(coordinate: location.coordinate) {
                    VStack {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .frame(width: 20, height: 30)
                            .foregroundColor(.black)
                    }
                }
            }
            
            TabView(selection: $selectedIndex) {
                ForEach(Array(viewModel.items?.data.results.enumerated() ?? [].enumerated()), id:\.offset) { index,event in
                    HStack {
                        AsyncImage(url: URL(string: "\(event.eventImageURL)?tr=w-800,h-450,c-force")) { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .bottomLeft]))
                            } else {
                                Color.gray
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .bottomLeft]))
                            }
                        }
                        
                        HStack {
                            VStack(alignment:.leading){
                                DescriptionText(title: event.eventName)
                                BodyText(title: formatDate(from: event.eventDate), color: .gray)
                            }
                            Spacer()
                            NavigationLink(destination: EventDetailsScreen(eventId:event.eventID)){
                                BodyText(title: "View Details")
                                    .padding(.all, 10)
                                    .frame(height: 35)
                                    .background(.blue.opacity(0.3))
                                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            }
                            
                        }
                    }
                    .padding(.trailing, 10)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.white)
                            .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                            .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                    }
                    .tag(index)
                }
            }
            .offset(y:250)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .navigationBarBackButtonHidden(true)
    }
}
