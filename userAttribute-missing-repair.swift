
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create the main window
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 200),
            styleMask: [.titled, .closable, .resizable],
            backing: .buffered,
            defer: false
        )
        window.center()
        window.title = "Device Unassigned"
        window.makeKeyAndOrderFront(nil)

        // Create a label
        let label = NSTextField(labelWithString: "Your device was unassigned. Please enter your email address to update ownership of this device. Contact IT for further assistance.:")
        label.frame = NSRect(x: 20, y: 120, width: 360, height: 20)
        window.contentView?.addSubview(label)

        // Create a text field for email input
        let emailTextField = NSTextField(frame: NSRect(x: 20, y: 80, width: 360, height: 24))
        window.contentView?.addSubview(emailTextField)

        // Create a button
        let button = NSButton(frame: NSRect(x: 160, y: 40, width: 80, height: 30))
        button.title = "Submit"
        button.bezelStyle = .rounded
        button.action = #selector(submitButtonClicked)
        window.contentView?.addSubview(button)

        // Store the text field in the button's tag for later retrieval
        button.tag = emailTextField.hash
    }

    @objc func submitButtonClicked(_ sender: NSButton) {
        // Retrieve the email text field using the button's tag
        if let emailTextField = window.contentView?.viewWithTag(sender.tag) as? NSTextField {
            let emailAddress = emailTextField.stringValue
            print("Email address entered: \(emailAddress)")
            // Handle the email address as needed
        }
    }
}

// Create the application instance and set the delegate
let app = NSApplication.shared
let delegate = AppDelegate()
app.delegate = delegate
app.run()
