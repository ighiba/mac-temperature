//
//  GeneralSettingsViewController.swift
//  MacTemperature
//
//  Created by Ivan Ghiba on 02.06.2023.
//

import Cocoa

class GeneralSettingsViewController: SettingsItemViewController, SettingsItemView {
 
    var settings: GeneralSettingsData { delegate.generalSettings }
    
    var delegate: GeneralSettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingsRowsStack.addArrangedSubview(mainWindowCheckbox)
        settingsRowsStack.addArrangedSubview(launchAfterStartnCheckbox)
        settingsRowsStack.addArrangedSubview(updateFrequency)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        view.window?.makeFirstResponder(nil)
    }
    
    // MARK: - Views
    
    lazy var mainWindowCheckbox = SettingRowContainer(
        title: "Main window",
        views: [getMainWindowCheckboxButton()],
        width: settingsWidth
    )
    
    lazy var launchAfterStartnCheckbox = SettingRowContainer(
        title: "Launch after start",
        views: [getLaunchAfterStartCheckboxButton()],
        width: settingsWidth
    )
    
    lazy var updateFrequency = SettingRowContainer(
        title: "Update frequency",
        views: [
            editFrequencyTextField,
            NSTextField(labelWithString: "seconds"),
            NSButton(title: "Set", target: self, action: #selector(setNewFrequency))
        ],
        width: settingsWidth
    )
    
    private func getMainWindowCheckboxButton() -> NSButton {
        let button = NSButton(
            checkboxWithTitle: "Open at every launch",
            target: self,
            action: #selector(mainWindowCheckboxChanged)
        )
        button.state = settings.mainWindowOpenEveryLaunch ? .on : .off
        return button
    }
    
    private func getLaunchAfterStartCheckboxButton() -> NSButton {
        let button = NSButton(
            checkboxWithTitle: "The App will launch automatically after Mac start",
            target: self,
            action: #selector(launchAfterStartnCheckboxChanged)
        )
        button.state = settings.appShouldLaunchAfterStart ? .on : .off
        return button
    }
    
    lazy var editFrequencyTextField: NSTextField = {
        let textField = NSTextField()
        
        textField.stringValue = "\(settings.updateFrequencyInSeconds)"
        textField.isEditable = true
        textField.focusRingType = .none
        textField.alignment = .right
        textField.frame = NSRect(x: 0, y: 0, width: 30, height: 30)
        
        let numberFormatter = IntegerNumberFormatter()
        textField.formatter = numberFormatter
        
        return textField
    }()
}

// MARK: - Actions

extension GeneralSettingsViewController {
    @objc func mainWindowCheckboxChanged(_ sender: NSButton) {
        settings.mainWindowOpenEveryLaunch = sender.state == .on ? true : false
        delegate.setGeneralSettings(settings)
    }

    @objc func launchAfterStartnCheckboxChanged(_ sender: NSButton) {
        settings.appShouldLaunchAfterStart = sender.state == .on ? true : false
        delegate.setGeneralSettings(settings)
    }

    @objc func setNewFrequency() {
        view.window?.makeFirstResponder(nil)
        let newUpdateFrequency = Int(editFrequencyTextField.stringValue) ?? 1
        settings.updateFrequencyInSeconds = newUpdateFrequency
        delegate.setGeneralSettings(settings)
    }
}

class IntegerNumberFormatter: NumberFormatter {
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if partialString.isEmpty {
            return true
        }
        
        if let value = Int(partialString) {
            return (value >= 1 && value <= 60)
        }
        
        return false
    }
}
