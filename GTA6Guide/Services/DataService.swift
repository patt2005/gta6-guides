import Foundation
import Combine

class DataService {
    static let shared = DataService()
    
    private let guidesKey = "gta6_guides_v2"
    private let pinsKey = "gta6_pins_v2"
    private let cheatsKey = "gta6_cheats_v2"
    private let vehiclesKey = "gta6_vehicles_v2"
    private let weaponsKey = "gta6_weapons_v2"
    private let triviaHighScoreKey = "gta6_trivia_high_score"
    
    // MARK: - Guides
    
    func fetchGuides() -> [Guide] {
        if let data = UserDefaults.standard.data(forKey: guidesKey),
           let decoded = try? JSONDecoder().decode([Guide].self, from: data),
           !decoded.isEmpty {
            return decoded
        }
        let initial = createInitialGuides()
        saveGuides(initial)
        return initial
    }
    
    func saveGuides(_ guides: [Guide]) {
        if let encoded = try? JSONEncoder().encode(guides) {
            UserDefaults.standard.set(encoded, forKey: guidesKey)
        }
    }
    
    // MARK: - Cheat Codes
    
    func fetchCheatCodes() -> [CheatCode] {
        if let data = UserDefaults.standard.data(forKey: cheatsKey),
           let decoded = try? JSONDecoder().decode([CheatCode].self, from: data),
           !decoded.isEmpty {
            return decoded
        }
        let initial = createInitialCheatCodes()
        saveCheatCodes(initial)
        return initial
    }
    
    func saveCheatCodes(_ cheats: [CheatCode]) {
        if let encoded = try? JSONEncoder().encode(cheats) {
            UserDefaults.standard.set(encoded, forKey: cheatsKey)
        }
    }
    
    // MARK: - Vehicles
    
    func fetchVehicles() -> [Vehicle] {
        if let data = UserDefaults.standard.data(forKey: vehiclesKey),
           let decoded = try? JSONDecoder().decode([Vehicle].self, from: data),
           !decoded.isEmpty {
            return decoded
        }
        let initial = createInitialVehicles()
        saveVehicles(initial)
        return initial
    }
    
    func saveVehicles(_ vehicles: [Vehicle]) {
        if let encoded = try? JSONEncoder().encode(vehicles) {
            UserDefaults.standard.set(encoded, forKey: vehiclesKey)
        }
    }
    
    // MARK: - Weapons
    
    func fetchWeapons() -> [Weapon] {
        if let data = UserDefaults.standard.data(forKey: weaponsKey),
           let decoded = try? JSONDecoder().decode([Weapon].self, from: data),
           !decoded.isEmpty {
            return decoded
        }
        let initial = createInitialWeapons()
        saveWeapons(initial)
        return initial
    }
    
    func saveWeapons(_ weapons: [Weapon]) {
        if let encoded = try? JSONEncoder().encode(weapons) {
            UserDefaults.standard.set(encoded, forKey: weaponsKey)
        }
    }
    
    // MARK: - Map Pins
    
    func fetchMapPins() -> [MapPin] {
        if let data = UserDefaults.standard.data(forKey: pinsKey),
           let decoded = try? JSONDecoder().decode([MapPin].self, from: data),
           !decoded.isEmpty {
            return decoded
        }
        let initial = createInitialPins()
        saveMapPins(initial)
        return initial
    }
    
    func saveMapPins(_ pins: [MapPin]) {
        if let encoded = try? JSONEncoder().encode(pins) {
            UserDefaults.standard.set(encoded, forKey: pinsKey)
        }
    }
    
    // MARK: - Characters
    
    func fetchCharacters() -> [Character] {
        return [
            Character(
                name: "Lucia Caminos",
                role: "Protagonist",
                faction: "Independent Crime Duo",
                description: "A cunning and ambitious criminal navigating the neon-soaked underworld of Vice City following her release from prison.",
                backstory: "Lucia grew up in the harsh neighborhoods of Southern Leonida. Skilled in electronic security bypasses, getaway driving, and precision firearms, she teams up with Jason to pull off high-risk, high-reward heists across the state.",
                abilities: ["Tactical Focus", "Security Bypass", "Precision Evasion"],
                preferredWeapons: ["Combat Pistol", "Special Carbine", "Compact SMG"],
                signatureVehicle: "Grotti Turismo Classic",
                stats: ["Stamina": 0.85, "Shooting": 0.80, "Driving": 0.95, "Stealth": 0.90, "Strength": 0.70],
                imageName: "lucia",
                imageUrl: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800"
            ),
            Character(
                name: "Jason Duval",
                role: "Protagonist",
                faction: "Independent Crime Duo",
                description: "A former military contractor and small-town drifter caught up in a high-stakes life of crime with Lucia.",
                backstory: "Jason brings tactical military discipline and mechanical expertise to the duo. Calm under pressure and lethal in combat, he balances Lucia's impulsive ambitions with pragmatic strategic planning.",
                abilities: ["Adrenaline Surge", "Heavy Weapons Mastery", "Silent Takedown"],
                preferredWeapons: ["Pump Shotgun", "Heavy Sniper", "Assault Rifle"],
                signatureVehicle: "Bravado Gauntlet Hellfire",
                stats: ["Stamina": 0.90, "Shooting": 0.95, "Driving": 0.75, "Stealth": 0.70, "Strength": 0.92],
                imageName: "jason",
                imageUrl: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=800"
            ),
            Character(
                name: "Stefanie",
                role: "Counselor / Insider Contact",
                faction: "Leonida State Correctional Facility",
                description: "Lucia's state-assigned parole counselor who knows far more about the local power players than she lets on.",
                backstory: "A sharp observer of human behavior who acts as an early game informant and connection hub across Vice City.",
                abilities: ["Legal Loopholes", "Intel Gathering"],
                preferredWeapons: ["Concealed Pistol"],
                signatureVehicle: "Albany Washington",
                stats: ["Stamina": 0.60, "Shooting": 0.40, "Driving": 0.65, "Stealth": 0.85, "Strength": 0.50],
                imageName: "banner",
                imageUrl: "https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=800"
            ),
            Character(
                name: "Raul Salazar",
                role: "Underworld Fixer & Arms Dealer",
                faction: "Port Gellhorn Syndicate",
                description: "A veteran black-market importer who controls illicit shipments moving through Port Gellhorn and the Keys.",
                backstory: "Raul provides the crew with advanced military equipment, untraceable getaway vehicles, and high-value heist intel.",
                abilities: ["Black Market Logistics", "Heavy Ordinance"],
                preferredWeapons: ["Heavy Revolver", "Micro SMG"],
                signatureVehicle: "Bravado Bison 4x4",
                stats: ["Stamina": 0.70, "Shooting": 0.88, "Driving": 0.80, "Stealth": 0.60, "Strength": 0.85],
                imageName: "banner",
                imageUrl: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=800"
            )
        ]
    }
    
    // MARK: - News
    
    func fetchNews() -> [NewsItem] {
        return [
            NewsItem(
                title: "Rockstar Confirms Vice City & Leonida Map Details",
                category: "Official News",
                summary: "Rockstar reveals unprecedented world density, dynamic wildlife, and evolving ocean physics across Leonida State.",
                content: "Grand Theft Auto VI pushes the boundaries of open-world simulation. Featuring Vice City, the Gator Keys, Port Gellhorn, and sprawling wetlands, the game introduces real-time storm surges, photorealistic water physics, and an interactive population with individual daily schedules.",
                imageUrl: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
                source: "Rockstar Games NewsWire",
                readTimeMinutes: 4
            ),
            NewsItem(
                title: "Next-Gen Heist Mechanics & Dual-Protagonist Dynamics",
                category: "Gameplay Deep Dive",
                summary: "A breakdown of the seamless character switching, synchronized tactical entries, and adaptive crew management.",
                content: "Players can switch between Lucia and Jason on the fly during freeroam and tactical missions. The new dynamic heist system allows multiple breach points, silent hacking, distraction setups, and branching escape routes that react to police escalation.",
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                source: "Vice City Chronicle",
                readTimeMinutes: 5
            ),
            NewsItem(
                title: "Vehicle Customization & Underground Street Racing Scene",
                category: "Features",
                summary: "Over 200 drivable vehicles featuring hyper-realistic engine acoustics, tire telemetry, and deep tuning options.",
                content: "From lowriders on Ocean Drive to swamp hovercrafts in the Everglades, GTA 6 expands vehicle customization with performance tuning, vinyl wraps, neon underglow, air suspension, and illegal midnight drag racing circuits.",
                imageUrl: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800",
                source: "Auto Sound Magazine",
                readTimeMinutes: 3
            )
        ]
    }
    
    // MARK: - Trivia Questions
    
    func fetchTriviaQuestions() -> [TriviaQuestion] {
        return [
            TriviaQuestion(
                question: "What is the name of the fictional state where GTA 6 takes place?",
                options: ["San Andreas", "Leonida", "Liberty State", "Alderney"],
                correctOptionIndex: 1,
                explanation: "GTA 6 is set in the state of Leonida, Rockstar's fictional version of Florida that includes Vice City and surrounding regions."
            ),
            TriviaQuestion(
                question: "Who are the two confirmed protagonists of GTA 6?",
                options: ["Tommy & Claude", "Lucia & Jason", "Michael & Franklin", "CJ & Sweet"],
                correctOptionIndex: 1,
                explanation: "Lucia and Jason are the dynamic duo at the center of Grand Theft Auto VI."
            ),
            TriviaQuestion(
                question: "Which iconic real-world Florida landmark group is mirrored by 'The Keys' in Leonida?",
                options: ["The Florida Keys", "Key West Everglades", "Miami Bay", "Biscayne Islands"],
                correctOptionIndex: 0,
                explanation: "The Gator Keys and surrounding archipelagos are inspired directly by the real-world Florida Keys."
            ),
            TriviaQuestion(
                question: "What song was featured in the record-breaking first GTA 6 trailer?",
                options: ["Blinding Lights - The Weeknd", "Love Is A Long Road - Tom Petty", "Out of Touch - Hall & Oates", "Midnight City - M83"],
                correctOptionIndex: 1,
                explanation: "'Love Is A Long Road' by Florida legend Tom Petty was the official soundtrack for Trailer 1."
            ),
            TriviaQuestion(
                question: "What key mechanic allows players to alternate control between characters during free play?",
                options: ["Character Wheel Switch", "Instant Tag-Team", "Split Screen Mode", "Companion AI Call"],
                correctOptionIndex: 0,
                explanation: "The seamless character switch allows real-time switching between Lucia and Jason on the fly."
            )
        ]
    }
    
    // MARK: - Initial Guides Generator
    
    private func createInitialGuides() -> [Guide] {
        return [
            Guide(
                title: "Mastering the Lucia & Jason Duo Dynamic",
                category: .missions,
                difficulty: .intermediate,
                summary: "How to effectively swap between characters during combat, heists, and free-roam to maximize tactical advantage.",
                content: "GTA 6 introduces an evolved dual-protagonist mechanic. Lucia specializes in agility, security hacking, and rapid getaway driving, while Jason excels in heavy firearms, physical strength, and tactical suppression. Learn how to position one character on sniper overwatch while the other breaches interior rooms.",
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                readingTime: 6,
                rewards: ["Synchronized Strike Trophies", "$50,000 Duo Bonus", "Max Team Chemistry"],
                requirements: ["Complete Chapter 1 Intro", "Unlock Dual Inventory Bag"],
                steps: [
                    GuideStep(stepNumber: 1, title: "Positioning Jason on High Ground", instruction: "Before initiating an assault, move Jason to an elevated vantage point with a sniper or DMR.", tip: "Use high ground to tag enemy guards before breaching."),
                    GuideStep(stepNumber: 2, title: "Initiate Lucia's Electronic Breach", instruction: "Switch to Lucia and use her hacking device to disable security cameras and unlock magnetic door latches.", tip: "Disabling cameras prevents instant 3-star police alerts."),
                    GuideStep(stepNumber: 3, title: "Execute Coordinated Takedown", instruction: "Issue the strike command to eliminate both sentries simultaneously without sounding alarms."),
                    GuideStep(stepNumber: 4, title: "Securing the Vault Take", instruction: "Have Lucia bag the cash and high-value bearer bonds while Jason suppresses incoming security reinforcements.", tip: "Keep Lucia's bag weight balanced to avoid mobility penalties.")
                ],
                tags: ["Protagonists", "Combat", "Heists", "Tactics"]
            ),
            Guide(
                title: "Ultimate Real Estate & Money Making Empire",
                category: .money,
                difficulty: .advanced,
                summary: "Step-by-step strategy to turn small convenience store robberies into a multi-million dollar Leonida business syndicate.",
                content: "Passive income is king in Leonida. By purchasing legit front businesses across Vice City—including luxury nightclubs, chop shops, boat marinas, and pawn franchises—you can launder heist earnings, unlock exclusive safehouse stash houses, and generate recurring weekly revenue.",
                imageUrl: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
                readingTime: 8,
                rewards: ["$250,000 Weekly Passive Cash", "Ocean View Penthouse", "VIP Club Access"],
                requirements: ["$500,000 Starting Capital", "Finish Mission: 'Clean Money'"],
                steps: [
                    GuideStep(stepNumber: 1, title: "Acquire the Ocean Beach Chop Shop", instruction: "Purchase the initial salvage yard in Ocean Beach for $180,000 to enable vehicle stripping operations."),
                    GuideStep(stepNumber: 2, title: "Deliver High-Priority Exotic Cars", instruction: "Source and deliver the 10 listed exotic sports cars from Downtown Vice City.", tip: "Use an enclosed flatbed hauler to avoid police tracking."),
                    GuideStep(stepNumber: 3, title: "Invest in Malibu Strip Club Shares", instruction: "Purchase a 40% equity stake in the Malibu Club to open up the VIP laundering office."),
                    GuideStep(stepNumber: 4, title: "Automate Supply Runs", instruction: "Hire reliable managers to keep nightclub stock full and cash generation running 24/7.")
                ],
                tags: ["Money", "Real Estate", "Businesses", "Passive Income"]
            ),
            Guide(
                title: "All 50 Neon Signs Collectibles Walkthrough",
                category: .collectibles,
                difficulty: .beginner,
                summary: "Complete interactive guide to locating and photographing all 50 vintage neon signs hidden across Vice City rooftops.",
                content: "Vice City is famous for its iconic art-deco neon signage. Hidden across rooftops, motel facades, and boardwalk promenades are 50 collectible neon signs from classic 80s establishments. Capturing high-resolution photos of all 50 unlocks the retro Vice City Hawaiian Shirt outfit and a rare custom Cheetah muscle car.",
                imageUrl: "https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=800",
                readingTime: 10,
                rewards: ["Retro Hawaiian Shirt Outfit", "Vintage Cheetah Sports Car", "100% Collectible Trophy"],
                requirements: ["In-Game Smartphone Camera", "Helicopter or Grapple Access"],
                steps: [
                    GuideStep(stepNumber: 1, title: "Ocean Drive Motel Neon Star", instruction: "Located directly atop the roof of the Ocean View Hotel on Ocean Drive. Photograph between 21:00 and 04:00.", tip: "Signs only register when fully illuminated at night."),
                    GuideStep(stepNumber: 2, title: "Washington Beach Flamingo Sign", instruction: "Found on the back terrace of the Flamingo Resort overlooking the canal."),
                    GuideStep(stepNumber: 3, title: "Downtown Vice City Palms Sign", instruction: "Perched atop the Downtown Banking Plaza antenna mast. Requires rooftop parachute jump."),
                    GuideStep(stepNumber: 4, title: "Little Haiti Rooster Sign", instruction: "Affixed to the side of the vintage poultry warehouse near the railway bridge.")
                ],
                tags: ["Collectibles", "Vice City", "Rooftops", "Unlockables"]
            ),
            Guide(
                title: "Top 5 Fastest Supercars & Tuning Guide",
                category: .vehicles,
                difficulty: .intermediate,
                summary: "Benchmark test results, top speeds, turbo upgrade paths, and tuning setups for the fastest cars in Leonida.",
                content: "Speed defines survival in getaway scenarios. We tested every top-tier vehicle across the Leonida Turnpike straightaway. Learn which cars offer the best handling-to-speed ratio and how to tune suspension, gear ratios, and turbo boost for peak race performance.",
                imageUrl: "https://static.wikia.nocookie.net/gta/images/a/a9/ToreroXO-GTAOe-front.png/revision/latest?cb=20220910135805&path-prefix=ru",
                readingTime: 7,
                rewards: ["Top Speed Tuning Presets", "Illegal Drag Race Championship Title"],
                requirements: ["Access to Benny's Original Motor Works", "$150,000 Tuning Budget"],
                steps: [
                    GuideStep(stepNumber: 1, title: "Obtain the Pegassi Torero XO", instruction: "Purchase or liberate the Torero XO from the Starfish Island mansion district."),
                    GuideStep(stepNumber: 2, title: "Stage 4 EMS Engine & Race Transmission", instruction: "Upgrade engine mapping and install short-ratio race gears for explosive acceleration.", tip: "Short gears increase 0-60 acceleration by 22%."),
                    GuideStep(stepNumber: 3, title: "Install Competition Low-Profile Tires", instruction: "Fit soft-compound competition tires for maximum grip on wet asphalt during tropical storms.")
                ],
                tags: ["Supercars", "Tuning", "Racing", "Vehicles"]
            ),
            Guide(
                title: "Leonida Everglades Secret Weapons & Rare Loot",
                category: .secrets,
                difficulty: .advanced,
                summary: "Explore the swamp depths to find sunken drug smuggler airplanes, rare vintage weapons, and hidden stash boxes.",
                content: "Deep inside the murky waterways of the Leonida Everglades lie forgotten relics from decades of coastal smuggling. Armed with an airboat and sonar equipment, players can uncover submerged weapon crates containing unique gold-plated revolvers, high-grade armor, and secret lore audio tapes.",
                imageUrl: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
                readingTime: 9,
                rewards: ["Custom Gold-Plated .44 Revolver", "Heavy Military Body Armor Cache", "$75,000 Smuggler Cash"],
                requirements: ["Airboat Vehicle", "Flashlight / Night Vision Goggles"],
                steps: [
                    GuideStep(stepNumber: 1, title: "Locate the Submerged 1980s Smuggler Twin-Engine", instruction: "Navigate 2.5 miles northwest of the Gator Keys ranger outpost into the mangrove maze."),
                    GuideStep(stepNumber: 2, title: "Evade Swamp Apex Predators", instruction: "Use flare guns or tranquilizer darts to keep aggressive bull alligators at bay while diving.", tip: "Alligators are attracted to engine vibrations; cut your motor before entering the water."),
                    GuideStep(stepNumber: 3, title: "Pry Open the Waterproof Weapons Chest", instruction: "Use a crowbar on the submerged fuselage latch to retrieve the rare firearm and diamonds.")
                ],
                tags: ["Secrets", "Weapons", "Everglades", "Easter Eggs"]
            ),
            Guide(
                title: "Evasion Tactics: Escaping 5-Star Maximum Wanted Levels",
                category: .general,
                difficulty: .master,
                summary: "Proven strategies to outrun SWAT tactical units, police attack helicopters, roadblocks, and spike strips.",
                content: "When your Wanted Level reaches 5 stars, the Leonida State Highway Patrol and NOOSE SWAT deploy aggressive PIT maneuvers, tactical air support with sniper spotlights, and road barricades. Master the art of ditching pursuit vehicles, switching ride identification, and utilizing underground metro tunnels to break line-of-sight.",
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                readingTime: 6,
                rewards: ["'Most Wanted' Platinum Trophy", "Evaded 5-Star Wanted Streak"],
                requirements: ["Fast Armored Vehicle", "Smoke Grenades"],
                steps: [
                    GuideStep(stepNumber: 1, title: "Break Line of Sight from Police Helicopters", instruction: "Immediately head towards multi-level parking garages or the Downtown Metro subway underpass.", tip: "Helicopter spotlights will track you through open sunroofs—stay covered."),
                    GuideStep(stepNumber: 2, title: "Perform Quick Respray / License Plate Swap", instruction: "Pull into a Pay 'n' Spray or underground mod shop while out of police radar cone."),
                    GuideStep(stepNumber: 3, title: "Change Clothing & Appearance", instruction: "Once out of vehicle, swap protagonist outfits or wear hats/sunglasses to slow down pedestrian recognition.")
                ],
                tags: ["Police", "Wanted Level", "Survival", "Combat"]
            )
        ]
    }
    
    // MARK: - Initial Cheat Codes Generator
    
    private func createInitialCheatCodes() -> [CheatCode] {
        return [
            CheatCode(
                title: "Invincibility (God Mode)",
                description: "Completely protects your character from bullets, explosions, falling, and fire damage for 5 minutes.",
                category: .player,
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                ps5Buttons: ["→", "✕", "→", "←", "→", "R1", "→", "←", "✕", "△"],
                xboxButtons: ["→", "A", "→", "←", "→", "RB", "→", "←", "A", "Y"],
                pcInput: "PAINKILLER",
                phoneInput: "1-999-724-654-5537",
                effects: ["Immune to all bullet damage", "Immune to explosions & crash impact", "5-minute duration with on-screen countdown timer"],
                warning: "Disables all Trophies, Achievements, and mission rating medals for current session.",
                tips: "Re-enter the code before the 5-minute timer expires to reset invincibility."
            ),
            CheatCode(
                title: "Max Health & Super Armor",
                description: "Instantly restores 100% Health and full Body Armor, and automatically repairs the vehicle you are currently driving.",
                category: .player,
                imageUrl: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
                ps5Buttons: ["○", "L1", "△", "R2", "✕", "□", "○", "→", "□", "L1", "L1", "L1"],
                xboxButtons: ["B", "LB", "Y", "RT", "A", "X", "B", "→", "X", "LB", "LB", "LB"],
                pcInput: "TURTLE",
                phoneInput: "1-999-887-853",
                effects: ["100% full health bar", "100% full heavy body armor", "Instant vehicle repair with fresh tires"],
                warning: "Disables achievements until game restart.",
                tips: "Use while seated in a damaged getaway car to instantly fix smoke, flat tires, and engine damage."
            ),
            CheatCode(
                title: "Give All Weapons & Max Ammo",
                description: "Spawns a full loadout of weapons with 9,999 rounds of ammunition for every weapon class in your inventory.",
                category: .combat,
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                ps5Buttons: ["△", "R2", "←", "L1", "✕", "→", "△", "↓", "□", "L1", "L1", "L1"],
                xboxButtons: ["Y", "RT", "←", "LB", "A", "→", "Y", "↓", "X", "LB", "LB", "LB"],
                pcInput: "TOOLUP",
                phoneInput: "1-999-866-587",
                effects: ["Combat Pistol, Heavy Shotgun, Carbine Rifle", "Sniper Rifle, RPG Launcher, Grenades", "Maxed out ammunition reserves"],
                warning: "Disables achievements for this session.",
                tips: "Great for testing high-tier weapons early in the storyline."
            ),
            CheatCode(
                title: "Spawn Comet Retro Sports Car",
                description: "Immediately spawns the legendary high-speed Pfister Comet Retro sports car directly in front of you.",
                category: .vehicles,
                imageUrl: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800",
                ps5Buttons: ["R1", "○", "R2", "→", "L1", "L2", "✕", "✕", "□", "R1"],
                xboxButtons: ["RB", "B", "RT", "→", "LB", "LT", "A", "A", "X", "RB"],
                pcInput: "COMET",
                phoneInput: "1-999-266-38",
                effects: ["Spawns Comet Sports Car in mint condition", "Rear-wheel drive high acceleration setup"],
                warning: "Disables trophies.",
                tips: "Ensure you are standing on a clear, wide road so the vehicle has room to spawn safely."
            ),
            CheatCode(
                title: "Spawn Buzzard Attack Chopper",
                description: "Spawns a military attack helicopter equipped with heat-seeking homing rockets and twin miniguns.",
                category: .vehicles,
                imageUrl: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
                ps5Buttons: ["○", "○", "L1", "○", "○", "○", "L1", "L2", "R1", "△", "○", "△"],
                xboxButtons: ["B", "B", "LB", "B", "B", "B", "LB", "LT", "RB", "Y", "B", "Y"],
                pcInput: "BUZZOFF",
                phoneInput: "1-999-289-9633",
                effects: ["Fully armed attack helicopter", "Infinite rockets and minigun ammunition"],
                warning: "Disables achievements.",
                tips: "Spawns best in open parks, beaches, or airport runways."
            ),
            CheatCode(
                title: "Lower Wanted Level (-1 Star)",
                description: "Instantly removes one star from your current police Wanted Level. Enter multiple times to clear entirely.",
                category: .combat,
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                ps5Buttons: ["R1", "R1", "○", "R2", "→", "←", "→", "←", "→", "←"],
                xboxButtons: ["RB", "RB", "B", "RT", "→", "←", "→", "←", "→", "←"],
                pcInput: "LAWYERUP",
                phoneInput: "1-999-529-93787",
                effects: ["Lowers police aggression immediately", "Clears police helicopter pursuit if reduced to zero"],
                warning: "Disables achievements.",
                tips: "Enter this twice when at 2 stars to clear police attention without visiting a Pay 'n' Spray."
            ),
            CheatCode(
                title: "Super Jump",
                description: "Enables your character to leap 10 times higher than normal. Hold the jump button for maximum height.",
                category: .gameplay,
                imageUrl: "https://images.unsplash.com/photo-1509198397868-475647b2a1e5?w=800",
                ps5Buttons: ["←", "←", "△", "△", "→", "→", "←", "→", "□", "R1", "R2"],
                xboxButtons: ["←", "←", "Y", "Y", "→", "→", "←", "→", "X", "RB", "RT"],
                pcInput: "HOPTOIT",
                phoneInput: "1-999-467-8648",
                effects: ["Enormous vertical leap capability", "Jump onto low rooftops and over fences easily"],
                warning: "Disables achievements. Pair with Invincibility to prevent fall damage!",
                tips: "Combine with Moon Gravity cheat for extreme stunt jumps across buildings."
            ),
            CheatCode(
                title: "Moon Gravity (Low Gravity)",
                description: "Reduces gravitational pull across Vice City. Cars float gracefully after jumps and impacts launch objects skyward.",
                category: .world,
                imageUrl: "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800",
                ps5Buttons: ["←", "←", "L1", "R1", "L1", "→", "←", "L1", "←"],
                xboxButtons: ["←", "←", "LB", "RB", "LB", "→", "←", "LB", "←"],
                pcInput: "FLOATER",
                phoneInput: "1-999-356-2837",
                effects: ["Low gravity physics on cars and player", "Epic gliding jumps off ramps and hills"],
                warning: "Disables achievements.",
                tips: "Drive supercars off highway overpasses for unbelievable cinematic drift stunts."
            ),
            CheatCode(
                title: "Change Weather (Cycle Sky & Storms)",
                description: "Cycles through all weather conditions: Sunny, Clear, Cloudy, Smoggy, Overcast, Rainy, Thunderstorm, and Tropical Fog.",
                category: .world,
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                ps5Buttons: ["R2", "✕", "L1", "L1", "L2", "L2", "L2", "□"],
                xboxButtons: ["RT", "A", "LB", "LB", "LT", "LT", "LT", "X"],
                pcInput: "MAKEITRAIN",
                phoneInput: "1-999-625-348-7246",
                effects: ["Instant weather change", "Cycles dynamically to next atmospheric state"],
                warning: "Disables achievements.",
                tips: "Cycle to Thunderstorm at night for the most photorealistic neon puddle reflections in Vice City."
            ),
            CheatCode(
                title: "Explosive Melee Attacks",
                description: "Punches and kicks detonate high-explosive concussive blasts that send enemies and vehicles flying.",
                category: .combat,
                imageUrl: "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                ps5Buttons: ["→", "←", "✕", "△", "R1", "○", "○", "○", "L2"],
                xboxButtons: ["→", "←", "A", "Y", "RB", "B", "B", "B", "LT"],
                pcInput: "HOTHANDS",
                phoneInput: "1-999-468-42637",
                effects: ["Explosive punch and kick impacts", "Instant knockout on NPC combatants"],
                warning: "Disables achievements.",
                tips: "Stand at safe distances when punching cars to avoid blast radius damage."
            )
        ]
    }
    
    // MARK: - Initial Vehicles Generator
    
    private func createInitialVehicles() -> [Vehicle] {
        return [
            Vehicle(
                name: "Grotti Turismo Omaggio",
                manufacturer: "Grotti",
                vehicleClass: .superCar,
                topSpeedMph: 215.0,
                acceleration: 0.96,
                braking: 0.92,
                handling: 0.94,
                armor: 0.50,
                price: 2850000,
                seats: 2,
                drivetrain: "AWD",
                spawnLocations: ["Starfish Island", "Vice City International", "Malibu Club Valet"],
                description: "A pinnacle of Italian engineering boasting twin-turbo V8 hybrid power and active aerodynamic wings.",
                imageUrl: "https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=800"
            ),
            Vehicle(
                name: "Bravado Gauntlet Hellfire",
                manufacturer: "Bravado",
                vehicleClass: .muscle,
                topSpeedMph: 165.0,
                acceleration: 0.90,
                braking: 0.70,
                handling: 0.72,
                armor: 0.65,
                price: 745000,
                seats: 2,
                drivetrain: "RWD",
                spawnLocations: ["Downtown Vice City", "Port Gellhorn Drag Strip", "Little Haiti"],
                description: "A supercharged American muscle monster that delivers thunderous exhaust roar and endless burnout smoke.",
                imageUrl: "https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?w=800"
            ),
            Vehicle(
                name: "Pegassi Torero XO",
                manufacturer: "Pegassi",
                vehicleClass: .superCar,
                topSpeedMph: 218.0,
                acceleration: 0.98,
                braking: 0.90,
                handling: 0.91,
                armor: 0.55,
                price: 2980000,
                seats: 2,
                drivetrain: "AWD",
                spawnLocations: ["Ocean Beach Strip", "South Beach Penthouses"],
                description: "Futuristic wedge styling meets vicious V12 power. Unrivaled acceleration off the starting line.",
                imageUrl: "https://static.wikia.nocookie.net/gta/images/a/a9/ToreroXO-GTAOe-front.png/revision/latest?cb=20220910135805&path-prefix=ru"
            ),
            Vehicle(
                name: "Vapid Sandking 4x4 Marauder",
                manufacturer: "Vapid",
                vehicleClass: .offroad,
                topSpeedMph: 110.0,
                acceleration: 0.65,
                braking: 0.60,
                handling: 0.65,
                armor: 0.90,
                price: 210000,
                seats: 4,
                drivetrain: "4WD",
                spawnLocations: ["Leonida Everglades", "Mud Club Grounds", "Grassrivers Outpost"],
                description: "Built to conquer deep alligator swamps and treacherous mud bogs with massive lifted suspension.",
                imageUrl: "https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?w=800"
            ),
            Vehicle(
                name: "Shitzu Hakuchou Drag",
                manufacturer: "Shitzu",
                vehicleClass: .motorcycle,
                topSpeedMph: 180.0,
                acceleration: 0.99,
                braking: 0.85,
                handling: 0.80,
                armor: 0.30,
                price: 975000,
                seats: 1,
                drivetrain: "RWD",
                spawnLocations: ["Ocean Beach Boardwalk", "Downtown Expressway"],
                description: "Extended swingarm hyperbike built strictly for blistering quarter-mile acceleration and weaving traffic.",
                imageUrl: "https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=800"
            ),
            Vehicle(
                name: "Tropicana Coastal Yacht 65ft",
                manufacturer: "Tropicana",
                vehicleClass: .boat,
                topSpeedMph: 75.0,
                acceleration: 0.60,
                braking: 0.70,
                handling: 0.60,
                armor: 0.85,
                price: 4500000,
                seats: 8,
                drivetrain: "Twin Inboard",
                spawnLocations: ["Vice City Marina", "Gator Keys Docks"],
                description: "Luxury twin-deck high-speed catamaran equipped with helipad, master suite, and radar navigation.",
                imageUrl: "https://cdn.boatinternational.com/convert/files/2024/12/ad1a5a90-b6eb-11ef-97f3-af51ad21a4b0-1-tropicana.jpg/r%5Bwidth%5D=1920/ad1a5a90-b6eb-11ef-97f3-af51ad21a4b0-1-tropicana.jpg"
            )
        ]
    }
    
    // MARK: - Initial Weapons Generator
    
    private func createInitialWeapons() -> [Weapon] {
        return [
            Weapon(
                name: "Special Carbine Mk II",
                category: .assaultRifles,
                damage: 0.82,
                fireRate: 0.88,
                accuracy: 0.90,
                range: 0.85,
                magazineCapacity: 30,
                price: 13500,
                attachments: ["Suppressor", "Extended Mag", "Holographic Scope", "Tactical Grip", "Tracer Rounds"],
                description: "Versatile modular assault rifle offering laser-like accuracy and rapid follow-up shots in all combat situations.",
                imageUrl: "https://images.unsplash.com/photo-1595590424283-b8f17842773f?w=800"
            ),
            Weapon(
                name: "Heavy Combat Pistol .45",
                category: .handguns,
                damage: 0.70,
                fireRate: 0.65,
                accuracy: 0.85,
                range: 0.60,
                magazineCapacity: 12,
                price: 3200,
                attachments: ["Tactical Flashlight", "Suppressor", "Extended Mag", "Match Compensator"],
                description: "Lucia's trusted sidearm chambered in heavy .45 ACP. Delivers decisive stopping power at close-to-mid range.",
                imageUrl: "https://freerangeamerican.us/wp-content/uploads/2023/07/FNX45DvorTwitterLEAD1.jpg"
            ),
            Weapon(
                name: "Heavy Sniper Rifle .50 Cal",
                category: .snipers,
                damage: 0.98,
                fireRate: 0.30,
                accuracy: 0.99,
                range: 0.99,
                magazineCapacity: 6,
                price: 38000,
                attachments: ["Thermal Scope", "Heavy Barrel", "Armor Piercing Magazine", "Muzzle Brake"],
                description: "Anti-material bolt-action sniper capable of neutralizing armored vehicles and targets through engine blocks.",
                imageUrl: "https://cms.interestingengineering.com/wp-content/uploads/2025/10/barrett-m82.jpg"
            ),
            Weapon(
                name: "Assault Shotgun (Drum Mag)",
                category: .shotguns,
                damage: 0.92,
                fireRate: 0.78,
                accuracy: 0.45,
                range: 0.40,
                magazineCapacity: 32,
                price: 18500,
                attachments: ["Drum Magazine", "Grip Handle", "Flashlight", "Choke"],
                description: "Fully automatic 12-gauge close-quarters shredder that clears interior rooms and hallways in seconds.",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBpyEroo-9hvz8k2gDGnD3O9MY-k332j-NY0a-QTLT2L2gJgAYMyezK7I&s=10"
            ),
            Weapon(
                name: "Compact SMG 9mm",
                category: .smgs,
                damage: 0.60,
                fireRate: 0.95,
                accuracy: 0.70,
                range: 0.55,
                magazineCapacity: 30,
                price: 7500,
                attachments: ["Suppressor", "Extended Mag", "Laser Sight"],
                description: "Ultra-compact submachine gun designed for single-handed drive-by shooting and confined spaces.",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCkx4sPdv2DUbASSODn1q0MfY0HNNnVdvyOVn_d_KO1oT2zAC3lypIl3yY&s=10"
            )
        ]
    }
    
    // MARK: - Initial Map Pins Generator
    
    private func createInitialPins() -> [MapPin] {
        return [
            MapPin(title: "Ocean View Hotel Safehouse", subtitle: "Ocean Beach Drive", type: .safehouse, coordinate: CGPoint(x: 0.82, y: 0.62), description: "Lucia and Jason's primary oceanfront safehouse with private vehicle garage and weapon stash.", reward: "Free Vehicle Storage & Stash Access"),
            MapPin(title: "Downtown Ammu-Nation & Gun Range", subtitle: "Downtown Vice City", type: .weapon, coordinate: CGPoint(x: 0.48, y: 0.32), description: "Fully stocked firearms dealership featuring heavy weaponry, body armor, and shooting challenges.", reward: "Shooting Skill +10% upon challenge completion"),
            MapPin(title: "Vice City Port Gellhorn Chop Shop", subtitle: "Port Gellhorn Industrial", type: .garage, coordinate: CGPoint(x: 0.22, y: 0.75), description: "Illegal underground garage used for stripping stolen exotics and vehicle respraying.", reward: "Respray unlocks & Chop Shop Payouts"),
            MapPin(title: "Malibu Nightclub & VIP Lounge", subtitle: "Vice Point Strip", type: .activity, coordinate: CGPoint(x: 0.78, y: 0.45), description: "Famous retro neon nightclub featuring live DJ sets, private VIP booths, and money laundering deals.", reward: "$15,000 Nightly Revenue"),
            MapPin(title: "Sunken Smuggler Plane Easter Egg", subtitle: "Everglades Swamps", type: .secret, coordinate: CGPoint(x: 0.18, y: 0.88), description: "Submerged 1980s drug runner cargo plane holding a locked titanium case.", reward: "$75,000 Cash + Gold Revolver"),
            MapPin(title: "Lighthouse Stunt Jump Ramp", subtitle: "Ocean Beach Southern Tip", type: .stunt, coordinate: CGPoint(x: 0.88, y: 0.82), description: "Massive wooden ramp facing the Atlantic Ocean. Requires 120+ MPH speed for full distance.", reward: "Stunt Jump #1/50 Complete"),
            MapPin(title: "Hidden Neon Sign #01", subtitle: "Washington Beach Motel", type: .collectible, coordinate: CGPoint(x: 0.74, y: 0.58), description: "Vintage animated flamingo neon sign on the 3rd floor rooftop balcony.", reward: "1/50 Collectible Progress"),
            MapPin(title: "Vice City International Airport (VIA)", subtitle: "Southwest District", type: .activity, coordinate: CGPoint(x: 0.35, y: 0.70), description: "Commercial airport with private executive jet hangars and helicopter charter pads.", reward: "Free Stunt Aircraft & Flight School")
        ]
    }
}
