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
  @IBOutlet weak var languageIdentifierLabel: UILabel?

  @IBOutlet weak var languageNameLabel: UILabel!
  @IBOutlet weak var countryNameLabel: UILabel!
  @IBOutlet weak var languageCodeLabel: UILabel!
  
  @IBOutlet weak var qualityControl: UISegmentedControl!


  var voice: AVSpeechSynthesisVoice!

  var speakingText:String?

  func configureView() {
    let code = voice.language

    let target_locale = NSLocale(localeIdentifier: code)
    let current_locale = NSLocale.currentLocale()

    title = voice.name
    languageCodeLabel.text = code
    languageIdentifierLabel?.text = voice.identifier
    qualityControl.selectedSegmentIndex = voice.quality.rawValue
      - AVSpeechSynthesisVoiceQuality.Default.rawValue
    
    let code_parts = code.componentsSeparatedByString("-")
    languageNameLabel.text = current_locale.displayNameForKey(NSLocaleLanguageCode, value: code_parts[0])
    countryNameLabel.text  = current_locale.displayNameForKey(NSLocaleCountryCode, value: code_parts[1])
    
    let text = target_locale.displayNameForKey(NSLocaleIdentifier, value: code)
    detailDescriptionLabel.text = text
    speakingText = text
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

