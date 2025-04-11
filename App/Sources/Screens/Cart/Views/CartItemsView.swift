import SwiftUI

struct CartItemsView: View {

    let items: [CartItem]
    let fee: Float

    var body: some View {
        VStack(spacing: 12.0) {
            ForEach(Array(items.enumerated()), id: \.offset) { (_, item) in
                HStack(spacing: 0.0) {
                    YettelText(item.type.text, style: .bold)
                    Spacer()
                    YettelText(NSNumber(value: item.cost), format: .currency, style: .smallThin)
                }
            }
            HStack(spacing: 0.0) {
                YettelText(key: "cart_fee_label", style: .small)
                Spacer()
                YettelText(NSNumber(value: fee), format: .currency, style: .smallThin)
            }
        }
        .padding(.vertical, 32.0)
    }
}

extension CartItemType {
    var text: Text {
        switch self {
        case .country(type: .day, let category):
            Text(category + " - ") + Text("cart_type_day")
        case .country(type: .week, let category):
            Text(category + " - ") + Text("cart_type_week")
        case .country(type: .month, let category):
            Text(category + " - ") + Text("cart_type_month")
        case .country(type: .year, let category):
            Text(category + " - ") + Text("cart_type_year")
        case .county(let name):
            Text(name)
        }
    }
}
