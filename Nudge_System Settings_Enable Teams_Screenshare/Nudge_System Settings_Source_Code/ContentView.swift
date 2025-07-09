import SwiftUI
import AppKit

// Extension to allow using hex color codes
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

struct ContentView: View {
    // Microsoft Teams brand color
    let teamsBrandColor = Color(hex: "#505AC9")

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 15) {
                // You'll need to add a "teams-logo" image to your Assets.xcassets
                Image("teams-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)

                Text("Enable Screen Recording for Teams")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(teamsBrandColor)
            }
            
            VStack(alignment: .leading, spacing: 15) {
                Text("To share your screen in Teams, enable screen recording in System Settings.")
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("1. Click 'Open System Settings' below.")
                    Text("2. Navigate to 'Privacy & Security' → 'Screen Recording'.")
                    Text("3. Turn on the switch for 'Microsoft Teams'.")
                    Text("4. Restart Teams if it was already running.")
                }
            }
            .frame(maxWidth: 480)

            Spacer()

            HStack(spacing: 12) {
                Button(action: quitApp) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                }
                .controlSize(.large)
                .keyboardShortcut(.cancelAction)

                Button(action: openSystemSettings) {
                    Text("Open System Settings")
                        .frame(maxWidth: .infinity)
                }
                .controlSize(.large)
                .tint(teamsBrandColor)
            }
            
        }
        .padding()
        .frame(minWidth: 550, minHeight: 320)
    }

    func openSystemSettings() {
        // This URL opens the "Screen Recording" section in System Settings.
        // On modern macOS, this permission also covers system audio capture.
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?ScreenCapture") {
            NSWorkspace.shared.open(url)
        }
    }

    func quitApp() {
        NSApplication.shared.terminate(nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
} 
