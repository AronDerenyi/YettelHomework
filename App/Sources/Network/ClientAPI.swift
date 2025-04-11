import OpenAPIURLSession

class ClientAPI {

    private let client: Client

    init() {
        client = Client(
            serverURL: try! Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }
}

extension ClientAPI: API {

    func getHighwayInfo() async -> Result<HighwayInfo, GetError> {
        guard let response = try? await client.getHighwayInfo() else {
            return .failure(.server)
        }

        switch response {
        case .ok(let payload):
            guard let jsonBody = try? payload.body.json else {
                return .failure(.format)
            }

            return .success(.fromJson(jsonBody))
        case .notFound(_):
            return .failure(.notFound)
        case .undocumented(_, _):
            return .failure(.general)
        }
    }

    func getVehicleInfo() async -> Result<VehicleInfo, GetError> {
        guard let response = try? await client.getVehicleInfo() else {
            return .failure(.server)
        }

        switch response {
        case .ok(let payload):
            guard let jsonBody = try? payload.body.json else {
                return .failure(.format)
            }

            return .success(.fromJson(jsonBody))
        case .notFound(_):
            return .failure(.notFound)
        case .undocumented(_, _):
            return .failure(.general)
        }
    }

    func postHighwayOrder(vignette: Vignette) async -> Result<(), PostError> {
        await postHighwayOrder(body: .fromVignette(vignette))
    }

    func postHighwayOrder(countyVignettes: [CountyVignette]) async -> Result<(), PostError> {
        await postHighwayOrder(body: .fromCountyVignettes(countyVignettes))
    }

    private func postHighwayOrder(body: Operations.postHighwayOrder.Input.Body) async -> Result<(), PostError> {
        guard let response = try? await client.postHighwayOrder(body: body) else {
            return .failure(.server)
        }

        switch response {
        case .ok:
            return .success(())
        case .badRequest:
            return .failure(.badRequest)
        case .notFound:
            return .failure(.notFound)
        case .undocumented:
            return .failure(.general)
        }
    }
}

extension HighwayInfo {
    static func fromJson(_ json: Operations.getHighwayInfo.Output.Ok.Body.jsonPayload) -> Self {
        let counties = Dictionary(uniqueKeysWithValues: json.payload?.counties?.compactMap {
            if let id = $0.id, let name = $0.name {
                (id, name)
            } else {
                nil
            }
        } ?? [])

        let categories = Dictionary(uniqueKeysWithValues: json.payload?.vehicleCategories?.compactMap {
            if let category = $0.category, let vignetteCategory = $0.vignetteCategory {
                (category, vignetteCategory)
            } else {
                nil
            }
        } ?? [])

        var vignettes: [Vignette] = []
        var countyVignettes: [CountyVignette] = []

        json.payload?.highwayVignettes?.forEach { jsonVignette in
            jsonVignette.vignetteType?.forEach { jsonType in
                guard
                    let vehicleCategory = jsonVignette.vehicleCategory,
                    let category = categories[vehicleCategory]
                else {
                    return
                }

                let cost = jsonVignette.cost ?? 0.0
                let fee = jsonVignette.trxFee ?? 0.0
                if let type = VignetteType.fromString(jsonType) {
                    vignettes.append(Vignette(
                        type: type,
                        cost: cost,
                        fee: fee,
                        category: category,
                        vehicleCategory: vehicleCategory
                    ))
                } else if let name = counties[jsonType] {
                    countyVignettes.append(CountyVignette(
                        id: jsonType,
                        name: name,
                        cost: cost,
                        fee: fee,
                        vehicleCategory: vehicleCategory
                    ))
                }
            }
        }

        return Self.init(
            vignettes: vignettes,
            countyVignettes: countyVignettes
        )
    }
}

extension VignetteType {
    static func fromString(_ string: String) -> Self? {
        switch string {
        case "DAY":
            .day
        case "WEEK":
            .week
        case "MONTH":
            .month
        case "YEAR":
            .year
        default:
            nil
        }
    }
}

extension VehicleInfo {
    static func fromJson(_ json: Operations.getVehicleInfo.Output.Ok.Body.jsonPayload) -> Self {
        return Self.init(name: json.name ?? "", plate: json.plate ?? "")
    }
}

extension Operations.postHighwayOrder.Input.Body {
    static func fromVignette(_ vignette: Vignette) -> Self {
        let type: String
        switch vignette.type {
        case .day:
            type = "DAY"
        case .week:
            type = "WEEK"
        case .month:
            type = "MONTH"
        case .year:
            type = "YEAR"
        }

        return .json(.init(highwayOrders: [
            .init(
                _type: type,
                category: vignette.vehicleCategory,
                cost: vignette.cost + vignette.fee
            )
        ]))
    }

    static func fromCountyVignettes(_ countyVignettes: [CountyVignette]) -> Self {
        return .json(.init(highwayOrders: countyVignettes.map { countyVignette in
            .init(
                _type: countyVignette.id,
                category: countyVignette.vehicleCategory,
                cost: countyVignette.cost + countyVignette.fee
            )
        }))
    }
}
