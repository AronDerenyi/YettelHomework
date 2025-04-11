import SwiftUI

struct ResultView: View {

    let dismiss: () -> Void

    @State private var showConfetti: Bool = false

    var body: some View {
        ZStack {
            YettelHomeworkAsset.Assets.result.swiftUIImage
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                .offset(x: 0.0, y: -110.0)

            VStack(spacing: 72) {
                YettelText(key: "cart_result_title", style: .huge)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                    .padding(.leading, 32.0)
                    .padding(.trailing, 42.0)
                    .padding(.bottom, 16.0)

                YettelButton(key: "cart_result_ok_button") {
                    dismiss()
                }
                .padding(.horizontal, 32.0)
                .padding(.bottom, 34.0)
            }
            if showConfetti {
                ConfettiView()
            }
        }
        .background(YettelHomeworkAsset.Assets.accent.swiftUIColor)
        .task {
            try? await Task.sleep(for: .milliseconds(200))
            showConfetti = true
        }
    }
}

#Preview {
    ResultView {}
}
