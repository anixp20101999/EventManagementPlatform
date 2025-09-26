import SwiftUI

struct TitleText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:20))
            .foregroundStyle(color ?? .black)

    }
}

struct DescriptionText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:14))
            .foregroundStyle(color ?? .black)
            .fontWeight(.bold)

    }
}

struct BodyText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:12))
            .foregroundStyle(color ?? .black)

    }
}

struct CategoryText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:10))
            .foregroundStyle(color ?? .black)

    }
}

struct ProgramTitle: View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:20))
            .foregroundStyle(color ?? .black)
    }}
