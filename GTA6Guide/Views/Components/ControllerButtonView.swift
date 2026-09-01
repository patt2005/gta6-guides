import SwiftUI
import UIKit

// MARK: - PS5 Asset Lookup

func ps5ButtonAssetName(for text: String) -> String? {
    let clean = text.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    switch clean {
    case "△", "TRIANGLE":
        if UIImage(named: "ps5-triangle") != nil { return "ps5-triangle" }
        if UIImage(named: "ps5-green-triangle") != nil { return "ps5-green-triangle" }
        if UIImage(named: "ps5-plain-triangle") != nil { return "ps5-plain-triangle" }
        return nil
    case "○", "CIRCLE", "O":
        if UIImage(named: "ps5-circle") != nil { return "ps5-circle" }
        if UIImage(named: "ps5-red-circle") != nil { return "ps5-red-circle" }
        if UIImage(named: "ps5-plain-circle") != nil { return "ps5-plain-circle" }
        return nil
    case "✕", "CROSS", "X":
        if UIImage(named: "ps5-cross") != nil { return "ps5-cross" }
        if UIImage(named: "ps5-blue-cross") != nil { return "ps5-blue-cross" }
        if UIImage(named: "ps5-plain-cross") != nil { return "ps5-plain-cross" }
        return nil
    case "□", "SQUARE":
        if UIImage(named: "ps5-square") != nil { return "ps5-square" }
        if UIImage(named: "ps5-purple-square") != nil { return "ps5-purple-square" }
        if UIImage(named: "ps5-plain-square") != nil { return "ps5-plain-square" }
        return nil
    case "→", "RIGHT":
        if UIImage(named: "ps5-dpad-right") != nil { return "ps5-dpad-right" }
        if UIImage(named: "ps5-touch-right") != nil { return "ps5-touch-right" }
        return nil
    case "←", "LEFT":
        if UIImage(named: "ps5-dpad-left") != nil { return "ps5-dpad-left" }
        if UIImage(named: "ps5-touch-left") != nil { return "ps5-touch-left" }
        return nil
    case "↑", "UP":
        if UIImage(named: "ps5-dpad-up") != nil { return "ps5-dpad-up" }
        if UIImage(named: "ps5-touch-up") != nil { return "ps5-touch-up" }
        return nil
    case "↓", "DOWN":
        if UIImage(named: "ps5-dpad-down") != nil { return "ps5-dpad-down" }
        if UIImage(named: "ps5-touch-down") != nil { return "ps5-touch-down" }
        return nil
    case "L1":
        if UIImage(named: "ps5-l1") != nil { return "ps5-l1" }
        return nil
    case "L2":
        if UIImage(named: "ps5-l2") != nil { return "ps5-l2" }
        return nil
    case "R1":
        if UIImage(named: "ps5-r1") != nil { return "ps5-r1" }
        return nil
    case "R2":
        if UIImage(named: "ps5-r2") != nil { return "ps5-r2" }
        return nil
    case "L3":
        if UIImage(named: "ps5-l3") != nil { return "ps5-l3" }
        if UIImage(named: "ps5-press-l3") != nil { return "ps5-press-l3" }
        return nil
    case "R3":
        if UIImage(named: "ps5-r3") != nil { return "ps5-r3" }
        if UIImage(named: "ps5-press-r3") != nil { return "ps5-press-r3" }
        return nil
    case "OPTIONS", "START":
        if UIImage(named: "ps5-options") != nil { return "ps5-options" }
        if UIImage(named: "ps5-small-options") != nil { return "ps5-small-options" }
        return nil
    case "TOUCHPAD", "PAD", "SELECT":
        if UIImage(named: "ps5-touchpad") != nil { return "ps5-touchpad" }
        if UIImage(named: "ps5-touchpad-medium") != nil { return "ps5-touchpad-medium" }
        return nil
    default:
        return nil
    }
}

// MARK: - Xbox Asset Lookup

func xboxButtonAssetName(for text: String) -> String? {
    let clean = text.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    switch clean {
    case "A":
        if UIImage(named: "a-filled-green") != nil { return "a-filled-green" }
        if UIImage(named: "a-filled") != nil { return "a-filled" }
        if UIImage(named: "a-outlined") != nil { return "a-outlined" }
        return nil
    case "B":
        if UIImage(named: "b-filled red") != nil { return "b-filled red" }
        if UIImage(named: "b-filled") != nil { return "b-filled" }
        if UIImage(named: "b-outlined") != nil { return "b-outlined" }
        return nil
    case "X":
        if UIImage(named: "x-filled-blue") != nil { return "x-filled-blue" }
        if UIImage(named: "x-filled") != nil { return "x-filled" }
        if UIImage(named: "x-filled-1") != nil { return "x-filled-1" }
        if UIImage(named: "x-outlined") != nil { return "x-outlined" }
        return nil
    case "Y":
        if UIImage(named: "y-filled-yellow") != nil { return "y-filled-yellow" }
        if UIImage(named: "y-outlined") != nil { return "y-outlined" }
        return nil
    case "→", "RIGHT":
        if UIImage(named: "dpad-right") != nil { return "dpad-right" }
        return nil
    case "←", "LEFT":
        if UIImage(named: "dpad-left") != nil { return "dpad-left" }
        return nil
    case "↑", "UP":
        if UIImage(named: "dpad-up") != nil { return "dpad-up" }
        return nil
    case "↓", "DOWN":
        if UIImage(named: "dpad-down") != nil { return "dpad-down" }
        return nil
    case "RB":
        if UIImage(named: "right-bumper") != nil { return "right-bumper" }
        return nil
    case "LB":
        if UIImage(named: "left-bumper") != nil { return "left-bumper" }
        return nil
    case "RT":
        if UIImage(named: "right-trigger") != nil { return "right-trigger" }
        return nil
    case "LT":
        if UIImage(named: "left-trigger") != nil { return "left-trigger" }
        return nil
    case "LS", "L3":
        if UIImage(named: "left-stick") != nil { return "left-stick" }
        if UIImage(named: "left-joystick-press") != nil { return "left-joystick-press" }
        if UIImage(named: "left-joystick") != nil { return "left-joystick" }
        return nil
    case "RS", "R3":
        if UIImage(named: "right-stick") != nil { return "right-stick" }
        if UIImage(named: "right-joystick-press") != nil { return "right-joystick-press" }
        if UIImage(named: "right-joystick") != nil { return "right-joystick" }
        return nil
    case "MENU", "START":
        if UIImage(named: "menu") != nil { return "menu" }
        return nil
    case "VIEW", "BACK", "SELECT":
        if UIImage(named: "view") != nil { return "view" }
        return nil
    default:
        return nil
    }
}

// MARK: - Controller Button View Component

struct ControllerButtonView: View {
    let buttonText: String
    let isPlaystation: Bool
    
    var body: some View {
        if isPlaystation, let assetName = ps5ButtonAssetName(for: buttonText) {
            Image(assetName)
                .resizable()
                .scaledToFit()
                .frame(height: 26)
                .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 1)
        } else if !isPlaystation, let assetName = xboxButtonAssetName(for: buttonText) {
            Image(assetName)
                .resizable()
                .scaledToFit()
                .frame(height: 26)
                .shadow(color: Color.black.opacity(0.4), radius: 2, x: 0, y: 1)
        } else {
            // Text badge fallback
            ControllerButtonBadge(buttonText, isPlaystation: isPlaystation)
        }
    }
}

struct ControllerButtonBadge: View {
    let text: String
    let isPlaystation: Bool
    
    init(_ text: String, isPlaystation: Bool = true) {
        self.text = text
        self.isPlaystation = isPlaystation
    }
    
    var body: some View {
        Text(text)
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .foregroundColor(buttonTextColor)
            .padding(.horizontal, text.count > 1 ? 8 : 6)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(buttonBackgroundColor)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(buttonBorderColor, lineWidth: 1)
            )
    }
    
    private var buttonTextColor: Color {
        switch text {
        case "△", "Y": return Color.viceGreen
        case "○", "B": return Color.neonPink
        case "✕", "A": return Color.viceCyan
        case "□", "X": return Color.viceGold
        case "→", "←", "↑", "↓": return Color.white
        case "L1", "R1", "L2", "R2", "LB", "RB", "LT", "RT": return Color.white
        default: return Color.white
        }
    }
    
    private var buttonBackgroundColor: Color {
        Color.darkCard.opacity(0.9)
    }
    
    private var buttonBorderColor: Color {
        switch text {
        case "△", "Y": return Color.viceGreen.opacity(0.6)
        case "○", "B": return Color.neonPink.opacity(0.6)
        case "✕", "A": return Color.viceCyan.opacity(0.6)
        case "□", "X": return Color.viceGold.opacity(0.6)
        default: return Color.cardBorder
        }
    }
}

struct ControllerSequenceView: View {
    let buttons: [String]
    let isPlaystation: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(Array(buttons.enumerated()), id: \.offset) { index, button in
                    ControllerButtonView(buttonText: button, isPlaystation: isPlaystation)
                }
            }
            .padding(.vertical, 2)
        }
    }
}
