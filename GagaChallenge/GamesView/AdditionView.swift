//
//  AdditionView.swift
//  GagaChallenge
//
//  Created by Elio Fortunato on 17/11/21.
//


import SwiftUI


struct AdditionGameView: View {
  
    
    var body: some View {
        
        NavigationView {
            
            ZStack{
                
                
            
            HStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 207, height: 500)
                    .onTapGesture {
                        print("left side tapped")
                        
                    }
                
                Rectangle()
                    .fill(.white)
                    .frame(width: 207, height: 500)
                    .onTapGesture {
                    print("right side tapped")
                }
                
            
            }
                    .padding(.top, -200)
                    .padding(.leading, 0)
            VStack {
                    
                
                    Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 6.0, height: 150.0)
                
                    
                
                Image(systemName:"plus")
                    
                    .resizable()
                    .frame(width: 80.0, height: 80.0)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                    .frame(width: 150.0, height: 150.0)
                    .padding(.horizontal)
                
                
                    Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .frame(width: 6.0, height: 150.0)
                    
                
                
                    Capsule()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)), Color(#colorLiteral(red: 0.6745098039, green: 0.9843137255, blue: 0.5568627451, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: 360.0, height: 6.0)
                    
                                
                

                Image(systemName:"equal")
                    .resizable()
                    .frame(width: 60, height: 40)
                    .foregroundColor(Color(#colorLiteral(red: 0.2352941176, green: 0.7725490196, blue: 0.6117647059, alpha: 1)))
                    .onTapGesture {
                                print("equal")
                            
                    }
                
                                    
            }
            .padding(/*@START_MENU_TOKEN@*/.top, -100.0/*@END_MENU_TOKEN@*/)
            }

        }
    }
}
   

