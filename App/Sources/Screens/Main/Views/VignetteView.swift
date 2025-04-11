import SwiftUI

struct VignetteView: View {

    let vignette: Vignette
    let selected: Bool
    let action: () -> Void

    var body: some View {
        HStack(spacing: 16.0) {
            ZStack {
                Circle()
                    .stroke(YettelHomeworkAsset.Assets.light.swiftUIColor, lineWidth: 2.0)
                    .frame(width: 28.0, height: 28.0)
                if selected {
                    Circle()
                        .fill(YettelHomeworkAsset.Assets.primary.swiftUIColor)
                        .frame(width: 16.0, height: 16.0)
                }
            }

            HStack(spacing: 0.0) {
                YettelText(
                    Text("\(vignette.category) - ") +
                    Text(vignette.type.localizedStringKey)
                )
                Spacer()
                YettelText(NSNumber(value: vignette.cost), format: .currency, style: .bold)
            }
        }
        .padding(.horizontal, 16.0)
        .padding(.vertical, 24.0)
        .contentShape(RoundedRectangle(cornerRadius: 8.0))
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(
                    selected ?
                    YettelHomeworkAsset.Assets.primary.swiftUIColor :
                    YettelHomeworkAsset.Assets.light.swiftUIColor,
                    lineWidth: 2.0
                )
        )
        .onTapGesture {
            action()
        }
    }
}

private extension VignetteType {

    var localizedStringKey: LocalizedStringKey {
        switch self {
        case .day:
            "main_vignette_type_day"
        case .week:
            "main_vignette_type_week"
        case .month:
            "main_vignette_type_month"
        case .year:
            "main_vignette_type_year"
        }
    }
}
