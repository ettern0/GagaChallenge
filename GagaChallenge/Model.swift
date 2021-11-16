import SwiftUI
import CoreData

public struct Model {
    private let viewContext: NSManagedObjectContext
    private let usersRequest: NSFetchRequest<Users>
    private (set) var state: States = .menu

    var user: Users? {
        let result = try? viewContext.fetch(usersRequest)
        return result?.first
    }

    init () {
        viewContext = PersistenceController.shared.container.viewContext

        usersRequest = Users.fetchRequest()
        usersRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \Users.name, ascending: true)
        ]
        usersRequest.fetchLimit = 1
        self.state = .download
    }

    enum States {
        case download, menu
    }

    mutating func toogleTheState(to state:States) -> Void {
        self.state = state
    }

    func saveUser(name: String, age: Int16, picture: String, color: Color) {
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
    }
}
