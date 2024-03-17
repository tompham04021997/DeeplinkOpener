//
//  LottieView.swift
//  SBDeeplinkOpener
//
//  Created by Tuan Pham on 17/03/2024.
//

import SwiftUI
import AppKit
import Lottie

public struct LottieView: NSViewRepresentable{
    
    
    public init(name: String, loopMode: LottieLoopMode = .loop, autostart: Bool = true, contentMode: LottieContentMode = LottieContentMode.scaleAspectFit) {
        
        self.name = name
        self.loopMode = loopMode
        self.autostart = autostart
        self.contentMode = contentMode
    }
    
    
    let name: String
    let loopMode: LottieLoopMode
    let autostart: Bool
    let contentMode: LottieContentMode
    
    
    let animationView = LottieAnimationView()
    
    public func makeNSView(context: Context) -> some NSView {
        let theView = NSView()
      
        animationView.animation = .named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.backgroundBehavior = .pauseAndRestore
        

        if self.autostart{
            animationView.play()
        }
        
        theView.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: theView.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: theView.widthAnchor).isActive = true
        animationView.leadingAnchor.constraint(equalTo: theView.leadingAnchor).isActive = true
        animationView.trailingAnchor.constraint(equalTo: theView.trailingAnchor).isActive = true
        
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        animationView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return theView
    }
    
    
    func pause(){
        animationView.pause()
    }
    
    func play(){
        animationView.play()
    }
    
    func stop(){
        animationView.stop()
    }
    
    public func updateNSView(_ nsView: NSViewType, context: Context) {
        
    }
}
