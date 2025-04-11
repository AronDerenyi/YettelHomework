import SwiftUI

struct YettelButton: View {

    private let text: Text
    private let disabled: Bool
    private let style: YettelButtonStyle
    private let action: () -> Void

    init(
        _ text: String,
        disabled: Bool = false,
        style: YettelButtonStyle = .regular,
        action: @escaping () -> Void
    ) {
        self.text = Text(text)
        self.disabled = disabled
        self.style = style
        self.action = action
    }

    init(
        key: LocalizedStringKey,
        disabled: Bool = false,
        style: YettelButtonStyle = .regular,
        action: @escaping () -> Void
    ) {
        self.text = Text(key)
        self.disabled = disabled
        self.style = style
        self.action = action
    }

    var body: some View {
        Button {
            if !disabled {
                action()
            }
        } label: {
            let label = text
                .font(.system(size: 16.0, weight: .semibold))
                .padding(.horizontal, 20.0)
                .padding(.vertical, 12.0)
                .frame(maxWidth: .infinity)

            switch style {
            case .regular:
                label
                    .background(
                        disabled ?
                        YettelHomeworkAsset.Assets.disabled.swiftUIColor :
                        YettelHomeworkAsset.Assets.primary.swiftUIColor
                    )
                    .foregroundStyle(
                        disabled ?
                        YettelHomeworkAsset.Assets.onDisabled.swiftUIColor :
                        YettelHomeworkAsset.Assets.onPrimary.swiftUIColor
                    )
                    .cornerRadius(.infinity)
            case .outline:
                label
                    .foregroundStyle(
                        disabled ?
                        YettelHomeworkAsset.Assets.disabled.swiftUIColor :
                        YettelHomeworkAsset.Assets.primary.swiftUIColor
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: .infinity)
                            .stroke(
                                disabled ?
                                YettelHomeworkAsset.Assets.disabled.swiftUIColor :
                                YettelHomeworkAsset.Assets.primary.swiftUIColor,
                                lineWidth: 2.0
                            )
                    )
                    .contentShape(RoundedRectangle(cornerRadius: .infinity))
            }
        }
        .disabled(disabled)
    }
}

enum YettelButtonStyle {
    case regular
    case outline
}
