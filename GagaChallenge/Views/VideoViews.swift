
import AVKit
import SwiftUI

struct DownloadView: View {

    @ObservedObject var appModel: AppModel
    private let videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "download", withExtension: "mp4")!)

    var body: some View {
        VStack {
            GagaPlayer(player: videoPlayer)
                .onAppear {
                    videoPlayer.play()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {  /// Anything over 0.5 seems to work
                        appModel.switchState(to: .menu)
                    }
                }
                .onDisappear(perform: {
                    videoPlayer.pause()
                })
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct HelpView: View {

    enum Video: String {
        case download, multiplyHelp, divisionHelp, additionHelp, substractionHelp
    }

    var helpVideo: Video

    var body: some View {
        let videoPlayer = AVPlayer(url: Bundle.main.url(forResource: helpVideo.rawValue, withExtension: "mp4")!)
        return VStack {
            GagaPlayer(player: videoPlayer)
                .onAppear {
                    videoPlayer.play()
                }
                .onDisappear(perform: {
                    videoPlayer.pause()
                })
                .edgesIgnoringSafeArea(.all)
        }

    }
}


