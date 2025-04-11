import SwiftUI

struct CartDetailsView: View {

    let plate: String
    let type: CartType

    var body: some View {
        VStack(spacing: 16.0) {
            HStack(spacing: 0.0) {
                YettelText(key: "cart_plate_label", style: .smallThin)
                Spacer()
                YettelText(plate, style: .smallThin)
            }
            HStack(spacing: 0.0) {
                YettelText(key: "cart_type_label", style: .smallThin)
                Spacer()
                YettelText(key: type.text, style: .smallThin)
            }
        }
        .padding(.vertical, 16.0)
    }
}

extension CartType {
    var text: LocalizedStringKey {
        switch self {
        case .country(type: .day):
            "cart_type_day"
        case .country(type: .week):
            "cart_type_week"
        case .country(type: .month):
            "cart_type_month"
        case .country(type: .year):
            "cart_type_year"
        case .county:
            "cart_type_county"
        }
    }
}
