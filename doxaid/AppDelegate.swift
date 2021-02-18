//
//  AppDelegate.swift
//  doxaid
//
//  Created by Jonathan Stoneman on 18/02/2021.
//

import Cocoa
import HotKey

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem?
    
    var hyperF10HotKey: HotKey?
    var hyperF11HotKey: HotKey?
    var hyperF12HotKey: HotKey?
    var hyperF13HotKey: HotKey?
    var hyperF14HotKey: HotKey?
    var hyperF15HotKey: HotKey?
    
    var layerImagePanel: LayerImagePanel!

    @IBOutlet weak var menu: NSMenu?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        createLayerImagePanel()
        
        hyperF10HotKey = HotKey(keyCombo: KeyCombo(key: .f10, modifiers: [.command, .option, .control, .shift]))
        hyperF11HotKey = HotKey(keyCombo: KeyCombo(key: .f11, modifiers: [.command, .option, .control, .shift]))
        hyperF12HotKey = HotKey(keyCombo: KeyCombo(key: .f12, modifiers: [.command, .option, .control, .shift]))
        hyperF13HotKey = HotKey(keyCombo: KeyCombo(key: .f13, modifiers: [.command, .option, .control, .shift]))
        hyperF14HotKey = HotKey(keyCombo: KeyCombo(key: .f14, modifiers: [.command, .option, .control, .shift]))
        hyperF15HotKey = HotKey(keyCombo: KeyCombo(key: .f15, modifiers: [.command, .option, .control, .shift]))
        
        hyperF10HotKey?.keyDownHandler = {
            self.showLayerImagePanel(layer: 0)
        }
        hyperF11HotKey?.keyDownHandler = {
            self.showLayerImagePanel(layer: 1)
        }
        hyperF12HotKey?.keyDownHandler = {
            self.showLayerImagePanel(layer: 2)
        }
        hyperF13HotKey?.keyDownHandler = {
            self.showLayerImagePanel(layer: 3)
        }
        hyperF14HotKey?.keyDownHandler = {
            self.showLayerImagePanel(layer: 4)
        }
        hyperF15HotKey?.keyDownHandler = {
            self.showLayerImagePanel(layer: 5)
        }
        
        hyperF10HotKey?.keyUpHandler = hideLayerImagePanel
        hyperF11HotKey?.keyUpHandler = hideLayerImagePanel
        hyperF12HotKey?.keyUpHandler = hideLayerImagePanel
        hyperF13HotKey?.keyUpHandler = hideLayerImagePanel
        hyperF14HotKey?.keyUpHandler = hideLayerImagePanel
        hyperF15HotKey?.keyUpHandler = hideLayerImagePanel
    }
    
    func createLayerImagePanel() {
//        let contentView = ContentView()

        // Create the window and set the content view.
        layerImagePanel = LayerImagePanel()

//        layerImagePanel.contentView = NSHostingView(rootView: contentView)
    }
    
    func showLayerImagePanel(layer: Int) {
        layerImagePanel.setLayer(layer: layer)

        // Shows the panel and makes it active
        layerImagePanel.orderFront(nil)
        layerImagePanel.makeKey()
    }

    func hideLayerImagePanel() {
        layerImagePanel.orderOut(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        let itemImage = NSImage(named: "ez")
        itemImage?.isTemplate = true
        statusItem?.button?.image = itemImage
        
        if let menu = menu {
            statusItem?.menu = menu
        }
    }
}

