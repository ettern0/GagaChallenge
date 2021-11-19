import SwiftUI

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
