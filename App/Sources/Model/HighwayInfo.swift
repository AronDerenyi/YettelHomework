public struct HighwayInfo: Equatable, Hashable {

    public let vignettes: [Vignette]
    public let countyVignettes: [CountyVignette]

    public init(vignettes: [Vignette], countyVignettes: [CountyVignette]) {
        self.vignettes = vignettes
        self.countyVignettes = countyVignettes
    }
}
