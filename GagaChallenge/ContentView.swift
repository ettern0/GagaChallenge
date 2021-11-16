//
//  ContentView.swift
//  GagaChallenge
//
//  Created by Евгений Сердюков on 08.11.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @ObservedObject var appModel = AppModel.instance

    var body: some View {
        switch appModel.state {
        case .download:
            DownloadView(appModel: appModel)
        case .menu:
            MenuView(appModel: appModel)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
