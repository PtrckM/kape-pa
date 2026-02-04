//
//  kape_paApp.swift
//  kape pa
//
//  Created by PtrckM on 12/16/25.
//

import SwiftUI
import ServiceManagement
import IOKit.pwr_mgt

@main
struct kape_paApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var timer: Timer?
    var endTime: Date?
    var noSleepAssertionID: IOPMAssertionID = 0
    var stopButton: NSButton!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Hide from dock and app switcher
        NSApp.setActivationPolicy(.accessory)
        setupMenuBar()
    }
    
    func setupMenuBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "mug.fill", accessibilityDescription: "KapePA")
        }
        
        let menu = NSMenu()
        
        // Header view with title, subtitle and quit button
        let headerItem = NSMenuItem()
        let headerView = NSView(frame: NSRect(x: 0, y: 0, width: 200, height: 40))
        
        // Title label
        let titleLabel = NSTextField(labelWithString: "Kape pa V1.0")
        titleLabel.font = NSFont.menuFont(ofSize: 13)
        titleLabel.frame = NSRect(x: 20, y: 20, width: 160, height: 20)
        titleLabel.isEditable = false
        titleLabel.isBordered = false
        titleLabel.drawsBackground = false
        headerView.addSubview(titleLabel)
        
        // Subtitle label with smaller font
        let subtitleLabel = NSTextField(labelWithString: "created by: PtrckM")
        subtitleLabel.font = NSFont.menuFont(ofSize: 10)
        subtitleLabel.frame = NSRect(x: 20, y: 5, width: 160, height: 15)
        subtitleLabel.textColor = .secondaryLabelColor
        subtitleLabel.isEditable = false
        subtitleLabel.isBordered = false
        subtitleLabel.drawsBackground = false
        headerView.addSubview(subtitleLabel)
        
        // Stop button
        let stopButton = NSButton(image: NSImage(systemSymbolName: "stop.fill", accessibilityDescription: "Stop Timer")!,
                                target: self,
                                action: #selector(stopTimer))
        stopButton.frame = NSRect(x: 130, y: 10, width: 24, height: 24)
        stopButton.bezelStyle = .regularSquare
        stopButton.isBordered = false
        stopButton.contentTintColor = .systemGray
        stopButton.isEnabled = false
        stopButton.toolTip = "Stop Timer"
        headerView.addSubview(stopButton)
        self.stopButton = stopButton
        
        // Power-off button at top right
        let powerButton = NSButton(image: NSImage(systemSymbolName: "power", accessibilityDescription: "Quit")!,
                                 target: NSApplication.shared,
                                 action: #selector(NSApplication.terminate(_:)))
        powerButton.frame = NSRect(x: 160, y: 10, width: 24, height: 24)
        powerButton.bezelStyle = .regularSquare
        powerButton.isBordered = false
        powerButton.contentTintColor = .systemRed
        powerButton.toolTip = "Quit App"
        headerView.addSubview(powerButton)
        
        headerItem.view = headerView
        menu.addItem(headerItem)
        
        // Add separator
        menu.addItem(NSMenuItem.separator())
        
        // Time interval options
        let intervals = [
            ("5 minutes", 5 * 60),
            ("10 minutes", 10 * 60),
            ("15 minutes", 15 * 60),
            ("30 minutes", 30 * 60),
            ("1 hour", 60 * 60),
            ("6 hours", 6 * 60 * 60),
            ("12 hours", 12 * 60 * 60),
            ("24 hours", 24 * 60 * 60)
        ]
        
        for (title, seconds) in intervals {
            let menuItem = NSMenuItem(
                title: title,
                action: #selector(setTimer(_:)),
                keyEquivalent: ""
            )
            menuItem.representedObject = seconds
            menu.addItem(menuItem)
        }
        
        statusBarItem.menu = menu
    }
    
    @objc func stopTimer() {
        timer?.invalidate()
        timer = nil
        endTime = nil
        statusBarItem.button?.title = ""
        stopButton.isEnabled = false
        stopButton.contentTintColor = .systemGray
        
        // Release the sleep assertion if active
        if noSleepAssertionID != 0 {
            IOPMAssertionRelease(noSleepAssertionID)
            noSleepAssertionID = 0
        }
    }
    
    @objc func setTimer(_ sender: NSMenuItem) {
        timer?.invalidate()
        
        // Enable stop button
        stopButton.isEnabled = true
        stopButton.contentTintColor = .systemRed
        
        // Release any existing assertion
        if noSleepAssertionID != 0 {
            IOPMAssertionRelease(noSleepAssertionID)
            noSleepAssertionID = 0
        }
        
        guard let seconds = sender.representedObject as? TimeInterval else { return }
        
        endTime = Date().addingTimeInterval(seconds)
        
        timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateMenuBar),
            userInfo: nil,
            repeats: true
        )
        
        // Prevent system sleep
        var success = IOPMAssertionCreateWithName(
            kIOPMAssertionTypeNoDisplaySleep as CFString,
            IOPMAssertionLevel(kIOPMAssertionLevelOn),
            "KapePA - Keeping system awake" as CFString,
            &noSleepAssertionID
        )
        
        if success == kIOReturnSuccess {
            // Schedule to release the assertion when the timer ends
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                IOPMAssertionRelease(self.noSleepAssertionID)
                self.noSleepAssertionID = 0
                self.timer?.invalidate()
                self.timer = nil
                self.statusBarItem.button?.title = ""
                self.statusBarItem.button?.image = NSImage(systemSymbolName: "mug.fill", accessibilityDescription: "KapePA")
            }
        }
        
        updateMenuBar()
    }
    
    @objc func updateMenuBar() {
        guard let endTime = endTime else { return }
        let remaining = Int(endTime.timeIntervalSinceNow)
        
        if remaining <= 0 {
            if noSleepAssertionID != 0 {
                IOPMAssertionRelease(noSleepAssertionID)
                noSleepAssertionID = 0
            }
            timer?.invalidate()
            timer = nil
            statusBarItem.button?.title = ""
            statusBarItem.button?.image = NSImage(systemSymbolName: "mug.fill", accessibilityDescription: "KapePA")
            return
        }
        
        let hours = remaining / 3600
        let minutes = (remaining % 3600) / 60
        let seconds = remaining % 60
        
        let timeString: String
        if hours > 0 {
            timeString = String(format: "%dh %02dm %02ds", hours, minutes, seconds)
        } else if minutes > 0 {
            timeString = String(format: "%dm %02ds", minutes, seconds)
        } else {
            timeString = String(format: "%ds", seconds)
        }
        
        statusBarItem.button?.title = timeString
    }
    
    deinit {
        if noSleepAssertionID != 0 {
            IOPMAssertionRelease(noSleepAssertionID)
        }
    }
}
