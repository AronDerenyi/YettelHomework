import SwiftUI

struct PayView: View {

    let totel: Float
    let next: () -> Void
    let cancel: () -> Void

    var body: some View {
        VStack(spacing: 16.0) {
            YettelDivider()
            VStack(spacing: 24.0) {
                VStack(alignment: .leading, spacing: 4.0) {
                    YettelText(key: "cart_total_label", style: .subTitle)
                    YettelText(NSNumber(value: totel), format: .currency, style: .huge)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal, 16.0)
            .padding(.bottom, 16.0)
            YettelButton(key: "cart_next_button") {
                next()
            }
            YettelButton(key: "cart_cancel_button", style: .outline) {
                cancel()
            }
        }
        .padding(.horizontal, 16.0)
        .padding(.bottom, 16.0)
    }
}
