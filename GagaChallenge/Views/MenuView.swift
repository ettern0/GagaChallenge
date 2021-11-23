
import SwiftUI
import AVKit

struct MenuView: View {
    
    @ObservedObject var appModel: AppModel
    @State var showProfile: Bool
    @State var showGame: Bool
    @State var currentGameView: AnyView
    let sizeOfRROfDescription = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
    var sizeOfPictureDescription: CGSize { CGSize(width: sizeOfRROfDescription.width*0.5, height: sizeOfRROfDescription.height*0.5) }
    
//    var soundManager: SoundManager
    
    
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
//    init(soundmanager:SoundManager){
//    self.soundManager.playSound(sound: SoundOption)
//    }

    var body: some View {
        NavigationView {
            //Show the game if we tapped on menu
            VStack {
                NavigationLink(
                    "",
                    destination: currentGameView,
                    isActive: $showGame)
                    profileInfo
                    Spacer(minLength: 40)
                    buttonsView
                }
        }
    }

    var profileInfo: some View {
        return Group {
            
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(color)
                        .frame(width: sizeOfPictureDescription.width * 1.3, height: sizeOfPictureDescription.height * 1.3)
                    Image(picture)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: sizeOfPictureDescription.width, height: sizeOfPictureDescription.height)
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
            }
        }
        .sheet(isPresented: $showProfile) {
            ProfileView(appModel: appModel, showProfile: $showProfile)
        }
    }

    var buttonsView: some View {
        return Group {
            HStack {
                Button(action: {
                    self.showGame = true
                    self.currentGameView = AnyView(AdditionGameView(appModel: appModel, showGame: $showGame))
                }) {
                    Image("plus")
                        .MenuModifeier(rectColor: .red, signWidth: 80, signHeight: 80)
                }
                Button(action: {
                    self.showGame = true
                    self.currentGameView = AnyView(SubtractionGameView(appModel: appModel, showGame: $showGame))
                }) {
                    Image("minus")
                        .MenuModifeier(rectColor: .blue, signWidth: 80, signHeight: 15)
                }
            }
            HStack {
                Button(action: {
                    self.showGame = true
                    self.currentGameView = AnyView(MultiplicationGameView(showGame: $showGame))
                }) {
                    Image("multiply")
                        .MenuModifeier(rectColor: .green, signWidth: 60, signHeight: 60)
                }
                Button(action:/*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Image("divide")
                        .MenuModifeier(rectColor: .yellow, signWidth: 80, signHeight: 70)
                }
            }
            .padding([.horizontal])
            .padding(.top, 20.0)
            .padding(.bottom, 120)
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(appModel: AppModel.instance)
    }
}
