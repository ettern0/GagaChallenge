
import SwiftUI

struct MultiplicationGameView: View {

    var body: some View {
        Text("test")
    }
}

struct DrawView: View {

    @State var points: [[CGPoint]] = [[]]

    var body: some View {

        ZStack {
            Rectangle() // replace it with what you need
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
                .gesture(DragGesture().onChanged( { value in
                    self.addNewPoint(value)
                })
                .onEnded( { value in
                    points.append([])
                }))

            ForEach(points.indices, id: \.self) { index in
                DrawShape(points: points[index])
                    .stroke(lineWidth: 5) // here you put width of lines
                    .foregroundColor(.blue)
            }
        }
    }

    private func addNewPoint(_ value: DragGesture.Value) {
        points[points.endIndex - 1].append(value.location)
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

