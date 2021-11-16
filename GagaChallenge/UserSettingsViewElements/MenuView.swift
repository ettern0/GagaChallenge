
import SwiftUI

struct MenuView: View {
    
    @ObservedObject var appModel: AppModel
    
    @State var user: Users?
//    @State var name: String
    @State var showProfile = true
//    @State var picture: String
//    @State var color: Color
    
    var name: String {
        appModel.user?.name ?? ""
    }
    
    init(appModel: AppModel) {
       
//        self.user = appModel.user
        self.appModel = appModel
        self.user = appModel.user

//        if let name = user?.name {
//            self.name = name
//        } else {
//            self.name = ""
//        }
        
        if appModel.user == nil {
            self.showProfile = true
        }
        
//        if let picture = user?.picture {
//            self.picture = picture
//        } else {
//            self.picture = "defaulAvatar"
//
//    }
//        if let color = user?.color {
//            self.color = getColor(data: color)
//        } else {
//            self.color = Color.random
//        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
//                ZStack {
//                    Circle()
//                        .foregroundColor(color)
//                        .frame(width: sizeOfPictureDescription.width * 1.2, height: sizeOfPictureDescription.height * 1.3)
//                        .shadow(radius: 5)
//                        Image(picture)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: sizeOfPictureDescription.width, height: sizeOfPictureDescription.height)
//                            .foregroundColor(.white)
//                }
//                .padding(.bottom)
//            }
                
                
                Text("Hi, \(name) !")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer(minLength: 40)
                
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        
                        Image(systemName:"plus")
                        
                            .resizable()
                            .frame(width: 80.0, height: 80.0)
                            .foregroundColor(Color.white)
                            .frame(width: 150.0, height: 150.0)
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.red))
                            .shadow(radius: 25)
                            .padding(.horizontal)
                        
                    }
                    Button(action:/*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName:"minus")
                            .resizable()
                            .frame(width: 80.0, height: 10.0)
                            .foregroundColor(Color.white)
                            .frame(width: 150.0, height: 150.0)
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.blue))
                            .padding(.horizontal)
                            .shadow(radius: 25)
                        
                    }
                    
                }
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName:"multiply")
                            .resizable()
                            .frame(width: 70.0, height: 70.0)
                            .foregroundColor(Color.white)
                            .frame(width: 150.0, height: 150.0)
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.green))
                            .padding(.horizontal)
                            .shadow(radius: 25)
                    }
                    Button(action:/*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text(":")
                        Image(systemName:"divide")
                            .resizable()
                            .frame(width: 70.0, height: 70.0)
                            .foregroundColor(Color.white)
                            .frame(width: 150.0, height: 150.0)
                            .background(RoundedRectangle(cornerRadius: 15).foregroundColor(.yellow))
                            .padding(.horizontal)
                            .shadow(radius: 25)
                        
                    }
                    
                    .padding(.vertical)
                }
                .padding([.horizontal])
                .padding(.top, 20.0)
                .padding(.bottom, 120)
            }
            
            
        }
        .sheet(isPresented: $showProfile) {
            ProfileView(appModel: appModel, showProfile: $showProfile)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(appModel: AppModel.instance)
    }
}
