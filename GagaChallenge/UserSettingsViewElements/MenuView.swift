
import SwiftUI

struct MenuView: View {

    @ObservedObject var appModel: AppModel
    @State var showProfile = false

    var body: some View {
        NavigationView {
            Button {
                self.showProfile.toggle()
            } label: {
                Text("Profile")
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
