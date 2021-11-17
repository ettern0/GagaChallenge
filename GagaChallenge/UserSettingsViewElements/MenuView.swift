
import SwiftUI

struct MenuView: View {
    
    @ObservedObject var appModel: AppModel
    @State var showProfile: Bool
    @State var showGame: Bool
    @State var currentGameView: AnyView
    
    
    var name: String {
        appModel.user?.name ?? ""
    }
    
    var color: Color {
        if let _color = appModel.user?.color {
          return  getColor(data: _color)
        }
        
        return Color(.black)
    }
    
    var picture: String {
        appModel.user?.picture ?? ""

    }

    init(appModel: AppModel) {
        self.appModel = appModel
        self.currentGameView = AnyView(EmptyView())
        _showProfile = State (initialValue: (appModel.user == nil))
        _showGame = State(initialValue: false)
    
       
        
    }
    
    

    var body: some View {
        NavigationView {
        //+Show the game if we tapped on menu
        VStack {
            NavigationLink(
                destination: self.currentGameView,
                isActive: $showGame
            ) {
                EmptyView()
            }
            //-Show the game if we tapped on menu

                VStack {
                    ZStack {
                        Circle()
                            .foregroundColor(color)
                        Image(picture)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .onLongPressGesture {
                                self.showProfile.toggle()
                }
               
                    }
                    Text("Hi, \(name) !")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .onLongPressGesture {
                            self.showProfile.toggle()
                        }
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
                        Button(action: {
                            self.showGame = true
                            self.currentGameView = AnyView(MultiplicationGameView())
                        }) {
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
        }
        .sheet(isPresented: $showProfile) {
            ProfileView(appModel: appModel, showProfile: $showProfile)
        }
    }


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(appModel: AppModel.instance)
    }
}
}
