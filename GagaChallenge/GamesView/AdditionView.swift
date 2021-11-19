//
//  AdditionView.swift
//  GagaChallenge
//
//  Created by Elio Fortunato on 17/11/21.
//


import SwiftUI



struct AdditionGameView: View {
    @State var countleft: Int = 0
    @State var countright: Int = 0
    @State var counttotal: Int = 0
    @Binding var showGame: Bool
    @State var stackOfOperation: [String] = []
   
            
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
                                print(" \(counttotal) ")
                    }
                    
                    Spacer(minLength: 200)
                    
                    Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 360.0, height: 6.0)
            }
                    
               
                
            
            
                Text(" \(countleft) ")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.leading, -180)
                    .padding(.top, -300)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                
                
                
                Text(" \(countright) ")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.leading, 230)
                    .padding(.top, -300)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                
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
}

