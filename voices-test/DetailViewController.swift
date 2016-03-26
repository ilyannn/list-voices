//
//  DetailViewController.swift
//  voices-test
//
//  Created by Ilya Nikokoshev on 26.03.16.
//  Copyright © 2016 ilya n. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var languageIdentifierLabel: UILabel!
  @IBOutlet weak var languageCodeLabel: UILabel!
  @IBOutlet weak var qualityControl: UISegmentedControl!


  var voice: AVSpeechSynthesisVoice!

  var speakingText:String?

  func configureView() {
    let locale = NSLocale(localeIdentifier: voice.language)
    let code = voice.language
    let text = locale.displayNameForKey(NSLocaleIdentifier, value: code)

    title = voice.name
    languageCodeLabel.text = code
    languageIdentifierLabel.text = voice.identifier
    detailDescriptionLabel.text = text
    speakingText = text
    qualityControl.selectedSegmentIndex = voice.quality.rawValue - AVSpeechSynthesisVoiceQuality.Default.rawValue
  }


  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    if let text = speakingText {
      let say = AVSpeechUtterance(string: text)
      say.voice = voice
      AVSpeechSynthesizer().speakUtterance(say)
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

