public struct VehicleInfo: Equatable, Hashable {

    public let name: String
    public let plate: String

    public init(name: String, plate: String) {
        self.name = name
        self.plate = plate
    }
}
