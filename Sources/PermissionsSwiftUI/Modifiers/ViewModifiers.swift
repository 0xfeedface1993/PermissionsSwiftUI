//
//  ViewModifier.swift
//  
//
//  Created by Jevon Mao on 2/2/21.
//

import SwiftUI

struct ButtonStatusColor: ViewModifier {
    var allowButtonStatus: AllowButtonStatus
    func body(content: Content) -> some View {
        switch self.allowButtonStatus {
        case .idle:
            return content.allowButton(foregroundColor: Color(.systemBlue), backgroundColor: Color(.systemGray5))

        case .allowed:
            return content.allowButton(foregroundColor: Color(.white), backgroundColor: Color(.systemBlue))


        case .denied:
            return content.allowButton(foregroundColor: Color(.white), backgroundColor: Color(.systemRed))
        }
    }
}

struct AllowButton: ViewModifier{
    var foregroundColor: Color
    var backgroundColor: Color
    var buttonSizeConstant: CGFloat{
        return screenSize.width < 400 ?  70-(1000-screenSize.width)/30 : 70
    }
    func body(content: Content) -> some View {
        content
        .frame(width: buttonSizeConstant)
        .font(.system(size: 15))
        .minimumScaleFactor(0.2)
        .lineLimit(1)
        .foregroundColor(foregroundColor)
        .padding(.vertical,6)
        .padding(.horizontal, 6)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
    }
}

struct JMAlertViewFrame: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color(.systemBackground).opacity(0.8))
            .frame(width: screenSize.width > 375 ? 375 : screenSize.width-60)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func buttonStatusColor(for allowButtonStatus: AllowButtonStatus) -> some View {
        self.modifier(ButtonStatusColor(allowButtonStatus: allowButtonStatus))
    }
    func allowButton(foregroundColor: Color, backgroundColor: Color) -> some View{
        self.modifier(AllowButton(foregroundColor: foregroundColor, backgroundColor: backgroundColor))
    }
    func alertViewFrame() -> some View{
        self.modifier(JMAlertViewFrame())
    }
}
