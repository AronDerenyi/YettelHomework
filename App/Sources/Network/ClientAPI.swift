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
    
    func postHighwayOrder() async -> Result<(), PostError> {
        guard let response = try? await client.postHighwayOrder(body: .json(.init(highwayOrders: [.init(_type: "", category: "", cost: 0.0)]))) else {
            return .failure(.server)
        }

        switch response {
        case .ok(_):
            return .success(())
        case .badRequest(_):
            return .failure(.badRequest)
        case .notFound(_):
            return .failure(.notFound)
        case .undocumented(statusCode: let statusCode, _):
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
                switch jsonType {
                case "DAY":
                    vignettes.append(Vignette(category: category, type: .day, cost: cost, fee: fee))
                case "WEEK":
                    vignettes.append(Vignette(category: category, type: .week, cost: cost, fee: fee))
                case "MONTH":
                    vignettes.append(Vignette(category: category, type: .month, cost: cost, fee: fee))
                case "YEAR":
                    vignettes.append(Vignette(category: category, type: .year, cost: cost, fee: fee))
                case let id:
                    if let name = counties[id] {
                        countyVignettes.append(CountyVignette(
                            id: id,
                            name: name,
                            cost: cost,
                            fee: fee
                        ))
                    }
                }
            }
        }
        //payload?.vehicleCategories[0].(category, vignetteCategory, name.(en, hu))

        return Self.init(
            vignettes: vignettes,
            countyVignettes: countyVignettes
        )
    }
}

extension VehicleInfo {
    static func fromJson(_ json: Operations.getVehicleInfo.Output.Ok.Body.jsonPayload) -> Self {
        return Self.init(name: json.name ?? "", plate: json.plate ?? "")
    }
}
