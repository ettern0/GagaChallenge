//
//  AdditionView.swift
//  GagaChallenge
//
//  Created by Elio Fortunato on 17/11/21.
//


import SwiftUI

    


struct AdditionGameView: View {
    @ObservedObject var appModel: AppModel
    @State var countleft: Int = 0
    @State var countright: Int = 0
    @State var counttotal: Int = 0
    @Binding var showGame: Bool
    @State var animateWrongAnswer: Bool = false
    @State var answers: [Answer] = []
    @State var stackOfOperation: [String] = []
    let sizeOfTopAnButton = CGSize(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.height * 0.1)
            
    var body: some View {
        
        NavigationView {
 

                      
            
            ZStack{
                
                
            
                VStack {
                    
                Spacer(minLength: 100)
                    
                    
                Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 6.0, height: 150.0)
                    .padding(.top,-200)
                    
                    
                
                    Image(systemName:"plus")
                    .resizable()
                    .frame(width: 80.0, height: 80.0)
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
                        
                    }
                    
                    Spacer(minLength: 200)
                    
                    answersView
                        .position(x: 215, y: -70)
                    
                    
            }
                    
                    
                
            
            
                
                HStack {
                    
                    
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 0.01)))
                        .frame(width: 207, height: 500)
                        .onTapGesture {
                            
                            self.countleft += 1
                            self.counttotal += 1
                            stackOfOperation.append("left")
                            
                            
                        }
                    
                    Rectangle()
                        .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 0.01)))
                        .frame(width: 207, height: 500)
                        .onTapGesture {
                            self.countright += 1
                            self.counttotal += 1
                            stackOfOperation.append("right")
                        
                }
               
                
            
            }
                    .padding(.top, -500)
                    .padding(.leading, 0)
               
                GeometryReader { proxy in
                    
                   
                    ForEach(0...countleft, id:\.self) { index in
                        if index > 0 {
                        
                        CirclesView(appModel: appModel,index: index, offset: logicalFunction(size: proxy.size))
//                            .blur(radius: 1)
                            .animation(.easeIn(duration: 1))
                    }
                            
                    }
                    ForEach(0...countright, id:\.self) { index in
                        if index > 0 {
                            
                            CirclesrView(appModel: appModel, index: index, offset: logicalFunction(size: proxy.size))
//                            .blur(radius: 1)
                            .animation(.easeIn(duration: 1))
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
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: backButton,
            trailing:
                HStack {

                    undoButton
                    clearButton

                    Spacer()
                })

    }
    
    var undoButton: some View{
        Button {
            if let operation = stackOfOperation.last {
              
                if operation == "left" {
                    countleft -= 1
                } else {
                    countright -= 1
                }
                
                counttotal -= 1
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
                counttotal = 0
                countleft = 0
                countright = 0
                stackOfOperation.removeAll()
            } label: {
                Image(systemName: "trash")
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
//        }
    }
}

struct CirclesView: View {
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
struct CirclesrView: View {
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
                .position(x: 105, y: -250)
    
    }
        

}
struct Answer {
    var value: Int
    var rightAnswer: Bool = false
    var color: Color?
    var stringValue: String {
        value.stringValue
    }
}


