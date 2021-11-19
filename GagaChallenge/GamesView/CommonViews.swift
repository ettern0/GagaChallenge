import SwiftUI

struct SystemImageView: View {

    var size: CGFloat
    var systemName = ""

    var body: some View {
        Image(systemName:systemName)
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
    }
}


struct SignView: View {

    var digit: String
    var size: CGFloat

    var body: some View {

        Text(" \(digit) ")
            .font(.system(size: size))
           // .fontWeight(.bold)
            .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
    }
}

struct ButtonImageView: View {

    var size: CGFloat
    var systemName = ""
    var signColor: Color = .green
    var backgroundColor: Color = .white

    var body: some View {
        Button {

        } label: {
            Image(systemName: systemName)
                .resizable()
                .frame(width: size, height: size)
                .foregroundColor(signColor)
                .frame(width: size * 1.2, height: size * 1.2)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(backgroundColor))
        }
    }
}

struct ButtonTextView: View {

    var size: CGFloat
    var sizeOfText: CGFloat
    var value = ""
    var signColor: Color = .white
    var backgroundColor: Color = .green

    var body: some View {
        Button {

        } label: {
            Text(value)
                .font(.system(size: sizeOfText))
                .frame(width: size, height: size)
                .foregroundColor(signColor)
                .frame(width: size * 1.2, height: size * 1.2)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(backgroundColor))
        }
    }
}

