//
//  ViewController.swift
//  audio record
//
//  Created by Amanpreet Kaur on 2020-01-23.
//  Copyright © 2020 Amanpreet Kaur. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController:
UIViewController,AVAudioRecorderDelegate, AVAudioPlayerDelegate {
   
    
    @IBOutlet weak var record: UIButton!
    @IBOutlet weak var play: UIButton!
    
    
    var SoundRecorder: AVAudioRecorder!
    var SoundPlayer: AVAudioPlayer!
    
    
    var fileName : String = "audioFile.m4a"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupRecorder()
        play.isEnabled = false
        
    }
    
    func getDocumentsDirector() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func setupRecorder() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        let recordSetting = [ AVFormatIDKey : kAudioFormatAppleLossless ,
                              AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                              AVEncoderBitRateKey : 320000,
                              AVNumberOfChannelsKey : 2,
                              AVSampleRateKey : 44100.2 ] as [String : Any]
        do {
            SoundRecorder = try AVAudioRecorder(url: audioFilename, settings: recordSetting)
            SoundRecorder.delegate = self
            SoundRecorder.prepareToRecord()
        } catch {
            print(error)
        }
    }
    
    func setupPlayer() {
        let audioFilename = getDocumentsDirector().appendingPathComponent(fileName)
        do {
            SoundPlayer = try AVAudioPlayer(contentsOf: audioFilename)
            SoundPlayer.delegate = self
            SoundPlayer.prepareToPlay()
            SoundPlayer.volume = 1.0
        } catch {
            print(error)
        }

    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        play.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        record.isEnabled = true
        play.setTitle("Play", for: .normal)
    }
    
    
    
    
    
    @IBAction func recordAtn(_ sender: Any) {
        
        
       if record.titleLabel?.text == "Record" {
            SoundRecorder.record()
            record.setTitle("Stop", for: .normal)
            play.isEnabled = false
        } else {
            SoundRecorder.stop()
            record.setTitle("Record", for: .normal)
            play.isEnabled = false
        }
        
        
}
    
    
    @IBAction func playAtn(_ sender: Any) {
        
        
        
        if play.titleLabel?.text == "Play"
        {
                play.setTitle("Stop", for: .normal)
                record.isEnabled = false
                setupPlayer()
                SoundPlayer.play()
            } else {
            
                SoundPlayer!.stop()
                play.setTitle("Play", for: .normal)
                record.isEnabled = false
            }

        
        
        
        
        
        
        
        
    }
    


}
