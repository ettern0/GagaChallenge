import SwiftUI

struct PlusView: View {

    var body: some View {
        Image(systemName:"plus")

            .resizable()
            .frame(width: 80.0, height: 80.0)
            .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
            .frame(width: 150.0, height: 150.0)
            .padding(.horizontal)
    }

}

struct MinusView: View {

    var body: some View {
        Image(systemName:"minus")

            .resizable()
            .frame(width: 80.0, height: 80.0)
            .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
            .frame(width: 150.0, height: 150.0)
            .padding(.horizontal)
    }

}

struct MultiplyView: View {

    var body: some View {
        Image(systemName:"multiply")

            .resizable()
            .frame(width: 80.0, height: 80.0)
            .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
            .frame(width: 150.0, height: 150.0)
            .padding(.horizontal)
    }

}

struct EqualView: View {

    var body: some View {
        Image(systemName:"equal")

            .resizable()
            .frame(width: 80.0, height: 80.0)
            .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
            .frame(width: 150.0, height: 150.0)
            .padding(.horizontal)
    }

}
