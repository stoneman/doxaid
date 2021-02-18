//
//  LayerImagePanel.swift
//  doxaid
//
//  Created by Jonathan Stoneman on 18/02/2021.
//

import Cocoa

class LayerImagePanel: NSPanel {
    var layerImage: NSImageView = NSImageView()
    init() {
        super.init(contentRect: NSScreen.main!.visibleFrame, styleMask: [.nonactivatingPanel], backing: .buffered, defer: false)
        
        self.isFloatingPanel = true
        self.level = .floating
        self.collectionBehavior.insert(.fullScreenAuxiliary)
        self.isReleasedWhenClosed = false
    
        self.isOpaque = false
        self.hasShadow = false
        self.backgroundColor = NSColor.gray.withAlphaComponent(0.75)
        self.titlebarAppearsTransparent = true
        
        self.contentView = layerImage
      }
    
    func setLayer(layer: Int) {
        print("layer_" + String(layer))
        layerImage.image = NSImage(named: "layer_" + String(layer))
    }
}
