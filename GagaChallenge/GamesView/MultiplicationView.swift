
import SwiftUI

struct MultiplicationGameView: View {

    @State var curves: [[CGPoint]] = [[]]
    @State var arrayOfCountingOfPointsIntersections: [CGPoint: Int] = [:]
    @Binding var showGame: Bool

    let firstMultiplicationDigit = Int.random(in: 1...5)
    let secondMultiplicationDigit = Int.random(in: 1...5)
    var resultOfMultiply: Int {
        firstMultiplicationDigit * secondMultiplicationDigit
    }

    var answers: Array<AnyView>  {

        var result: Array<AnyView> = []
        result.append(AnyView(
            ButtonTextView(size: 70,
                           sizeOfText: 50,
                           value: resultOfMultiply.stringValue)))

        for _ in 0...2 {
            result.append(AnyView(
                ButtonTextView(
                    size: 70,
                    sizeOfText: 50,
                    value: Int.randomExept(of: resultOfMultiply, range: 0...25).stringValue
                )
            )
            )
        }

        return result.shuffled()
    }

    var pointsIntersection: [CGPoint] {
        guard curves.count >= 2 else { return [] }

        var intersections = [CGPoint]()
        for i in 0 ... curves.count - 2 {
            for j in i + 1 ... curves.count - 1 {
                let (line1, line2) = (curves[i], curves[j])
                let intersection = line1.intersections(with: line2)
                intersections.append(contentsOf: intersection)
            }
        }

        return intersections
    }

    var countOfIntersection: Int {
        pointsIntersection.count
    }

    var body: some View {
        ZStack {
            NavigationView { }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: backButton,
                trailing:
                    HStack {
                        undoButton
                        clearButton
                        Spacer()
                    })
            VStack {
                drawSection
                answersView
            }
            example
                .position(x: UIScreen.main.bounds.width / 2,
                          y: UIScreen.main.bounds.height / 7)
                .ignoresSafeArea()
        }
    }

    var answersView: some View {

        let width = UIScreen.main.bounds.width - 20
        let size = width * 0.8 / CGFloat(answers.count)
        let spacing = width * 0.2 / CGFloat(answers.count)

        let rows: [GridItem] = [GridItem(.fixed(size))]

        return  RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 8)
            .foregroundColor(.white)
            .overlay {
                LazyHGrid(rows: rows, alignment: .center, spacing: spacing) {
                    ForEach(0..<answers.count) { index in
                        answers[index]
                    }
                }
            }
    }

    var example: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height / 9)
            .foregroundColor(.white)
            .overlay {
                HStack {
                    SignView(digit: String(firstMultiplicationDigit), size: 60)
                        .padding(.trailing, -10)
                    SystemImageView(size: 30, systemName: "multiply")
                    SignView(digit: String(secondMultiplicationDigit), size: 60)
                        .padding(.leading, -10)
                    SystemImageView(size: 20, systemName: "equal")
                    SystemImageView(size: 40, systemName: "questionmark")
                }
            }
    }

    var drawSection: some View {
        ZStack {
            Rectangle() // replace it with what you need
                .foregroundColor(.white)
                .gesture(DragGesture().onChanged( { value in
                    self.addNewPoint(value)
                })
                            .onEnded( { value in
                    curves.append([])
                }))
            ForEach(curves.indices, id: \.self) { index in
                GeometryReader { proxy in
                    DrawShape(points: curves[index])
                        .stroke(lineWidth: 5) // here you put width of lines
                        .foregroundColor(.blue)
                }
            }

            ForEach(pointsIntersection.indices, id: \.self) { index in
                GeometryReader { proxy in

                    let point = pointsIntersection[index]
                    let numberOfPoint = arrayOfCountingOfPointsIntersections[point]

                    Circle()
                        .position(x: point.x,
                                  y: point.y)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                        .overlay {
                            if let number = numberOfPoint {
                                Text("\(number)")
                                    .position(x: point.x,
                                              y: point.y)
                            }
                        }
                }
                .onAppear {
                    refreshArrayOfCountingOfPointsIntersections()
                }
            }
        }
    }

    var undoButton: some View {
        Button {
            if curves.count > 1 {
                curves.remove(at: curves.endIndex - 2)
                arrayOfCountingOfPointsIntersections.removeAll()
                refreshArrayOfCountingOfPointsIntersections()
            }

            if curves.isEmpty {
                curves.append([])
            }
        } label: {
            Image(systemName: "arrow.uturn.backward.circle")
        }
    }

    var clearButton: some View {
        Button {
            curves = [[]]
            arrayOfCountingOfPointsIntersections.removeAll()
        } label: {
            Image(systemName: "trash")
        }
    }

    var backButton: some View {
        Button {
            showGame.toggle()
        } label: {
            Text("Back")
        }
    }

    private func addNewPoint(_ value: DragGesture.Value) {
        curves[curves.endIndex - 1].append(value.location)
    }

    private func refreshArrayOfCountingOfPointsIntersections () {
        pointsIntersection.forEach { point in
            if arrayOfCountingOfPointsIntersections[point] == nil {
                arrayOfCountingOfPointsIntersections[point] = arrayOfCountingOfPointsIntersections.count + 1
            }
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

