import SwiftUI
import CoreData

struct ProfileView: View {

    @ObservedObject var appModel: AppModel
    @Binding var showProfile: Bool
    let sizeOfRROfDescription = CGSize(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.3)
    var sizeOfPictureDescription: CGSize { CGSize(width: sizeOfRROfDescription.width*0.5, height: sizeOfRROfDescription.height*0.5) }
    let colorsArray: Array<Color> = [.red, .orange, .yellow, .green, .blue, .brown, .purple, .mint, .pink, .gray, .teal]
    let signArray: Array<String> = ["cowboy", "knight", "angel",
                                    "clown" ,"doctor", "pirate",
                                    "viking", "wizard", "woman"]

    var user: Users?
    @State var name: String
    @State var age: Int16
    @State var picture: String
    @State var color: Color
    @State var nameIsEditing: Bool = false
    @State var ageIsEditing: Bool = false
    @FocusState private var emojiIsFocused: Bool

    init(appModel: AppModel, showProfile: Binding<Bool>) {

        self.user = appModel.user
        self.appModel = appModel

        if let name = user?.name {
            self.name = name
        } else {
            self.name = ""
        }

        if let age = user?.age {
            self.age = age
        } else {
            self.age = 0
        }

        if let picture = user?.picture {
            self.picture = picture
        } else {
            self.picture = "defaulAvatar"
        }

        if let color = user?.color {
            self.color = getColor(data: color)
        } else {
            self.color = Color.random
        }

        self._showProfile = showProfile
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                VStack {
                    descriptionView.padding(.bottom, -20)
                    colorChoiseView.padding(.bottom, -20)
                    signChoiseView
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: backButton, trailing: doneButton)
            }
        }
    }

    var descriptionView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: sizeOfRROfDescription.width, height: sizeOfRROfDescription.height)
                .foregroundColor(.white)
                .padding(.all)
                .overlay {
                    VStack{
                        colorAndSignOfListView
                        textDescriptionView
                    }
                }
        }
    }

    var colorAndSignOfListView: some View {
        ZStack {
            Circle()
                .foregroundColor(color)
                .frame(width: sizeOfPictureDescription.width * 1.2, height: sizeOfPictureDescription.height * 1.3)
                .shadow(radius: 5)
                Image(picture)
                    .resizable()
                    .scaledToFit()
                    .frame(width: sizeOfPictureDescription.width, height: sizeOfPictureDescription.height)
                    .foregroundColor(.white)
        }
        .padding(.bottom)
    }

    var textDescriptionView: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: sizeOfRROfDescription.width*0.9, height: sizeOfRROfDescription.height/6)
            .foregroundColor(Color(.systemGroupedBackground))
            .overlay(alignment: .center) {
                HStack {
                    TextField("Name", text: $name) { isEditing in
                            self.nameIsEditing = isEditing
                    }
                    .lineLimit(nil)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .foregroundColor(color)
                    Spacer()
                    if self.nameIsEditing && self.name != "" {
                        Button {
                            self.name = ""
                        } label: {
                        Image(systemName: "xmark.circle.fill")
                            .padding(.trailing)
                            .foregroundColor(Color(.init(gray: 0, alpha: 0.2)))
                        }
                    }
                }
            }
    }

    var colorChoiseView: some View {

         let columns = [
            GridItem(.adaptive(minimum: 40))
         ]

        return RoundedRectangle(cornerRadius: 10)
            .frame(width: sizeOfRROfDescription.width, height: sizeOfRROfDescription.height*0.5)
            .foregroundColor(.white)
            .padding(.all)
            .overlay {
                LazyVGrid(columns: columns, spacing: 15) {
                    ForEach(colorsArray, id: \.self) { item in
                        Circle()
                            .foregroundColor(item)
                            .frame(width: 30, height: 30)
                            .onTapGesture {
                                self.color = item
                            }
                    }
                }
                .frame(width: sizeOfRROfDescription.width*0.9, height: sizeOfRROfDescription.height*0.6)
            }
    }

    var signChoiseView: some View {

        let columns: [GridItem] =
                Array(repeating: .init(.flexible()), count: 3)

        return RoundedRectangle(cornerRadius: 10)
        .frame(height: UIScreen.main.bounds.height/3)
            .foregroundColor(.white)
            .padding(.all)
            .overlay {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(signArray, id: \.self) { _sign in
                            Circle()
                                .foregroundColor(Color(.systemGroupedBackground))
                                .frame(width: 60, height: 60)
                                .overlay {
                                    Image(_sign)
                                        .resizable()
                                }
                                .onTapGesture {
                                    self.picture = _sign
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal, 5)
                .frame(maxHeight: UIScreen.main.bounds.height/3 * 0.9)
            }
    }

    var backButton: some View {
        Button {
            showProfile.toggle()
        } label: {
            Text("Cancel")
        }
    }

    var doneButton: some View {
        Button {
            appModel.saveUser(name: name,
                              age: age,
                              picture: picture,
                              color: color)
            showProfile.toggle()
        } label: {
            Text("Done")
        }
    }

    var titleView: some View {
        Text("Welcome")
            .font(.system(size: 50, weight: .heavy, design: .default))
            .padding(.top, 30)
            .padding(.bottom, 30)
    }
}
