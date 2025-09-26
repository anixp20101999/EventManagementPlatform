import SwiftUI
import Combine

struct DiscoverScreen: View {
    @StateObject var viewModel = DiscoverEventsViewModel()
    var body: some View {
        NavigationStack{
            VStack(spacing:20){
                HeaderView(viewModel:viewModel)
                SearchBar(viewModel:viewModel)
                ResultsView(viewModel:viewModel)
            }
            .padding(.horizontal,10)
            .onAppear{
                Task{
                    try await viewModel.fetchItems()
                }
            }
            .refreshable {
                Task{
                    try await viewModel.fetchItems()
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
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
                .disableAutocorrection(true)
                .onChange(of: viewModel.searchedText) { _, text in
                    viewModel.updateSearch(text)
                }
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
    @ObservedObject var viewModel: DiscoverEventsViewModel
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        if viewModel.state == .loading {
            Spacer(); Loader(); Spacer()
        } else if viewModel.state == .ui {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    if viewModel.visible.isEmpty {
                        TitleText(title: "No Results Found !!")
                    } else {
                        ForEach(viewModel.visible, id: \.eventID) { event in
                            NavigationLink(destination: EventDetailsScreen(eventId:event.eventID)) {
                                HStack(spacing: 10) {
                                    AsyncImage(url: URL(string: "\(event.eventImageURL)?tr=w-800,h-450,c-force")) { phase in
                                        if let image = phase.image {
                                            image.resizable()
                                                .frame(width: 70, height: 70)
                                                .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .bottomLeft]))
                                        } else {
                                            Color.gray
                                                .frame(width: 70, height: 70)
                                                .clipShape(RoundedCorner(radius: 15, corners: [.topLeft, .bottomLeft]))
                                        }
                                    }
                                    HStack {
                                        VStack {
                                            HStack{
                                                DescriptionText(title: event.eventName)
                                                Spacer()
                                                CategoryText(title: event.eventCategory)
                                                    .padding(5)
                                                    .background {
                                                        RoundedRectangle(cornerRadius: 5)
                                                            .fill(colors.randomElement() ?? .gray)
                                                            .opacity(0.2)
                                                    }
                                            }
                                            HStack {
                                                BodyText(title: "₹ \(event.ticketPrice)", color: .gray)
                                                Spacer()
                                                BodyText(title: formatDate(from: event.eventDate), color: .gray)
                                            }
                                        }
                                        Image(systemName: "chevron.right").foregroundStyle(.gray)
                                    }
                                    .padding(.vertical, 10)
                                }
                                .padding(.trailing, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(.white)
                                        .shadow(color: .black.opacity(0.05), radius: 2, x: 0, y: 1)
                                        .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                                }
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentItem: event)
                                }
                            }
                        }
                    }
                }
            }
        } else {
            Spacer(); TitleText(title: "No Results Found !!"); Spacer()
        }
    }
}


struct RoundedCorner: Shape {
    var radius: CGFloat = 20
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
