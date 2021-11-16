
import AVKit
import SwiftUI

struct DownloadView: View {
    private let videoPlayer = AVPlayer(url: Bundle.main.url(forResource: "download", withExtension: "mp4")!)

    var body: some View {
        VStack {
            GagaPlayer(player: videoPlayer)
                .onAppear {
                    videoPlayer.play()
                }
                .onDisappear(perform: {
                    videoPlayer.pause()
                })
                .edgesIgnoringSafeArea(.all)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}


struct GagaPlayer: UIViewControllerRepresentable {
    var player: AVPlayer

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.showsPlaybackControls = false
        controller.modalPresentationStyle = .fullScreen
        controller.player = player
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
    }
}
