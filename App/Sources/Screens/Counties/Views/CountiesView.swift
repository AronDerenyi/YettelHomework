import SwiftUI

struct CountiesView: View {

    @Binding var counties: [County]

    var body: some View {
        VStack(alignment: .leading, spacing: 24.0) {
            YettelText(key: "counties_title", style: .title)
                .padding(.vertical, 6.0)

            MapView(counties: counties)

            VStack (spacing: 16.0) {
                ForEach($counties, id: \.id) { county in
                    CountyView(county: county)
                }
            }
        }
    }
}
