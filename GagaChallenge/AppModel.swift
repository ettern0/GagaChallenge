import SwiftUI
import CoreData

public class AppModel: ObservableObject {

    static public let instance = AppModel()
    @Published private(set) var model: Model = Model()

    var state: Model.States {
        model.state
    }

    var user: Users? {
        model.user
    }

    func switchState(to state: Model.States) {
        model.toogleTheState(to: state)
    }

    func saveUser(name: String, age: Int16, picture: String, color: Color) {
        model.saveUser(name: name, age: age, picture: picture, color: color)
    }
}
