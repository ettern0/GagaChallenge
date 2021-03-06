//
//  SubtractionView.swift
//  GagaChallenge
//
//  Created by Elio Fortunato on 21/11/21.
//

import SwiftUI

    


struct SubtractionGameView: View {
    
    @ObservedObject var appModel: AppModel
    @State var countleft: Int = 0
    @State var countright: Int = 0
    @State var counttotal: Int = 0
    @Binding var showGame: Bool
    @State var stackOfOperation: [String] = []
    @State var animateWrongAnswer: Bool = false
    @State var answers: [Answer] = []
    let sizeOfTopAnButton = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.1)
    @State var showHelp: Bool = false
    
    var body: some View {
        
        NavigationView {
            ZStack{
                NavigationLink(
                    "",
                    destination: HelpView(helpVideo: .substractionHelp),
                    isActive: $showHelp)
                VStack {
                Spacer(minLength: 100)
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 6.0, height: 150.0)
                    .padding(.top,-200)
                    Image(systemName:"minus")
                    .resizable()
                    .frame(width: 50.0, height: 10.0)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                    .frame(width: 150.0, height: 150.0)
                    .padding(.horizontal)
                    .padding(.top, -50)
                    Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 6.0, height: 150.0)
//                    .padding(.top, -200)
                    Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 360.0, height: 6.0)
//                    .padding(.top, -200)
                Spacer(minLength: 50)
                Image(systemName:"equal")
                    .resizable()
                    .frame(width: 60, height: 40)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                    .onTapGesture {
                        refreshAnswers()
                        print(" \(counttotal) ")
                        answersView
                    }
                    
                    Spacer(minLength: 200)
                    
                   answersView
                        .position(x: 215, y: -100)
                    
            }

                HStack {
                    
                    
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 0.01)))
                        .frame(width: 207, height: 500)
                        .onTapGesture {
                            self.countleft += 1
                            self.counttotal += 1
                            answers.removeAll()
                            stackOfOperation.append("left")
                     }
                    
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 0.01)))
                        .frame(width: 207, height: 500)
                        .onTapGesture {
                            if countleft > countright {
                                self.countright += 1
                                self.counttotal -= 1
                                answers.removeAll()
                                stackOfOperation.append("right")
                            } else {
                                self.countright += 0
                                self.counttotal += 0
                            }
                            
                        }

                }
                    .padding(.top, -500)
                    .padding(.leading, 0)
               
                GeometryReader { proxy in
                    
                    ForEach(0...counttotal, id:\.self) { index in
                        if index > 0 {
                            Circles2View(appModel: appModel, index: index, offset: logicalFunction(size: proxy.size))
//                            .blur(radius: 1)
                            .animation(.easeIn(duration: 0.5))
                        }
                            
                    }
       
                    
                }
                .background(Color.clear)
                .ignoresSafeArea()
                .frame(width: 170, height: 400)

                Text(" \(countleft) ")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.leading, -180)
                    .padding(.top, -270)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                
                
                
                Text(" \(countright) ")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.leading, 230)
                    .padding(.top, -270)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                
            
            }
            
//            .padding(.all)
            }
        .navigationBarItems(
            trailing:
                HStack {
                    undoButton
                    clearButton
                    helpButton
                    Spacer()
                })

    }
    
    var undoButton: some View{
        Button {
            if let operation = stackOfOperation.last {
                answers.removeAll()
                if operation == "left" {
                    countleft -= 1
                } else {
                    countright -= 1
                }
                
                counttotal += 1
                stackOfOperation.removeLast()
            }
            
        }
    label:{
        Image(systemName: "arrow.uturn.backward.circle")
    }
}
    
    var backButton: some View {
        Button {
            showGame.toggle()
        } label: {
            Text("Back")
        }
    }
        var clearButton: some View {
            Button {
                answers.removeAll()
                counttotal = 0
                countleft = 0
                countright = 0
                stackOfOperation.removeAll()
            } label: {
                Image(systemName: "trash")
            }

        }

    var helpButton: some View {
        Button {
            showHelp = true
        } label: {
            Image(systemName: "questionmark.circle")
        }
    }

    func logicalFunction(size: CGSize) -> CGSize {
        
        // Do your works here!
        
        let width: CGFloat = CGFloat.random(in: 0.0...size.width)
        let height: CGFloat = CGFloat.random(in: 0.0...size.height)
        
        return CGSize(width: width, height: height)
        
    }
    var answersView: some View {

        let spacing = sizeOfTopAnButton.width * 0.2 / CGFloat(4)
        let rows: [GridItem] = [GridItem()]

        return  RoundedRectangle(cornerRadius: 10)
            .frame(width: sizeOfTopAnButton.width, height: sizeOfTopAnButton.height * 0.8)
            .foregroundColor(.white)
//            .onAppear {
//                refreshAnswers()
                
//            }
            .overlay {
                if !answers.isEmpty {
                    LazyHGrid(rows: rows, alignment: .center, spacing: spacing) {
                        ForEach(0..<answers.count) { index in
                            Button(action: {
                                if answers[index].rightAnswer {
                                    stackOfOperation.removeAll()
                                    counttotal = 0
                                    countleft = 0
                                    countright = 0
                                    answers.removeAll()
                                    AdditionalSoundsEffect.instance.playSound(sound: .rightAnswer)
                                } else {
                                    animateWrongAnswer.toggle()
                                    AdditionalSoundsEffect.instance.playSound(sound: .wrongAnswer)
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
    //        if answers.isEmpty {
        answers.removeAll()
            let resultOfMultiply: Int = counttotal
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

//        }
}

struct Circles2View: View {
    
    var appModel: AppModel
    let index: Int
    let offset: CGSize
    var color: Color {
        if let _color = appModel.user?.color {
            return  getColor(data: _color)
        }
        
        return Color(.black)
    }
    var picture: String {
        appModel.user?.picture ?? ""
    }
        var body: some View {

            Circle()

                .frame(width: 30, height: 30, alignment: .topTrailing)
                .foregroundColor((color))
                .overlay {
                    
                        Image(picture)
                        .resizable()
                        .scaledToFit()
                          
                }
                .offset(offset)
                .position(x: -105, y: -250)

                                   
    }


}
struct Answer2 {
    var value: Int
    var rightAnswer: Bool = false
    var color: Color?
    var stringValue: String {
        value.stringValue
    }
}



