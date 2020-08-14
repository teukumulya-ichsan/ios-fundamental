import UIKit
import AVFoundation
 
 
class ViewController: UIViewController {
    private var _player: AVAudioPlayer?
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        stopButton.disable()
        
        guard let url = Bundle.main.url(forResource: "guitar_background", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            _player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             _player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func playMusic(_ sender: UIButton) {
        guard let player = _player else { return }
        player.play()
//        stopButton.enable()
//        playButton.disable()
    }
    
    @IBAction func stopMusic(_ sender: UIButton) {
        guard let player = _player else { return }
        player.stop()
//        playButton.enable()
//        stopButton.disable()
    }
}
 
 
extension UIButton {
    func enable() {
        self.isEnabled = true
    }
    
    func disable() {
        self.isEnabled = false
    }
}
