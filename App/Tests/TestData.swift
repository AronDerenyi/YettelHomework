import YettelHomework

let VEHICLE_INFO = VehicleInfo(
    name: "Michael Scott",
    plate: "ABC-123"
)

let VIGNETTES = [
    Vignette(type: .day, cost: 5150, fee: 200, category: "D1", vehicleCategory: "CAR"),
    Vignette(type: .week, cost: 6400, fee: 200, category: "D1", vehicleCategory: "CAR"),
    Vignette(type: .month, cost: 10360, fee: 200, category: "D1", vehicleCategory: "CAR"),
    Vignette(type: .year, cost: 6660, fee: 200, category: "D1", vehicleCategory: "CAR"),
]

let COUNTY_VIGNETTES = [
    CountyVignette(id: "YEAR_11", name: "Bács-Kiskun", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_12", name: "Baranya", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_13", name: "Békés", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_14", name: "Borsod-Abaúj-Zemplén", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_15", name: "Csongrád", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_16", name: "Fejér", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_17", name: "Győr-Moson-Sopron", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_18", name: "Hajdú-Bihar", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_19", name: "Heves", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_20", name: "Jász-Nagykun-Szolnok", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_21", name: "Komárom-Esztergom", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_22", name: "Nógrád", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_23", name: "Pest", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_24", name: "Somogy", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_25", name: "Szabolcs-Szatmár-Bereg", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_26", name: "Tolna", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_27", name: "Vas", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_28", name: "Veszprém", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
    CountyVignette(id: "YEAR_29", name: "Zala", cost: 6660.0, fee: 200.0, vehicleCategory: "CAR"),
]

let HIGHWAY_INFO = HighwayInfo(
    vignettes: VIGNETTES,
    countyVignettes: COUNTY_VIGNETTES
)
