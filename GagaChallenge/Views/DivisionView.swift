import SwiftUI
import SpriteKit
import Foundation


struct DivisionView: View {

    let sizeOfTopAnButton = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.1)
    @State var answers: [Answer] = []
    @State var animateWrongAnswer: Bool = false
    @State var result = Int.random(in: 2...3)
    @State var secondDivisionDigit = Int.random(in: 1...3)

    var firstDivisionDigit: Int {
        result * secondDivisionDigit
    }

    var body: some View {

        let SKScene = DivisionScene(size: UIScreen.main.bounds.size,
                                    result: result,
                                    secondDivisionDigit: secondDivisionDigit)
        VStack {
            example
            SpriteView(scene: SKScene,
                       options: [.allowsTransparency])
            answersView
        }
    }

    var example: some View {

        Group {
            ZStack {
                HStack {
                    SignView(size: 50, value: firstDivisionDigit.stringValue)
                    SystemImageView(size: 30, systemName: "divide")
                    SignView(size: 50, value: secondDivisionDigit.stringValue)
                }
            }

        }
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
                                } else {
                                    animateWrongAnswer.toggle()
                                }
                            }, label: {
                                Text(answers[index].stringValue)
                            })
                                .modifier(ButtonTextViewModifier(sizeOfButton: sizeOfTopAnButton.height * 0.7, sizeOfText: 50, rectColor: answers[index].color))
                                .offset(x: animateWrongAnswer ? 0 : -5)
                                .animation(Animation.default.repeatCount(3).speed(3), value: animateWrongAnswer)

                        }
                    }
                }
            }
    }

    private func refreshAnswers() {
        if answers.isEmpty {
            let resultOfMultiply: Int = result
            var arrayOfColors: [Color]? = getArrayOfGeneralColors()
            arrayOfColors?.shuffle()

            answers.append(Answer(value: resultOfMultiply, rightAnswer: true, color: arrayOfColors?.first))
            arrayOfColors?.removeFirst()
            for _ in 0...2 {
                answers.append(Answer(value: Int.randomExept(of: resultOfMultiply, range: 0...25), color: arrayOfColors?.first))
                arrayOfColors?.removeFirst()
            }
            answers.shuffle()
        }
    }

    private func refreshGame() {
        result = Int.random(in: 1...3)
        secondDivisionDigit = Int.random(in: 1...3)
        clearGame()
    }

    private func clearGame() {
        answers.removeAll()
        refreshAnswers()
    }
}

enum CollisionType: UInt32 {
    case digit = 1
    case bin = 2
    case bottom = 3
    case leftBorder = 4
    case rightBorder = 5
}

class DivisionScene: SKScene, SKPhysicsContactDelegate {

    @State var result = Int.random(in: 1...3)
    @State var secondDivisionDigit = Int.random(in: 1...3)
    @State var animateWrongAnswer: Bool = false
    @State var answers: [Answer] = []
    @State var bins: [SKSpriteNode] = [SKSpriteNode(imageNamed: "bin")]
    var yBottomPosition: CGFloat = UIScreen.main.bounds.height
    var movableNode : SKNode?
    let widthOfScreen = UIScreen.main.bounds.width
    let heigtOfScreen = UIScreen.main.bounds.height
    var firstDivisionDigit: Int {
        result * secondDivisionDigit
    }

    init(size: CGSize, result: Int, secondDivisionDigit: Int) {
        self.result = result
        self.secondDivisionDigit = secondDivisionDigit
        super.init(size: size)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {

        view.showsPhysics = true

        self.backgroundColor = .white
        refreshBins()
        generateArrayOfFirstDivisionSprites()

        let bottom = SKShapeNode(rectOf: CGSize(width: widthOfScreen, height: 1))
        bottom.fillColor = .clear
        bottom.position.x = widthOfScreen/2
        bottom.position.y = yBottomPosition
        bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: widthOfScreen, height: 1))
        bottom.physicsBody?.categoryBitMask = CollisionType.bottom.rawValue
        bottom.physicsBody?.collisionBitMask = CollisionType.digit.rawValue
        bottom.physicsBody?.contactTestBitMask = CollisionType.digit.rawValue
        bottom.physicsBody?.isDynamic = false
        bottom.physicsBody?.allowsRotation = false
        bottom.physicsBody?.affectedByGravity = false
        self.addChild(bottom)

        let grass = SKSpriteNode(imageNamed: "grass")
        grass.position.x = widthOfScreen/2
        grass.position.y = yBottomPosition + 50
        grass.alpha = 0.5
        self.addChild(grass)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movableNode = nil
        let touch = touches.first

        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)

            if let node = nodesArray.first, nodesArray.first?.name == "digit" {
                movableNode = node
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, movableNode != nil {

            let location = touch.location(in: self)
            if location.x >= self.frame.minX,
               location.x <= self.frame.maxX,
               location.y >= self.frame.minY,
               location.y <= self.frame.maxY {
                if let node = movableNode {
                    node.position = location
                    node.physicsBody?.isDynamic = true
                    node.physicsBody?.allowsRotation = true
                }
            }
        }

    }

    func generateArrayOfFirstDivisionSprites() {

        // max 5 in a raw
        let _columsCountDouble = Double(Double(firstDivisionDigit) / Double(5)).rounded(.awayFromZero)
        let _columsCount = Int(_columsCountDouble)
        let space = Int(widthOfScreen/5)
        var spriteRemains = firstDivisionDigit

        for i in 0..<_columsCount {
            for x in 0..<5 {
                if spriteRemains > 0 {
                    let node = SKSpriteNode(imageNamed: "strawberry")

                    node.name = "digit"
                    node.size = CGSize(width: 80, height: 90)
                    node.position = CGPoint(x: 40 + x * space, y: Int(heigtOfScreen - 50) - (i * space))
                    node.physicsBody = SKPhysicsBody(texture: node.texture!,
                                                     size: CGSize(width: 60, height: 70))
                    node.physicsBody?.categoryBitMask = CollisionType.digit.rawValue
                    node.physicsBody?.collisionBitMask =
                        CollisionType.bin.rawValue |
                        CollisionType.digit.rawValue |
                        CollisionType.bottom.rawValue |
                        CollisionType.leftBorder.rawValue |
                        CollisionType.rightBorder.rawValue

                    node.physicsBody?.contactTestBitMask = CollisionType.bin.rawValue | CollisionType.digit.rawValue
                    node.physicsBody?.isDynamic = false
                    node.physicsBody?.allowsRotation = false
                    self.addChild(node)
                    spriteRemains -= 1
                }
            }
        }
    }

    func refreshBins() {

        let sizeOfBin = SKSpriteNode(imageNamed: "bin").size
        let posiibleCountOfBinsOnScreen = Double(widthOfScreen) / Double(sizeOfBin.width)

        let p = Double(posiibleCountOfBinsOnScreen) / Double(secondDivisionDigit)
        let binWidth = sizeOfBin.width * CGFloat(p)
        let binHeight = sizeOfBin.height * CGFloat(p)
        for x in 0..<secondDivisionDigit {
            let xPosition = CGFloat(x) * binWidth + binWidth/2
            let bin = SKSpriteNode(imageNamed: "bin")
            bin.size.width = binWidth
            bin.size.height = binHeight
            bin.position.x = CGFloat(xPosition)
            bin.position.y = UIScreen.main.bounds.height/2
            bin.physicsBody = SKPhysicsBody(texture: bin.texture!, alphaThreshold: 0, size: bin.size)
            bin.physicsBody?.categoryBitMask = CollisionType.bin.rawValue
            bin.physicsBody?.collisionBitMask = CollisionType.digit.rawValue
            bin.physicsBody?.contactTestBitMask = CollisionType.digit.rawValue
            bin.physicsBody?.isDynamic = false
            bin.physicsBody?.allowsRotation = false
            self.addChild(bin)
            bins.append(bin)

            if yBottomPosition > (bin.position.y) - bin.size.height/2 {
                self.yBottomPosition = (bin.position.y) - bin.size.height/2 - 10
            }

        }
    }

}
