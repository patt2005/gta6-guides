import Foundation

enum VehicleClass: String, CaseIterable, Codable, Identifiable {
    case all = "All"
    case superCar = "Supercars"
    case sports = "Sports Cars"
    case muscle = "Muscle"
    case offroad = "Off-Road & 4x4"
    case motorcycle = "Motorcycles"
    case boat = "Boats & Yachts"
    case aircraft = "Aircraft"
    
    var id: String { rawValue }
    
    var iconName: String {
        switch self {
        case .all: return "car.2.fill"
        case .superCar: return "bolt.car.fill"
        case .sports: return "car.side.fill"
        case .muscle: return "car.fill"
        case .offroad: return "mountain.2.fill"
        case .motorcycle: return "bicycle"
        case .boat: return "ferry.fill"
        case .aircraft: return "airplane"
        }
    }
}

struct Vehicle: Identifiable, Codable {
    let id: UUID
    let name: String
    let manufacturer: String
    let vehicleClass: VehicleClass
    let topSpeedMph: Double
    let acceleration: Double // 0.0 to 1.0
    let braking: Double // 0.0 to 1.0
    let handling: Double // 0.0 to 1.0
    let armor: Double // 0.0 to 1.0
    let price: Int // in-game dollars (0 if stolen only)
    let seats: Int
    let drivetrain: String // RWD, AWD, FWD
    let spawnLocations: [String]
    let description: String
    let imageUrl: String
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        manufacturer: String,
        vehicleClass: VehicleClass,
        topSpeedMph: Double,
        acceleration: Double,
        braking: Double,
        handling: Double,
        armor: Double,
        price: Int,
        seats: Int = 2,
        drivetrain: String = "RWD",
        spawnLocations: [String],
        description: String,
        imageUrl: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.name = name
        self.manufacturer = manufacturer
        self.vehicleClass = vehicleClass
        self.topSpeedMph = topSpeedMph
        self.acceleration = acceleration
        self.braking = braking
        self.handling = handling
        self.armor = armor
        self.price = price
        self.seats = seats
        self.drivetrain = drivetrain
        self.spawnLocations = spawnLocations
        self.description = description
        self.imageUrl = imageUrl
        self.isFavorite = isFavorite
    }
    
    var overallRating: Double {
        (acceleration + braking + handling + armor + (topSpeedMph / 200.0)) / 5.0
    }
}
