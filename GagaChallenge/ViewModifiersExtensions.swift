import SwiftUI

//MARK: +View modifiers
struct SpinTransitionModifier: ViewModifier {
    let angle: Double
    let anchor: UnitPoint
    let scale: CGSize
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: angle), anchor: anchor)
    }
}

public extension AnyTransition {
    static func spinIn(anchor: UnitPoint) -> AnyTransition {
        withAnimation {
            .modifier(
                active: SpinTransitionModifier(angle: 90, anchor: anchor, scale: CGSize(width: 0, height: 0)),
                identity: SpinTransitionModifier(angle: 0, anchor: anchor, scale: CGSize(width: 1, height: 1)))
        }
    }

    static func spinOut(anchor: UnitPoint) -> AnyTransition {
        withAnimation {
            .modifier(
                active: SpinTransitionModifier(angle: -90, anchor: anchor, scale: CGSize(width: 1, height: 1)),
                identity: SpinTransitionModifier(angle: 0, anchor: anchor, scale: CGSize(width: 0, height: 0)))
        }
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct ButtonTextViewModifier: ViewModifier{

    var sizeOfButton: CGFloat
    var sizeOfText: CGFloat
    var rectColor: Color?

    func body(content: Content) -> some View {
        content
            .font(.system(size: sizeOfText))
            .frame(width: sizeOfButton, height: sizeOfButton)
            .foregroundColor(.white)
            .frame(width: sizeOfButton * 1.2, height: sizeOfButton * 1.2)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(rectColor ?? .green)
                    .opacity(0.9))
    }
}

//MARK: +General Views
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

struct DrawShape: Shape {

    var points: [CGPoint]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        guard let firstPoint = points.first else { return path }

        path.move(to: firstPoint)
        for pointIndex in 1..<points.count {
            path.addLine(to: points[pointIndex])

        }
        return path
    }
}
