import SwiftUI

struct SystemImageView: View {

    var size: CGFloat
    var systemName = ""

    var body: some View {
        Image(systemName:systemName)
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(getGeneralColor())
    }
}

struct SignView: View {

    var size: CGFloat
    var value: String

    var body: some View {

        Text(" \(value) ")
            .font(.system(size: size))
            .fontWeight(.bold)
            .foregroundColor(getGeneralColor())
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

    var body: some View {
        Button {
        } label: {
            Text(value)

        }
        .modifier(ButtonTextViewModifier(sizeOfButton: size, sizeOfText: sizeOfText))
    }
}

struct ButtonTextViewModifier: ViewModifier{

    var sizeOfButton: CGFloat
    var sizeOfText: CGFloat

    func body(content: Content) -> some View {
        content
            .font(.system(size: sizeOfText))
            .frame(width: sizeOfButton, height: sizeOfButton)
            .foregroundColor(.white)
            .frame(width: sizeOfButton * 1.2, height: sizeOfButton * 1.2)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.green)
                    .opacity(0.9))
    }
}
