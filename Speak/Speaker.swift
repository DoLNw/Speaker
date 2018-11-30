//
//  Speaker.swift
//  Speak
//
//  Created by JiaCheng on 2018/11/30.
//  Copyright © 2018 JiaCheng. All rights reserved.
//

import AVFoundation

class Speaker: NSObject, AVSpeechSynthesizerDelegate {
    let synth = AVSpeechSynthesizer()
    let audioSession = AVAudioSession.sharedInstance()
    
    override init() {
        super.init()
        
        synth.delegate = self
        do {
            //如果是.soloAmbient这个类型，那么就算capabili里的backgroundmodes开了，并且让第一个有maudio的打开，也无法在后台播放。下面那个类型配合开关打开是可以后台播放的。
            try audioSession.setCategory(.playback, mode: .default, options: [])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func speak(message: String) {
//        do {
//            try audioSession.setActive(true, options: [])
//        } catch {
//            print(error.localizedDescription)
//        }
        
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh_CN")
        utterance.volume = 1
        utterance.pitchMultiplier = 1.1
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        //中断之前说的话
        if synth.isSpeaking {
            synth.stopSpeaking(at: .immediate)
        }
        synth.speak(utterance)
        /**
        print(AVSpeechUtteranceDefaultSpeechRate) //0.5
        print(AVSpeechUtteranceMinimumSpeechRate) //0.0
        print(AVSpeechUtteranceMaximumSpeechRate) //1.0
        */
        
//        //还没读完直接setDeactive不行的吧？
//        do {
//            try audioSession.setActive(false, options: [])
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    func pauseSpeak() {
        synth.stopSpeaking(at: AVSpeechBoundary.word) //也能结束语音，但遇到中断上一个语音，立即朗读另一个文本就做不到。
        //        synth.stopSpeaking(at: AVSpeechBoundary.immediate)
    }
    
    //这个是读完一个语音，被终止应该不算吧？
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        print("Finished!")
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
    }
}
