import SwiftUI

struct VignettesView: View {

    let vignettes: [Vignette]
    @Binding var selected: Int?
    let purchase: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            YettelText(key: "main_vignettes_title", style: .title)
                .padding(.vertical, 6.0)
            Spacer().frame(height: 8.0)
            VStack(spacing: 8.0) {
                ForEach(Array(vignettes.enumerated()), id: \.offset) { (index, vignette) in
                    VignetteView(vignette: vignette, selected: index == selected) {
                        selected = index
                    }
                }
            }
            Spacer().frame(height: 16.0)
            YettelButton(
                key: "main_purchase_button",
                disabled: selected == nil || selected ?? 0 < vignettes.count
            ) {
                purchase()
            }
        }
        .padding(.all, 16.0)
    }
}
