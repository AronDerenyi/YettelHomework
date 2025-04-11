import SwiftUI

struct ConfettiView: View {

    private static let COUNT = 200
    private static let SIZE = 12.0
    private static let COLORS: [Color] = [
        .blue,
        .red,
        .yellow
    ]
    private static let ROTATION_SPEED = 0.2
    private static let AXIS_RANGE = (x: -1.0...1.0, y: -0.2...0.2, z: -0.4...0.4)
    private static let HEIGHT_RANGE = 0.0...200.0
    private static let LENGTH_RANGE = 200.0...600.0

    @State private var progress: Double = 0.0
    @State private var opacity: Double = 1.0

    @State private var confetties: [Confetti] = (0..<COUNT).map { index in
        Confetti(
            color: COLORS[Int.random(in: 0..<COLORS.count)],
            offset: (
                CGFloat(index) / CGFloat(COUNT),
                CGFloat(-Double.random(in: HEIGHT_RANGE))
            ),
            length: CGFloat(Double.random(in: LENGTH_RANGE)),
            axis: (
                CGFloat(Double.random(in: AXIS_RANGE.x)),
                CGFloat(Double.random(in: AXIS_RANGE.y)),
                CGFloat(Double.random(in: AXIS_RANGE.z))
            )
        )
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Spacer().frame(maxWidth: .infinity, maxHeight: .infinity)
                ForEach(Array(confetties.enumerated()), id: \.offset) { (_, confetti) in
                    Rectangle()
                        .fill(confetti.color)
                        .rotation3DEffect(
                            Angle(radians: confetti.length * progress * Self.ROTATION_SPEED),
                            axis: confetti.axis
                        )
                        .frame(width: Self.SIZE, height: Self.SIZE)
                        .offset(
                            x: confetti.offset.x * proxy.size.width,
                            y: confetti.offset.y + confetti.length * progress
                        )
                }
            }
            .clipped()
            .ignoresSafeArea()
            .opacity(opacity)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 5.0)) {
                progress = 1.0
            }
            withAnimation(.easeIn(duration: 4.0)) {
                opacity = 0.0
            }
        }
    }
}

private struct Confetti {
    let color: Color
    let offset: (x: CGFloat, y: CGFloat)
    let length: CGFloat
    let axis: (x: CGFloat, y: CGFloat, z: CGFloat)
}

#Preview {
    ConfettiView()
}
