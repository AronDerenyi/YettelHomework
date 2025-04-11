import SwiftUI

struct TotalView: View {

    let total: Float
    let nextEnabled: Bool
    let next: () -> Void

    var body: some View {
        VStack(spacing: 16.0) {
            VStack(spacing: 24.0) {
                YettelDivider()
                VStack(alignment: .leading, spacing: 4.0) {
                    YettelText(key: "counties_total_label", style: .subTitle)
                    YettelText(NSNumber(value: total), format: .currency, style: .huge)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16.0)
            .padding(.bottom, 16.0)
            YettelButton(key: "counties_next_button", disabled: !nextEnabled) {
                next()
            }
        }
        .padding(.horizontal, 16.0)
        .padding(.bottom, 16.0)
    }
}
