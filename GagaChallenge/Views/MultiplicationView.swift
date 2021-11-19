
import SwiftUI

struct MultiplicationGameView: View {

    @State var curves: [[CGPoint]] = [[]]
    @State var arrayOfCountingOfPointsIntersections: [CGPoint: Int] = [:]
    @Binding var showGame: Bool
    @State var firstMultiplicationDigit = Int.random(in: 1...5)
    @State var secondMultiplicationDigit = Int.random(in: 1...5)
    @State var answers: [Answer] = []
    let sizeOfTopAnButton = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.1)
    var pointsIntersection: [CGPoint] {
        getIntersectionsOfPoints(points: curves)
    }

    var body: some View {
        VStack(spacing: 0) {
            example
            Spacer()
            drawSection
            Spacer()
            answersView
        }
        .padding(.top, -50)
        .navigationBarItems(
            trailing:
                HStack {
                    undoButton
                    clearButton
                    Spacer()
                })
    }

    var answersView: some View {

        let spacing = sizeOfTopAnButton.width * 0.2 / CGFloat(4)
        let rows: [GridItem] = [GridItem()]

        return  RoundedRectangle(cornerRadius: 10)
            .frame(width: sizeOfTopAnButton.width, height: sizeOfTopAnButton.height * 0.8)
            .foregroundColor(.white)
            .onAppear {
                refreshAnswers()}
            .overlay {
                if !answers.isEmpty {
                    LazyHGrid(rows: rows, alignment: .center, spacing: spacing) {
                        ForEach(0..<answers.count) { index in
                            Button(action: {
                                if answers[index].rightAnswer {
                                    refreshGame()
                                }
                            }, label: {
                                Text(answers[index].stringValue)
                            }).modifier(ButtonTextViewModifier(sizeOfButton: sizeOfTopAnButton.height * 0.7, sizeOfText: 50))

                        }
                    }
                }
            }
    }

    var example: some View {

        let spacing = sizeOfTopAnButton.width * 0.2 / CGFloat(4)
        let rows: [GridItem] = [GridItem()]
        let views: [AnyView] = [AnyView(SignView(size: 50, value: firstMultiplicationDigit.stringValue)),
                                AnyView(SystemImageView(size: 30, systemName: "multiply")),
                                AnyView(SignView(size: 50, value: secondMultiplicationDigit.stringValue)),
                                AnyView(SystemImageView(size: 20, systemName: "equal")),
                                AnyView(SystemImageView(size: 40, systemName: "questionmark"))]

        return  RoundedRectangle(cornerRadius: 10)
            .frame(width: sizeOfTopAnButton.width,
                   height: sizeOfTopAnButton.height*0.8)
            .foregroundColor(.white)
            .overlay {
                LazyHGrid(rows: rows, alignment: .center, spacing: spacing) {
                    ForEach(0..<views.count) { index in
                        views[index]
                    }
                }
            }
    }

    var drawSection: some View {

        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height - (sizeOfTopAnButton.height * 3)

       return ZStack {
           Rectangle()
               .foregroundColor(.white)
               .border(getGeneralColor(), width: 1)

               .gesture(DragGesture().onChanged( { value in
                   self.addNewPoint(value, borderX: width, borderY: height)
               }).onEnded( { value in
                   curves.append([])
               }))
            ForEach(curves.indices, id: \.self) { index in
                    DrawShape(points: curves[index])
                        .stroke(lineWidth: 5) // here you put width of lines
                        .foregroundColor(.blue)
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
                        .blur(radius: 1)
                        .animation(.default)
                }
                .onAppear {
                    refreshArrayOfCountingOfPointsIntersections()
                }
            }
        }
        .frame(width: width, height: height)
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
            clearGame()
        } label: {
            Image(systemName: "trash")
        }
    }

//    init(showGame:Binding<Bool>) {
//
//        self._showGame = showGame
//        //+init array of answers
//
//        self.answers = []
//        let resultOfMultiply: Int = firstMultiplicationDigit * secondMultiplicationDigit
//        self.answers.append(Answer(value: resultOfMultiply, rightAnswer: true))
//        for _ in 0...2 {
//            self.answers.append(Answer(value: Int.randomExept(of: resultOfMultiply, range: 0...25)))
//        }
//        self.answers.shuffle()
//        //-init array of answers
//    }
//
    struct Answer {
        var value: Int
        var rightAnswer: Bool = false
        var stringValue: String {
            value.stringValue
        }
    }

    private func addNewPoint(_ value: DragGesture.Value, borderX: CGFloat, borderY: CGFloat) {
        if value.location.y >= -0, value.location.y <= 630 {
            curves[curves.endIndex - 1].append(value.location)
        }
    }

    private func refreshArrayOfCountingOfPointsIntersections () {
        pointsIntersection.forEach { point in
            if arrayOfCountingOfPointsIntersections[point] == nil {
                arrayOfCountingOfPointsIntersections[point] = arrayOfCountingOfPointsIntersections.count + 1
            }
        }
    }

    private func refreshAnswers() {
        if answers.isEmpty {
            let resultOfMultiply: Int = firstMultiplicationDigit * secondMultiplicationDigit
            answers.append(Answer(value: resultOfMultiply, rightAnswer: true))
            for _ in 0...2 {
                answers.append(Answer(value: Int.randomExept(of: resultOfMultiply, range: 0...25)))
            }
            answers.shuffle()
        }
    }

    private func refreshGame() {
        firstMultiplicationDigit = Int.random(in: 1...5)
        secondMultiplicationDigit = Int.random(in: 1...5)
        clearGame()
        refreshAnswers()
    }

    private func clearGame() {
        curves = [[]]
        arrayOfCountingOfPointsIntersections.removeAll()
        answers.removeAll()
    }
}



