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
    
    @State var selectedIndex = 0 // Track the selected event
    
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
        
        ZStack {
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
                        Text(viewModel.items?.data.results[selectedIndex].eventName ?? "Event") // Show event name
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }
//            .frame(height: 400)
            TabView(selection: $selectedIndex) {
                ForEach(0..<(viewModel.items?.data.results.count ?? 0) , id: \.self) { index in
                    VStack {
                        Image(systemName: "balloon")
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text(viewModel.items?.data.results[index].eventName ?? "Event")
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hides page index dots
        }
        .navigationBarBackButtonHidden(true)
    }
}
