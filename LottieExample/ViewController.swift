//
//  ViewController.swift
//  LottieExample
//
//  Created by Emin Roblack on 11/25/18.
//  Copyright © 2018 emiN Roblack. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController, UIScrollViewDelegate {
  
  let animationView = LOTAnimationView(name: "icons")
  let progressBar = UIProgressView()
  var progressLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(reckognizer:)))
    self.view.addGestureRecognizer(panGesture)
    
    setupAnimation()
    setupLabel()
    
    self.view.addSubview(animationView)
    self.view.addSubview(progressBar)
    self.view.addSubview(progressLabel)
    
    DispatchQueue.main.async {
      self.progressBar.progress = Float(self.animationView.animationProgress)
      self.progressLabel.text = String(Float(self.animationView.animationProgress))
    }
  }
  
  @objc func handlePan(reckognizer: UIPanGestureRecognizer) {
    let translation = reckognizer.translation(in: self.view)
    let progress = translation.x / self.view.bounds.size.width
    
    animationView.animationProgress = progress
   // animationView.play()
    progressLabel.text = "\(animationView.animationProgress)"
    animationView.play()
    
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let progress = scrollView.contentOffset.x / scrollView.contentSize.width
    
    animationView.animationProgress = progress
    progressBar.progress = Float(progress)
    progressLabel.text = "\(progress)"
  }
  
  func setupAnimation() {
    animationView.loopAnimation = true
    animationView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width , height: view.bounds.size.height)
    animationView.contentMode = .scaleAspectFit
    animationView.backgroundColor = UIColor.cyan
    
    animationView.play()
  }
  
  
  func setupLabel() {
    progressLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2, y: 100, width: 100, height: 100))
    progressLabel.center = CGPoint(x: self.view.frame.size.width/2, y: 100)
    progressLabel.text = "TEST"
    
    progressBar.frame = CGRect(x: 0, y: 0, width: 200, height: 15)
  }


}

