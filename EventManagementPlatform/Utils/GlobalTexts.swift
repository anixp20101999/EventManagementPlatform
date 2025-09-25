import SwiftUI

struct TitleText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:25))
            .foregroundStyle(color ?? .black)

    }
}

struct DescriptionText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:16))
            .foregroundStyle(color ?? .black)

    }
}

struct BodyText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:14))
            .foregroundStyle(color ?? .black)

    }
}

struct CategoryText : View {
    var title : String
    var color: Color?
    var body: some View {
        Text(title)
            .font(.system(size:14))
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
