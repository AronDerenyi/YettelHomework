import SwiftUI

struct YettelText: View {

    private static let currencyFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .init(identifier: "fr_FR")
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        formatter.groupingSeparator = " "
        formatter.positiveSuffix = " Ft"
        formatter.negativeSuffix = " Ft"
        return formatter
    }()

    private let text: Text
    private let style: YettelTextStyle

    init(_ text: Text, style: YettelTextStyle = .regular) {
        self.text = text
        self.style = style
    }

    init(_ text: String, style: YettelTextStyle = .regular) {
        self.init(Text(text), style: style)
    }

    init(key: LocalizedStringKey, style: YettelTextStyle = .regular) {
        self.init(Text(key), style: style)
    }

    init(_ number: NSNumber, format: YettelTextNumberFormat, style: YettelTextStyle = .regular) {
        switch format {
        case .currency:
            self.init(Text(Self.currencyFormatter.string(from: number) ?? "- Ft"), style: style)
        }
    }

    var body: some View {
        text
            .font(font)
            .foregroundStyle(color)
    }

    private var font: Font {
        switch style {
        case .tiny:
            return .system(size: 12.0, weight: .thin)
        case .regular:
            return .system(size: 16.0, weight: .light)
        case .bold:
            return .system(size: 16.0, weight: .semibold)
        case .thin, .light:
            return .system(size: 16.0, weight: .thin)
        case .title:
            return .system(size: 20.0, weight: .semibold)
        case .subTitle:
            return .system(size: 12.0, weight: .bold)
        case .huge:
            return .system(size: 40.0, weight: .semibold)
        }
    }

    private var color: Color {
        switch style {
        case .light:
            return YettelHomeworkAsset.Assets.light.swiftUIColor
        default:
            return YettelHomeworkAsset.Assets.primary.swiftUIColor
        }
    }
}

enum YettelTextStyle {
    case tiny
    case regular
    case bold
    case thin
    case light
    case title
    case subTitle
    case huge
}

enum YettelTextNumberFormat {
    case currency
}
