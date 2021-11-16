import SwiftUI
import CoreData

public struct Model {

    private let viewContext: NSManagedObjectContext
    private (set) var state: States = .menu
    private (set) var user: Users? = nil

    init () {
        viewContext = PersistenceController.shared.container.viewContext
        self.state = .download
        self.user = getUserFromData()
    }

    enum States {
        case download, menu
    }

    mutating func toogleTheState(to state:States) -> Void {
        self.state = state
    }

    func getUserFromData() -> Users? {

        let usersRequest = Users.fetchRequest()
        usersRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \Users.name, ascending: true)
        ]
        usersRequest.fetchLimit = 1

        let result = try? viewContext.fetch(usersRequest)
        return result?.first
    }

    mutating func saveUser(name: String, age: Int16, picture: String, color: Color) {
        let item = user ?? Users(context: viewContext)
        item.timestamp = Date()
        item.name = name
        item.age = age
        item.picture = picture
        item.color = getUIDataFromColor(color: color)
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }

        self.user = getUserFromData()

    }
}
