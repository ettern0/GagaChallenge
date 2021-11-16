
import SwiftUI

struct MainMenuView: View {

    @ObservedObject var appModel: AppModel

    var body: some View {
        Text("sdf")
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(appModel: AppModel.instance)
    }
}
