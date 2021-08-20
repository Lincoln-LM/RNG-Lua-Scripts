-- Gen 4/5 pokemon info view/rng script with multi language support
-- Credit to Real.96 and the N.O.O.B./DevonStudios Team for the data tables, many of the rng addresses, and functions for decrypting pokemon in ram
-- edit the "controls" table to change which buttons do what

local BlockA = {1,1,1,1,1,1, 2,2,3,4,3,4, 2,2,3,4,3,4, 2,2,3,4,3,4}
local BlockB = {2,2,3,4,3,4, 1,1,1,1,1,1, 3,4,2,2,4,3, 3,4,2,2,4,3}
local BlockC = {3,4,2,2,4,3, 3,4,2,2,4,3, 1,1,1,1,1,1, 4,3,4,3,2,2}
local BlockD = {4,3,4,3,2,2, 4,3,4,3,2,2, 4,3,4,3,2,2, 1,1,1,1,1,1}

local nature = {"Hardy", "Lonely", "Brave", "Adamant", "Naughty",
    "Bold", "Docile", "Relaxed", "Impish", "Lax",
    "Timid", "Hasty", "Serious", "Jolly", "Naive",
    "Modest", "Mild", "Quiet", "Bashful", "Rash",
    "Calm", "Gentle", "Sassy", "Careful", "Quirky"}

local typeOrder = {"Fighting", "Flying", "Poison", "Ground",
    "Rock", "Bug", "Ghost", "Steel",
    "Fire", "Water", "Grass", "Electric",
    "Psychic", "Ice", "Dragon", "Dark"}

local pokemon =  {"None", "Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard",
    "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree",
    "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate",
    "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash",
    "NidoranF", "Nidorina", "Nidoqueen", "NidoranM", "Nidorino", "Nidoking",
    "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff",
    "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth",
    "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape",
    "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam",
    "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel",
    "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
    "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk",
    "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno",
    "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak",
    "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey",
    "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie",
    "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados",
    "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar",
    "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres",
    "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew",

    "Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion",
    "Totodile", "Croconaw", "Feraligatr", "Sentret", "Furret", "Hoothoot", "Noctowl",
    "Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou", "Lanturn", "Pichu", "Cleffa",
    "Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos", "Bellossom",
    "Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom",
    "Sunkern", "Sunflora", "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking",
    "Misdreavus", "Unown", "Wobbuffet", "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar",
    "Steelix", "Snubbull", "Granbull", "Qwilfish", "Scizor", "Shuckle", "Heracross", "Sneasel",
    "Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub", "Piloswine", "Corsola", "Remoraid", "Octillery",
    "Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom", "Kingdra", "Phanpy", "Donphan",
    "Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid", "Magby", "Miltank",
    "Blissey", "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh", "Celebi",

    "Treecko", "Grovyle", "Sceptile", "Torchic", "Combusken", "Blaziken", "Mudkip", "Marshtomp",
    "Swampert", "Poochyena", "Mightyena", "Zigzagoon", "Linoone", "Wurmple", "Silcoon", "Beautifly",
    "Cascoon", "Dustox", "Lotad", "Lombre", "Ludicolo", "Seedot", "Nuzleaf", "Shiftry",
    "Taillow", "Swellow", "Wingull", "Pelipper", "Ralts", "Kirlia", "Gardevoir", "Surskit",
    "Masquerain", "Shroomish", "Breloom", "Slakoth", "Vigoroth", "Slaking", "Nincada", "Ninjask",
    "Shedinja", "Whismur", "Loudred", "Exploud", "Makuhita", "Hariyama", "Azurill", "Nosepass",
    "Skitty", "Delcatty", "Sableye", "Mawile", "Aron", "Lairon", "Aggron", "Meditite", "Medicham",
    "Electrike", "Manectric", "Plusle", "Minun", "Volbeat", "Illumise", "Roselia", "Gulpin",
    "Swalot", "Carvanha", "Sharpedo", "Wailmer", "Wailord", "Numel", "Camerupt", "Torkoal",
    "Spoink", "Grumpig", "Spinda", "Trapinch", "Vibrava", "Flygon", "Cacnea", "Cacturne", "Swablu",
    "Altaria", "Zangoose", "Seviper", "Lunatone", "Solrock", "Barboach", "Whiscash", "Corphish",
    "Crawdaunt", "Baltoy", "Claydol", "Lileep", "Cradily", "Anorith", "Armaldo", "Feebas",
    "Milotic", "Castform", "Kecleon", "Shuppet", "Banette", "Duskull", "Dusclops", "Tropius",
    "Chimecho", "Absol", "Wynaut", "Snorunt", "Glalie", "Spheal", "Sealeo", "Walrein", "Clamperl",
    "Huntail", "Gorebyss", "Relicanth", "Luvdisc", "Bagon", "Shelgon", "Salamence", "Beldum",
    "Metang", "Metagross", "Regirock", "Regice", "Registeel", "Latias", "Latios", "Kyogre",
    "Groudon", "Rayquaza", "Jirachi", "Deoxys",

    "Turtwig", "Grotle", "Torterra", "Chimchar", "Monferno", "Infernape", "Piplup", "Prinplup",
    "Empoleon", "Starly", "Staravia", "Staraptor", "Bidoof", "Bibarel", "Kricketot", "Kricketune",
    "Shinx", "Luxio", "Luxray", "Budew", "Roserade", "Cranidos", "Rampardos", "Shieldon", "Bastiodon",
    "Burmy", "Wormadam", "Mothim", "Combee", "Vespiquen", "Pachirisu", "Buizel", "Floatzel", "Cherubi",
    "Cherrim", "Shellos", "Gastrodon", "Ambipom", "Drifloon", "Drifblim", "Buneary", "Lopunny",
    "Mismagius", "Honchkrow", "Glameow", "Purugly", "Chingling", "Stunky", "Skuntank", "Bronzor",
    "Bronzong", "Bonsly", "Mime Jr.", "Happiny", "Chatot", "Spiritomb", "Gible", "Gabite", "Garchomp",
    "Munchlax", "Riolu", "Lucario", "Hippopotas", "Hippowdon", "Skorupi", "Drapion", "Croagunk",
    "Toxicroak", "Carnivine", "Finneon", "Lumineon", "Mantyke", "Snover", "Abomasnow", "Weavile",
    "Magnezone", "Lickilicky", "Rhyperior", "Tangrowth", "Electivire", "Magmortar", "Togekiss",
    "Yanmega", "Leafeon", "Glaceon", "Gliscor", "Mamoswine", "Porygon-Z", "Gallade", "Probopass",
    "Dusknoir", "Froslass", "Rotom", "Uxie", "Mesprit", "Azelf", "Dialga", "Palkia", "Heatran",
    "Regigigas", "Giratina", "Cresselia", "Phione", "Manaphy", "Darkrai", "Shaymin", "Arceus",

    "Victini", "Snivy", "Servine", "Serperior", "Tepig", "Pignite", "Emboar", "Oshawott", "Dewott", "Samurott", "Patrat", "Watchog",
    "Lillipup", "Herdier", "Stoutland", "Purrloin", "Liepard", "Pansage", "Simisage", "Pansear", "Simisear", "Panpour", "Simipour",
    "Munna", "Musharna", "Pidove", "Tranquill", "Unfezant", "Blitzle", "Zebstrika", "Roggenrola", "Boldore", "Gigalith", "Woobat",
    "Swoobat", "Drilbur", "Excadrill", "Audino", "Timburr", "Gurdurr", "Conkeldurr", "Tympole", "Palpitoad", "Seismitoad", "Throh",
    "Sawk", "Sewaddle", "Swadloon", "Leavanny", "Venipede", "Whirlipede", "Scolipede", "Cottonee", "Whimsicott", "Petilil",
    "Lilligant", "Basculin", "Sandile", "Krokorok", "Krookodile", "Darumaka", "Darmanitan", "Maractus", "Dwebble", "Crustle",
    "Scraggy", "Scrafty", "Sigilyph", "Yamask", "Cofagrigus", "Tirtouga", "Carracosta", "Archen", "Archeops", "Trubbish",
    "Garbodor", "Zorua", "Zoroark", "Minccino", "Cinccino", "Gothita", "Gothorita", "Gothitelle", "Solosis", "Duosion",
    "Reuniclus", "Ducklett", "Swanna", "Vanillite", "Vanillish", "Vanilluxe", "Deerling", "Sawsbuck", "Emolga", "Karrablast",
    "Escavalier", "Foongus", "Amoonguss", "Frillish", "Jellicent", "Alomomola", "Joltik", "Galvantula", "Ferroseed",
    "Ferrothorn", "Klink", "Klang", "Klinklang", "Tynamo", "Eelektrik", "Eelektross", "Elgyem", "Beheeyem", "Litwick",
    "Lampent", "Chandelure", "Axew", "Fraxure", "Haxorus", "Cubchoo", "Beartic", "Cryogonal", "Shelmet", "Accelgor",
    "Stunfisk", "Mienfoo", "Mienshao", "Druddigon", "Golett", "Golurk", "Pawniard", "Bisharp", "Bouffalant", "Rufflet",
    "Braviary", "Vullaby", "Mandibuzz", "Heatmor", "Durant", "Deino", "Zweilous", "Hydreigon", "Larvesta", "Volcarona", "Cobalion",
    "Terrakion", "Virizion", "Tornadus", "Thundurus", "Reshiram", "Zekrom", "Landorus", "Kyurem", "Keldeo", "Meloetta", "Genesect"}

local abilities = {"None", "Stench", "Drizzle", "Speed Boost", "Battle Armor", "Sturdy", "Damp", "Limber", "Sand Veil", "Static", "Volt Absorb", "Water Absorb", "Oblivious", "Cloud Nine",
    "Compound Eyes", "Insomnia", "Color Change", "Immunity", "Flash Fire", "Shield Dust", "Own Tempo", "Suction Cups", "Intimidate", "Shadow Tag", "Rough Skin", "Wonder Guard", "Levitate",
    "Effect Spore", "Synchronize", "Clear Body", "Natural Cure", "Lightning Rod", "Serene Grace", "Swift Swim", "Chlorophyll", "Illuminate", "Trace", "Huge Power", "Poison Point",
    "Inner Focus", "Magma Armor", "Water Veil", "Magnet Pull", "Soundproof", "Rain Dish", "Sand Stream", "Pressure", "Thick Fat", "Early Bird", "Flame Body", "Run Away", "Keen Eye",
    "Hyper Cutter", "Pickup", "Truant", "Hustle", "Cute Charm", "Plus", "Minus", "Forecast", "Sticky Hold", "Shed Skin", "Guts", "Marvel Scale", "Liquid Ooze", "Overgrow", "Blaze", "Torrent",
    "Swarm", "Rock Head", "Drought", "Arena Trap", "Vital Spirit", "White Smoke", "Pure Power", "Shell Armor", "Air Lock", "Tangled Feet", "Motor Drive", "Rivalry", "Steadfast", "Snow Cloak",
    "Gluttony", "Anger Point", "Unburden", "Heatproof", "Simple", "Dry Skin", "Download", "Iron Fist", "Poison Heal", "Adaptability", "Skill Link", "Hydration", "Solar Power", "Quick Feet",
    "Normalize", "Sniper", "Magic Guard", "No Guard", "Stall", "Technician", "Leaf Guard", "Klutz", "Mold Breaker", "Super Luck", "Aftermath", "Anticipation", "Forewarn", "Unaware", "Tinted Lens",
    "Filter", "Slow Start", "Scrappy", "Storm Drain", "Ice Body", "Solid Rock", "Snow Warning", "Honey Gather", "Frisk", "Reckless", "Multitype", "Flower Gift", "Bad Dreams",

    "Pickpocket", "Sheer Force", "Contrary", "Unnerve", "Defiant", "Defeatist", "Cursed Body", "Healer", "Friend Guard",
    "Weak Armor", "Heavy Metal", "Light Metal", "Multiscale", "Toxic Boost", "Flare Boost", "Harvest", "Telepathy", "Moody",
    "Overcoat", "Poison Touch", "Regenerator", "Big Pecks", "Sand Rush", "Wonder Skin", "Analytic", "Illusion", "Imposter",
    "Infiltrator", "Mummy", "Moxie", "Justified", "Rattled", "Magic Bounce", "Sap Sipper", "Prankster", "Sand Force",
    "Iron Barbs", "Zen Mode", "Victory Star", "Turboblaze", "Teravolt"}

local item = {"None", "Master Ball", "Ultra Ball", "Great Ball", "Poké Ball", "Safari Ball", "Net Ball", "Dive Ball",
    "Nest Ball", "Repeat Ball", "Timer Ball", "Luxury Ball", "Premier Ball", "Dusk Ball", "Heal Ball", "Quick Ball",
    "Cherish Ball", "Potion", "Antidote", "Burn Heal", "Ice Heal", "Awakening", "Parlyz Heal", "Full Restore",
    "Max Potion", "Hyper Potion", "Super Potion", "Full Heal", "Revive", "Max Revive", "Fresh Water", "Soda Pop",
    "Lemonade", "Moomoo Milk", "EnergyPowder", "Energy Root", "Heal Powder", "Revival Herb", "Ether", "Max Ether", "Elixir",
    "Max Elixir", "Lava Cookie", "Berry Juice", "Sacred Ash", "HP Up", "Protein", "Iron", "Carbos", "Calcium", "Rare Candy",
    "PP Up", "Zinc", "PP Max", "Old Gateau", "Guard Spec.", "Dire Hit", "X Attack", "X Defend", "X Speed", "X Accuracy", "X Special",
    "X Sp. Def", "Poké Doll", "Fluffy Tail", "Blue Flute", "Yellow Flute", "Red Flute", "Black Flute", "White Flute", "Shoal Salt",
    "Shoal Shell", "Red Shard", "Blue Shard", "Yellow Shard", "Green Shard", "Super Repel", "Max Repel", "Escape Rope", "Repel", "Sun Stone",
    "Moon Stone", "Fire Stone", "Thunder Stone", "Water Stone", "Leaf Stone", "TinyMushroom", "Big Mushroom", "Pearl", "Big Pearl",
    "Stardust", "Star Piece", "Nugget", "Heart Scale", "Honey", "Growth Mulch", "Damp Mulch", "Stable Mulch", "Gooey Mulch",
    "Root Fossil", "Claw Fossil", "Helix Fossil", "Dome Fossil", "Old Amber", "Armor Fossil", "Skull Fossil", "Rare Bone", "Shiny Stone",
    "Dusk Stone", "Dawn Stone", "Oval Stone", "Odd Keystone", "Griseous Orb", "unknown", "unknown", "unknown", "Douse Drive",
    "Shock Drive", "Burn Drive", "Chill Drive",

    "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown", "unknown",
    "unknown", "unknown", "unknown", "unknown",

    "Sweet Heart", "Adamant Orb", "Lustrous Orb", "Greet Mail",
    "Favored Mail", "RSVP Mail", "Thanks Mail", "Inquiry Mail", "Like Mail", "Reply Mail", "BridgeMail S", "BridgeMail D", "BridgeMail T",
    "BridgeMail V", "BridgeMail M", "Cheri Berry", "Chesto Berry", "Pecha Berry", "Rawst Berry", "Aspear Berry", "Leppa Berry",
    "Oran Berry", "Persim Berry", "Lum Berry", "Sitrus Berry", "Figy Berry", "Wiki Berry", "Mago Berry", "Aguav Berry", "Iapapa Berry",
    "Razz Berry", "Bluk Berry", "Nanab Berry", "Wepear Berry", "Pinap Berry", "Pomeg Berry", "Kelpsy Berry", "Qualot Berry",
    "Hondew Berry", "Grepa Berry", "Tamato Berry", "Cornn Berry", "Magost Berry", "Rabuta Berry", "Nomel Berry", "Spelon Berry",
    "Pamtre Berry", "Watmel Berry", "Durin Berry", "Belue Berry", "Occa Berry", "Passho Berry", "Wacan Berry", "Rindo Berry",
    "Yache Berry", "Chople Berry", "Kebia Berry", "Shuca Berry", "Coba Berry", "Payapa Berry", "Tanga Berry", "Charti Berry",
    "Kasib Berry", "Haban Berry", "Colbur Berry", "Babiri Berry", "Chilan Berry", "Liechi Berry", "Ganlon Berry", "Salac Berry",
    "Petaya Berry", "Apicot Berry", "Lansat Berry", "Starf Berry", "Enigma Berry", "Micle Berry", "Custap Berry", "Jaboca Berry",
    "Rowap Berry", "BrightPowder", "White Herb", "Macho Brace", "Exp. Share", "Quick Claw", "Soothe Bell", "Mental Herb", "Choice Band",
    "King's Rock", "SilverPowder", "Amulet Coin", "Cleanse Tag", "Soul Dew", "DeepSeaTooth", "DeepSeaScale", "Smoke Ball", "Everstone",
    "Focus Band", "Lucky Egg", "Scope Lens", "Metal Coat", "Leftovers", "Dragon Scale", "Light Ball", "Soft Sand", "Hard Stone", "Miracle Seed",
    "BlackGlasses", "Black Belt", "Magnet", "Mystic Water", "Sharp Beak", "Poison Barb", "NeverMeltIce", "Spell Tag", "TwistedSpoon",
    "Charcoal", "Dragon Fang", "Silk Scarf", "Up-Grade", "Shell Bell", "Sea Incense", "Lax Incense", "Lucky Punch", "Metal Powder",
    "Thick Club", "Stick", "Red Scarf", "Blue Scarf", "Pink Scarf", "Green Scarf", "Yellow Scarf", "Wide Lens", "Muscle Band", "Wise Glasses",
    "Expert Belt", "Light Clay", "Life Orb", "Power Herb", "Toxic Orb", "Flame Orb", "Quick Powder", "Focus Sash", "Zoom Lens", "Metronome",
    "Iron Ball", "Lagging Tail", "Destiny Knot", "Black Sludge", "Icy Rock", "Smooth Rock", "Heat Rock", "Damp Rock", "Grip Claw",
    "Choice Scarf", "Sticky Barb", "Power Bracer", "Power Belt", "Power Lens", "Power Band", "Power Anklet", "Power Weight", "Shed Shell",
    "Big Root", "Choice Specs", "Flame Plate", "Splash Plate", "Zap Plate", "Meadow Plate", "Icicle Plate", "Fist Plate", "Toxic Plate",
    "Earth Plate", "Sky Plate", "Mind Plate", "Insect Plate", "Stone Plate", "Spooky Plate", "Draco Plate", "Dread Plate", "Iron Plate",
    "Odd Incense", "Rock Incense", "Full Incense", "Wave Incense", "Rose Incense", "Luck Incense", "Pure Incense", "Protector", "Electirizer",
    "Magmarizer", "Dubious Disc", "Reaper Cloth", "Razor Claw", "Razor Fang", "TM01", "TM02", "TM03", "TM04", "TM05", "TM06", "TM07",
    "TM08", "TM09", "TM10", "TM11", "TM12", "TM13", "TM14", "TM15", "TM16", "TM17", "TM18", "TM19", "TM20", "TM21", "TM22", "TM23", "TM24",
    "TM25", "TM26", "TM27", "TM28", "TM29", "TM30", "TM31", "TM32", "TM33", "TM34", "TM35", "TM36", "TM37", "TM38", "TM39", "TM40", "TM41",
    "TM42", "TM43", "TM44", "TM45", "TM46", "TM47", "TM48", "TM49", "TM50", "TM51", "TM52", "TM53", "TM54", "TM55", "TM56", "TM57", "TM58",
    "TM59", "TM60", "TM61", "TM62", "TM63", "TM64", "TM65", "TM66", "TM67", "TM68", "TM69", "TM70", "TM71", "TM72", "TM73", "TM74", "TM75",
    "TM76", "TM77", "TM78", "TM79", "TM80", "TM81", "TM82", "TM83", "TM84", "TM85", "TM86", "TM87", "TM88", "TM89", "TM90", "TM91", "TM92",
    "HM01", "HM02", "HM03", "HM04", "HM05", "HM06", "unknown", "unknown", "Explorer Kit", "Loot Sack", "Rule Book", "Poké Radar", "Point Card",
    "Journal", "Seal Case", "Fashion Case", "Seal Bag", "Pal Pad", "Works Key", "Old Charm", "Galactic Key", "Red Chain", "Town Map",
    "Vs. Seeker", "Coin Case", "Old Rod", "Good Rod", "Super Rod", "Sprayduck", "Poffin Case", "Bicycle", "Suite Key", "Oak's Letter",
    "Lunar Wing", "Member Card", "Azure Flute", "S.S. Ticket", "Contest Pass", "Magma Stone", "Parcel", "Coupon 1", "Coupon 2", "Coupon 3",
    "Storage Key", "SecretPotion", "Vs. Recorder", "Gracidea", "Secret Key", "Apricorn Box", "Unown Report", "Berry Pots", "Dowsing MCHN",
    "Blue Card", "SlowpokeTail", "Clear Bell", "Card Key", "Basement Key", "SquirtBottle", "Red Scale", "Lost Item", "Pass", "Machine Part",
    "Silver Wing", "Rainbow Wing", "Mystery Egg", "Red Apricorn", "Ylw Apricorn", "Blu Apricorn", "Grn Apricorn", "Pnk Apricorn", "Wht Apricorn",
    "Blk Apricorn", "Fast Ball", "Level Ball", "Lure Ball", "Heavy Ball", "Love Ball", "Friend Ball", "Moon Ball", "Sport Ball", "Park Ball", "Photo Album",
    "GB Sounds", "Tidal Bell", "RageCandyBar", "Data Card 01", "Data Card 02", "Data Card 03", "Data Card 04", "Data Card 05", "Data Card 06", "Data Card 07",
    "Data Card 08", "Data Card 09", "Data Card 10", "Data Card 11", "Data Card 12", "Data Card 13", "Data Card 14", "Data Card 15", "Data Card 16", "Data Card 17",
    "Data Card 18", "Data Card 19", "Data Card 20", "Data Card 21", "Data Card 22", "Data Card 23", "Data Card 24", "Data Card 25", "Data Card 26", "Data Card 27",
    "Jade Orb", "Lock Capsule", "Red Orb", "Blue Orb", "Enigma Stone", "Prism Scale", "Eviolite", "Float Stone", "Rocky Helmet", "Air Balloon", "Red Card",
    "Ring Target", "Binding Band", "Absorb Bulb", "Cell Battery", "Eject Button", "Fire Gem", "Water Gem", "Electric Gem", "Grass Gem", "Ice Gem", "Fighting Gem",
    "Poison Gem", "Ground Gem", "Flying Gem", "Psychic Gem", "Bug Gem", "Rock Gem", "Ghost Gem", "Dragon Gem", "Dark Gem", "Steel Gem", "Normal Gem", "Health Wing",
    "Muscle Wing", "Resist Wing", "Genius Wing", "Clever Wing", "Swift Wing", "Pretty Wing", "Cover Fossil", "Plume Fossil", "Liberty Pass", "Pass Orb", "Dream Ball",
    "Poké Toy", "Prop Case", "Dragon Skull", "BalmMushroom", "Big Nugget", "Pearl String", "Comet Shard", "Relic Copper", "Relic Silver", "Relic Gold", "Relic Vase",
    "Relic Band", "Relic Statue", "Relic Crown", "Casteliacone", "Dire Hit 2", "X Speed 2", "X Special 2", "X Sp. Def 2", "X Defend 2", "X Attack 2", "X Accuracy 2",
    "X Speed 3", "X Special 3", "X Sp. Def 3", "X Defend 3", "X Attack 3", "X Accuracy 3", "X Speed 6", "X Special 6", "X Sp. Def 6", "X Defend 6", "X Attack 6", "X Accuracy 6",
    "Ability Urge", "Item Drop", "Item Urge", "Reset Urge", "Dire Hit 3", "Light Stone", "Dark Stone", "TM93", "TM94", "TM95", "Xtransceiver", "God Stone", "Gram 1",
    "Gram 2", "Gram 3", "Xtransceiver", "Medal Box", "DNA Splicers", "DNA Splicers", "Permit", "Oval Charm", "Shiny Charm", "Plasma Card", "Grubby Hanky", "Colress MCHN",
    "Dropped Item", "Dropped Item", "Reveal Glass"}

local moveName ={"--", "Pound", "Karate Chop", "Double Slap", "Comet Punch", "Mega Punch", "Pay Day", "Fire Punch", "Ice Punch", "Thunder Punch",
    "Scratch", "Vice Grip", "Guillotine", "Razor Wind", "Swords Dance", "Cut", "Gust", "Wing Attack", "Whirlwind", "Fly",
    "Bind", "Slam", "Vine Whip", "Stomp", "Double Kick", "Mega Kick", "Jump Kick", "Rolling Kick", "Sand Attack", "Headbutt",
    "Horn Attack", "Fury Attack", "Horn Drill", "Tackle", "Body Slam", "Wrap", "Take Down", "Thrash", "Double-Edge",
    "Tail Whip", "Poison Sting", "Twineedle", "Pin Missile", "Leer", "Bite", "Growl", "Roar", "Sing", "Supersonic", "Sonic Boom",
    "Disable", "Acid", "Ember", "Flamethrower", "Mist", "Water Gun", "Hydro Pump", "Surf", "Ice Beam", "Blizzard", "Psybeam",
    "Bubble Beam", "Aurora Beam", "Hyper Beam", "Peck", "Drill Peck", "Submission", "Low Kick", "Counter", "Seismic Toss",
    "Strength", "Absorb", "Mega Drain", "Leech Seed", "Growth", "Razor Leaf", "Solar Beam", "Poison Powder", "Stun Spore",
    "Sleep Powder", "Petal Dance", "String Shot", "Dragon Rage", "Fire Spin", "Thunder Shock", "Thunderbolt", "Thunder Wave",
    "Thunder", "Rock Throw", "Earthquake", "Fissure", "Dig", "Toxic", "Confusion", "Psychic", "Hypnosis", "Meditate",
    "Agility", "Quick Attack", "Rage", "Teleport", "Night Shade", "Mimic", "Screech", "Double Team", "Recover", "Harden",
    "Minimize", "Smokescreen", "Confuse Ray", "Withdraw", "Defense Curl", "Barrier", "Light Screen", "Haze", "Reflect",
    "Focus Energy", "Bide", "Metronome", "Mirror Move", "Self-Destruct", "Egg Bomb", "Lick", "Smog", "Sludge", "Bone Club",
    "Fire Blast", "Waterfall", "Clamp", "Swift", "Skull Bash", "Spike Cannon", "Constrict", "Amnesia", "Kinesis", "Soft-Boiled",
    "High Jump Kick", "Glare", "Dream Eater", "Poison Gas", "Barrage", "Leech Life", "Lovely Kiss", "Sky Attack", "Transform",
    "Bubble", "Dizzy Punch", "Spore", "Flash", "Psywave", "Splash", "Acid Armor", "Crabhammer", "Explosion", "Fury Swipes",
    "Bonemerang", "Rest", "Rock Slide", "Hyper Fang", "Sharpen", "Conversion", "Tri Attack", "Super Fang", "Slash",
    "Substitute", "Struggle", "Sketch", "Triple Kick", "Thief", "Spider Web", "Mind Reader", "Nightmare", "Flame Wheel",
    "Snore", "Curse", "Flail", "Conversion 2", "Aeroblast", "Cotton Spore", "Reversal", "Spite", "Powder Snow", "Protect",
    "Mach Punch", "Scary Face", "Feint Attack", "Sweet Kiss", "Belly Drum", "Sludge Bomb", "Mud-Slap", "Octazooka", "Spikes",
    "Zap Cannon", "Foresight", "Destiny Bond", "Perish Song", "Icy Wind", "Detect", "Bone Rush", "Lock-On", "Outrage",
    "Sandstorm", "Giga Drain", "Endure", "Charm", "Rollout", "False Swipe", "Swagger", "Milk Drink", "Spark", "Fury Cutter",
    "Steel Wing", "Mean Look", "Attract", "Sleep Talk", "Heal Bell", "Return", "Present", "Frustration", "Safeguard",
    "Pain Split", "Sacred Fire", "Magnitude", "Dynamic Punch", "Megahorn", "Dragon Breath", "Baton Pass", "Encore", "Pursuit",
    "Rapid Spin", "Sweet Scent", "Iron Tail", "Metal Claw", "Vital Throw", "Morning Sun", "Synthesis", "Moonlight", "Hidden Power",
    "Cross Chop", "Twister", "Rain Dance", "Sunny Day", "Crunch", "Mirror Coat", "Psych Up", "Extreme Speed", "Ancient Power",
    "Shadow Ball", "Future Sight", "Rock Smash", "Whirlpool", "Beat Up", "Fake Out", "Uproar", "Stockpile", "Spit Up",
    "Swallow", "Heat Wave", "Hail", "Torment", "Flatter", "Will-O-Wisp", "Memento", "Facade", "Focus Punch", "Smelling Salts",
    "Follow Me", "Nature Power", "Charge", "Taunt", "Helping Hand", "Trick", "Role Play", "Wish", "Assist", "Ingrain",
    "Superpower", "Magic Coat", "Recycle", "Revenge", "Brick Break", "Yawn", "Knock Off", "Endeavor", "Eruption", "Skill Swap",
    "Imprison", "Refresh", "Grudge", "Snatch", "Secret Power", "Dive", "Arm Thrust", "Camouflage", "Tail Glow", "Luster Purge",
    "Mist Ball", "Feather Dance", "Teeter Dance", "Blaze Kick", "Mud Sport", "Ice Ball", "Needle Arm", "Slack Off",
    "Hyper Voice", "Poison Fang", "Crush Claw", "Blast Burn", "Hydro Cannon", "Meteor Mash", "Astonish", "Weather Ball",
    "Aromatherapy", "Fake Tears", "Air Cutter", "Overheat", "Odor Sleuth", "Rock Tomb", "Silver Wind", "Metal Sound",
    "Grass Whistle", "Tickle", "Cosmic Power", "Water Spout", "Signal Beam", "Shadow Punch", "Extrasensory", "Sky Uppercut",
    "Sand Tomb", "Sheer Cold", "Muddy Water", "Bullet Seed", "Aerial Ace", "Icicle Spear", "Iron Defense", "Block", "Howl",
    "Dragon Claw", "Frenzy Plant", "Bulk Up", "Bounce", "Mud Shot", "Poison Tail", "Covet", "Volt Tackle", "Magical Leaf",
    "Water Sport", "Calm Mind", "Leaf Blade", "Dragon Dance", "Rock Blast", "Shock Wave", "Water Pulse", "Doom Desire",
    "Psycho Boost", "Roost", "Gravity", "Miracle Eye", "Wake-Up Slap", "Hammer Arm", "Gyro Ball", "Healing Wish", "Brine",
    "Natural Gift", "Feint", "Pluck", "Tailwind", "Acupressure", "Metal Burst", "U-turn", "Close Combat", "Payback", "Assurance",
    "Embargo", "Fling", "Psycho Shift", "Trump Card", "Heal Block", "Wring Out", "Power Trick", "Gastro Acid", "Lucky Chant",
    "Me First", "Copycat", "Power Swap", "Guard Swap", "Punishment", "Last Resort", "Worry Seed", "Sucker Punch", "Toxic Spikes",
    "Heart Swap", "Aqua Ring", "Magnet Rise", "Flare Blitz", "Force Palm", "Aura Sphere", "Rock Polish", "Poison Jab",
    "Dark Pulse", "Night Slash", "Aqua Tail", "Seed Bomb", "Air Slash", "X-Scissor", "Bug Buzz", "Dragon Pulse", "Dragon Rush",
    "Power Gem", "Drain Punch", "Vacuum Wave", "Focus Blast", "Energy Ball", "Brave Bird", "Earth Power", "Switcheroo",
    "Giga Impact", "Nasty Plot", "Bullet Punch", "Avalanche", "Ice Shard", "Shadow Claw", "Thunder Fang", "Ice Fang", "Fire Fang",
    "Shadow Sneak", "Mud Bomb", "Psycho Cut", "Zen Headbutt", "Mirror Shot", "Flash Cannon", "Rock Climb", "Defog",
    "Trick Room", "Draco Meteor", "Discharge", "Lava Plume", "Leaf Storm", "Power Whip", "Rock Wrecker", "Cross Poison", "Gunk Shot",
    "Iron Head", "Magnet Bomb", "Stone Edge", "Captivate", "Stealth Rock", "Grass Knot", "Chatter", "Judgment", "Bug Bite",
    "Charge Beam", "Wood Hammer", "Aqua Jet", "Attack Order", "Defend Order", "Heal Order", "Head Smash", "Double Hit",
    "Roar of Time", "Spacial Rend", "Lunar Dance", "Crush Grip", "Magma Storm", "Dark Void", "Seed Flare", "Ominous Wind", "Shadow Force",

    "Hone Claws", "Wide Guard", "Guard Split", "Power Split", "Wonder Room", "Psyshock", "Venoshock", "Autotomize", "Rage Powder",
    "Telekinesis", "Magic Room", "Smack Down", "Storm Throw", "Flame Burst", "Sludge Wave", "Quiver Dance", "Heavy Slam",
    "Synchronoise", "Electro Ball", "Soak", "Flame Charge", "Coil", "Low Sweep", "Acid Spray", "Foul Play", "Simple Beam",
    "Entrainment", "After You", "Round", "Echoed Voice", "Chip Away", "Clear Smog", "Stored Power", "Quick Guard", "Ally Switch",
    "Scald", "Shell Smash", "Heal Pulse", "Hex", "Sky Drop", "Shift Gear", "Circle Throw", "Incinerate", "Quash", "Acrobatics",
    "Reflect Type", "Retaliate", "Final Gambit", "Bestow", "Inferno", "Water Pledge", "Fire Pledge", "Grass Pledge",
    "Volt Switch", "Struggle Bug", "Bulldoze", "Frost Breath", "Dragon Tail", "Work Up", "Electroweb", "Wild Charge",
    "Drill Run", "Dual Chop", "Heart Stamp", "Horn Leech", "Sacred Sword", "Razor Shell", "Heat Crash", "Leaf Tornado",
    "Steamroller", "Cotton Guard", "Night Daze", "Psystrike", "Tail Slap", "Hurricane", "Head Charge", "Gear Grind",
    "Searing Shot", "Techno Blast", "Relic Song", "Secret Sword", "Glaciate", "Bolt Strike", "Blue Flare", "Fiery Dance",
    "Freeze Shock", "Ice Burn", "Snarl", "Icicle Crash", "V-create", "Fusion Flare", "Fusion Bolt"}

local view = 1
local views = {"Party", "Enemy", "Enemy 2", "Partner", "Wild", "RNG", "CGEAR"}
-- backspace, tab, enter, shift, control, alt, pause, capslock, escape, space, pageup, pagedown, end, home, left, up, right, down, insert, delete, 0, 1, ..., 9, A, B, ..., Z, numpad0, numpad1, ..., numpad9, numpad*, numpad+, numpad-, numpad., numpad/, F1, F2, ..., F24, numlock, scrolllock, semicolon, plus, comma, minus, period, slash, tilde, leftbracket, backslash, rightbracket, quote
local controls = {"numpad6", "numpad4", "numpad8", "numpad2", "numpad0", "numpad5"}
--                +view      -view      +subview   -subview   hide display switch screen
local sub = 1
local viewmax = 7
local submax = 7
local inp = {}
local prev = {}
local on = 1
local advance = 0
local iadvance = 0
local seed = 0
local initial = 0
local gameint = 1
local gen = 4
local yfix = -185
local game,seed_off,delay_off,mt_off,id_off
local jpn_id_off = 0
local delay = 0
local initSeedHigh = 0
local initSeedLow = 0
local mtSeed = 0
local hitMtSeed = 0
local hitDelay = 0
local hitDate = "01/01/2000\n00:00:00"
local currSeedHigh = 0
local currSeedLow = 0
local tempCurrLow = 0
local ivsFrame = 0
local prevMtSeed = 0
local frame = 0
local initSet = 0

local idsAddr = 0
local tid = 0
local sid = 0

local mac = 0x123456  -- default MAC Address of DeSmuMe
local prng

-- BlockA
local pokemonID = 0
local heldItem = 0
local OTID, OTSID
local friendship_or_steps_to_hatch
local ability
local hpev, atkev, defev, speev, spaev, spdev
local evs = {}

-- BlockB
local move = {}
local movepp = {}
local hpiv, atkiv, defiv, speiv, spaiv, spdiv
local ivspart = {}, ivs
local isEgg = 0
local nat

-- BlockD
local pkrs

local BlockAoff, BlockBoff, BlockCoff, BlockDoff

local bnd,br,bxr,tobit=bit.band,bit.bor,bit.bxor,bit.tobit
local format = string.format
local floor = math.floor
local rshift, lshift=bit.rshift, bit.lshift
local mdword=memory.readdwordunsigned
local mword=memory.readwordunsigned
local mbyte=memory.readbyteunsigned
local box = gui.box
local text = gui.text

-- Detect Game Version and language
local version = mdword(0x02FFFE0C)
local langbyte = mbyte(0x02FFFE0F)

if version == 0x4F425249 then
    game = "B"
    gameint = 4
    gen = 5
elseif version == 0x4F415249 then
    game = "W"
    gameint = 5
    gen = 5
elseif version == 0x4F455249 then
    game = "B2"
    gameint = 6
    gen = 5.5
elseif version == 0x4F445249 then
    game = "W2"
    gameint = 7
    gen = 5.5
end


if version == 0x45414441 or version == 0x45415041 then
    game = "DP"
    gameint = 1
    if langbyte == 0x4A then  -- Check game language
        language = "JPN"
        seed_off = 0x4260
        delay_off = 0x4260
        mt_off = 0x43BC
        jpn_id_off = 0xA
    elseif langbyte == 0x45 then
        language = "USA"
        seed_off = 0x2A00
        delay_off = 0x2A00
        mt_off = 0x2B00
    elseif langbyte == 0x49 then
        language = "ITA"
        seed_off = 0x2AE0
        delay_off = 0x2AE0
        mt_off = 0x2BE0
    elseif langbyte == 0x44 then
        language = "GER"
        seed_off = 0x2B40
        delay_off = 0x2B40
        mt_off = 0x2C40
    elseif langbyte == 0x46 then
        language = "FRE"
        seed_off = 0x2B80
        delay_off = 0x2B80
        mt_off = 0x2C80
    elseif langbyte == 0x53 then
        language = "SPA"
        seed_off = 0x2BA0
        delay_off = 0x2BA0
        mt_off = 0x2CA0
    elseif langbyte == 0x4B then
        language = "KOR"
        seed_off = 0
        delay_off = 0
        mt_off = 0
    end
    if version == 0x45415041 then
        mt_off = mt_off + 0x8
    end
    id_pointer = 0x021C2FC8 + seed_off + jpn_id_off
    id_off = 0x288
    
elseif version == 0x454B5049 or version == 0x45475049 then
    game = "HGSS"
    gameint = 2
    if langbyte == 0x4A then  -- Check game language
        language = "JPN"
        seed_off = 0
        delay_off = 0
        mt_off = 0
    elseif langbyte == 0x45 then
        language = "USA"
        seed_off = 0xAC0
        delay_off = 0xAC0
        mt_off = 0xACC
    elseif langbyte == 0x49 then
        language = "ITA"
        seed_off = 0xA60
        delay_off = 0xA60
        mt_off = 0xA6C
    elseif langbyte == 0x44 then
        language = "GER"
        seed_off = 0xAA0
        delay_off = 0xAA0
        mt_off = 0xAAC
    elseif langbyte == 0x46 then
        language = "FRE"
        seed_off = 0xAE0
        delay_off = 0xAE0
        mt_off = 0xAEC
    elseif langbyte == 0x53 then
        language = "SPA"
        seed_off = 0xAE0
        delay_off = 0xAE0
        mt_off = 0xAEC
    elseif langbyte == 0x4B then
        language = "KOR"
        seed_off = 0x14C0
        delay_off = 0x14C0
        mt_off = 0x14A0
    end
    if version == 0x45475049 then
        if language == "SPA" then
            seed_off = seed_off + 0x20
            delay_off = delay_off + 0x20
            mt_off = mt_off + 0x20
        end
    end
    id_pointer = 0x021D1768 + seed_off
    id_off = 0x84

elseif version == 0x45555043 then
    game = "Pt"
    gameint = 3
    if langbyte == 0x4A then  -- Check game language
        language = "JPN"
        seed_off = 0
        delay_off = 0
        mt_off = 0
    elseif langbyte == 0x45 then
        language = "USA"
        seed_off = 0xC00
        delay_off = 0xC00
        mt_off = 0xC08
    elseif langbyte == 0x49 then
        language = "ITA"
        seed_off = 0xD60
        delay_off = 0xD60
        mt_off = 0xD68
    elseif langbyte == 0x44 then
        language = "GER"
        seed_off = 0xDA0
        delay_off = 0xDA0
        mt_off = 0xDA8
    elseif langbyte == 0x46 then
        language = "FRE"
        seed_off = 0xDE0
        delay_off = 0xDE0
        mt_off = 0xDE8
    elseif langbyte == 0x53 then
        language = "SPA"
        seed_off = 0xE00
        delay_off = 0xE00
        mt_off = 0xE08
    elseif langbyte == 0x4B then
        language = "KOR"
        seed_off = 0x1B00
        delay_off = 0x1B00
        mt_off = 0x1AE8
    end
    id_pointer = 0x021BFB94 + seed_off
    id_off = 0x8C

elseif gen == 5 then
    if langbyte == 0x4A then  -- Check game language
        language = "JPN"
        prngAddr = 0x02216084
        mtSeedAddr = 0x022151B4
        idsAddr = 0x02234E20
        partyPosAddr = 0x022695F8
        boxNumAddr = 0x022695E0
        boxPosAddr = 0x022EB745
        statsPartyPosAddr = 0x022695E4
        statsBoxPosAddr = 0x022795F4
        partyCheckAddr = 0x022695EC
        enemyAddr = 0x0226AB54
        cgearEnemyAddr = 0x0225CC84
        statsBoxAddr = 0x0227986C
        boxAddr = 0x0221BE0C
        partyAddr = 0x02234814
        partyCounterAddr = 0x02234810
    elseif langbyte == 0x4F then
        language = "USA"
        prngAddr = 0x02216224
        mtSeedAddr = 0x02215354
        idsAddr = 0x02234FC0
        partyPosAddr = 0x02269798
        boxNumAddr = 0x02269780
        boxPosAddr = 0x022EB8E1
        statsPartyPosAddr = 0x02269784
        statsBoxPosAddr = 0x02279794
        partyCheckAddr = 0x0226978C
        enemyAddr = 0x0226ACF4
        cgearEnemyAddr = 0x0225CF10
        statsBoxAddr = 0x02279A0C
        boxAddr = 0x0221BFAC
        partyAddr = 0x022349B4
        partyCounterAddr = 0x022349B0
    elseif langbyte == 0x49 then
        language = "ITA"
        prngAddr = 0x02216124
        mtSeedAddr = 0x2215254
        idsAddr = 0x02234EC0
        partyPosAddr = 0x02269698
        boxNumAddr = 0x02269680
        boxPosAddr = 0x022EB7DD
        statsPartyPosAddr = 0x02269684
        statsBoxPosAddr = 0x02279694
        partyCheckAddr = 0x0226968C
        enemyAddr = 0x0226ABF4
        cgearEnemyAddr = 0x0225CE10
        statsBoxAddr = 0x0227990C
        boxAddr = 0x0221BEAC
        partyAddr = 0x022348B4
        partyCounterAddr = 0x022348B0
    elseif langbyte == 0x44 then
        language = "GER"
        prngAddr = 0x02216164
        mtSeedAddr = 0x02215294
        idsAddr = 0x02234F00
        partyPosAddr = 0x022696D8
        boxNumAddr = 0x022696C0
        boxPosAddr = 0x022EB81D
        statsPartyPosAddr = 0x022696C4
        statsBoxPosAddr = 0x022796D4
        partyCheckAddr = 0x022696CC
        enemyAddr = 0x0226AC34
        cgearEnemyAddr = 0x0225CE50
        statsBoxAddr = 0x0227994C
        boxAddr = 0x0221BEEC
        partyAddr = 0x022348F4
        partyCounterAddr = 0x022348F0
    elseif langbyte == 0x46 then
        language = "FRE"
        prngAddr = 0x022161A4
        mtSeedAddr = 0x022152D4
        idsAddr = 0x02234F40
        partyPosAddr = 0x02269718
        boxNumAddr = 0x02269700
        boxPosAddr = 0x022EB85D
        statsPartyPosAddr = 0x02269704
        statsBoxPosAddr = 0x02279714
        partyCheckAddr = 0x0226970C
        enemyAddr = 0x0226AC74
        cgearEnemyAddr = 0x0225CE90
        statsBoxAddr = 0x0227998C
        boxAddr = 0x0221BF2C
        partyAddr = 0x02234934
        partyCounterAddr = 0x02234930
    elseif langbyte == 0x53 then
        language = "SPA"
        prngAddr = 0x022161E4
        mtSeedAddr = 0x02215314
        idsAddr = 0x02234F80
        partyPosAddr = 0x02269758
        boxNumAddr = 0x02269740
        boxPosAddr = 0x022EB8A1
        statsPartyPosAddr = 0x02269744
        statsBoxPosAddr = 0x02279754
        partyCheckAddr = 0x0226974C
        enemyAddr = 0x0226ACB4
        cgearEnemyAddr = 0x0225CED0
        statsBoxAddr = 0x022799CC
        boxAddr = 0x0221BF6C
        partyAddr = 0x02234974
        partyCounterAddr = 0x02234970
    elseif langbyte == 0x4B then
        language = "KOR"
        prngAddr = 0x02216924
        mtSeedAddr = 0x02215A54
        idsAddr = 0x022356C0
        partyPosAddr = 0x02269E98
        boxNumAddr = 0x02269E80
        boxPosAddr = 0x022EBFE1
        statsPartyPosAddr = 0x02269E84
        statsBoxPosAddr = 0x02279E94
        partyCheckAddr = 0x02269E8C
        enemyAddr = 0x0226B3F4
        cgearEnemyAddr = 0x0225D610
        statsBoxAddr = 0x0227A10C
        boxAddr = 0x0221C6AC
        partyAddr = 0x022350B4
        partyCounterAddr = 0x022350B0
    end
elseif gen == 5.5 then
    if langbyte == 0x4A then  -- Check game language
        language = "JPN"
        prngAddr = 0x021FF5B8
        mtSeedAddr = 0x021FE6C8
        idsAddr = 0x0221E398
        partyPosAddr = 0x02256C70
        boxNumAddr = 0x02256C54
        boxPosAddr = 0x02271198
        statsPartyPosAddr = 0x02256C58
        statsBoxPosAddr = 0x02266C68
        statsBoxPosAddr2 = 0x02266C6A
        enemyAddr = 0x02258734
        statsBoxAddr = 0x02266EE0
        boxAddr = 0x02205384
        currSelectedBox = 0x02204F84
        partyAddr = 0x0221DD8C
        partyCounterAddr = 0x0221DD88
    elseif langbyte == 0x4F then
        language = "USA"
        prngAddr = 0x021FFC18
        mtSeedAddr = 0x021FED28
        idsAddr = 0x0221E9F8
        partyPosAddr = 0x022572D0
        boxNumAddr = 0x022572B4
        boxPosAddr = 0x022717F8
        statsPartyPosAddr = 0x022572B8
        statsBoxPosAddr = 0x022672C8
        statsBoxPosAddr2 = 0x022672CA
        enemyAddr = 0x02258834
        statsBoxAddr = 0x02267540
        boxAddr = 0x022059E4
        currSelectedBox = 0x022055E4
        partyAddr = 0x0221E3EC
        partyCounterAddr = 0x0221E3E8
    elseif langbyte == 0x49 then
        language = "ITA"
        prngAddr = 0x021FFB18
        mtSeedAddr = 0x021FEC28
        idsAddr = 0x0221E8F8
        partyPosAddr = 0x022571D0
        boxNumAddr = 0x022571B4
        boxPosAddr = 0x022716F8
        statsPartyPosAddr = 0x022571B8
        statsBoxPosAddr = 0x022671C8
        statsBoxPosAddr2 = 0x022671CA
        enemyAddr = 0x02258734
        statsBoxAddr = 0x02267440
        boxAddr = 0x022058E4
        currSelectedBox = 0x022054E4
        partyAddr = 0x0221E2EC
        partyCounterAddr = 0x0221E2E8
    elseif langbyte == 0x44 then
        language = "GER"
        prngAddr = 0x021FFB58
        mtSeedAddr = 0x021FEC68
        idsAddr = 0x0221E938
        partyPosAddr = 0x02257210
        boxNumAddr = 0x022571F4
        boxPosAddr = 0x02271738
        statsPartyPosAddr = 0x022571F8
        statsBoxPosAddr = 0x02267208
        statsBoxPosAddr2 = 0x0226720A
        enemyAddr = 0x02258774
        statsBoxAddr = 0x02267480
        boxAddr = 0x02205924
        currSelectedBox = 0x02205524
        partyAddr = 0x0221E32C
        partyCounterAddr = 0x0221E328
    elseif langbyte == 0x46 then
        language = "FRE"
        prngAddr = 0x021FFC38
        mtSeedAddr = 0x021FED48
        idsAddr = 0x0221EA18
        partyPosAddr = 0x022572F0
        boxNumAddr = 0x022572D4
        boxPosAddr = 0x02271818
        statsPartyPosAddr = 0x022572D8
        statsBoxPosAddr = 0x022672E8
        statsBoxPosAddr2 = 0x022672EA
        enemyAddr = 0x02258854
        statsBoxAddr = 0x02267560
        boxAddr = 0x02205A04
        currSelectedBox = 0x02205604
        partyAddr = 0x0221E40C
        partyCounterAddr = 0x0221E408
    elseif langbyte == 0x53 then
        language = "SPA"
        prngAddr = 0x021FFBD8
        mtSeedAddr = 0x021FECE8
        idsAddr = 0x0221E9B8
        partyPosAddr = 0x02257290
        boxNumAddr = 0x02257274
        boxPosAddr = 0x022717B8
        statsPartyPosAddr = 0x02257278
        statsBoxPosAddr = 0x02267288
        statsBoxPosAddr2 = 0x0226728A
        enemyAddr = 0x022587F4
        statsBoxAddr = 0x02267500
        boxAddr = 0x022059A4
        currSelectedBox = 0x022055A4
        partyAddr = 0x0221E3AC
        partyCounterAddr = 0x0221E3A8
    elseif langbyte == 0x4B then
        language = "KOR"
        prngAddr = 0x02200358
        mtSeedAddr = 0x021FF468
        idsAddr = 0x0221F138
        partyPosAddr = 0x02257A10
        boxNumAddr = 0x022579F4
        boxPosAddr = 0x02271F38
        statsPartyPosAddr = 0x022579F8
        statsBoxPosAddr = 0x02267A08
        statsBoxPosAddr2 = 0x02267A0A
        enemyAddr = 0x02258F74
        statsBoxAddr = 0x02267C80
        boxAddr = 0x02206124
        currSelectedBox = 0x02205D24
        partyAddr = 0x0221EB2C
        partyCounterAddr = 0x0221EB28
    end
end

if game == "W2" or game == "W" then
    if gen == 5 then -- Check game version
        if language ~= "KOR" and language ~= "SPA" then
            prngAddr = prngAddr + 0x20
            mtSeedAddr = mtSeedAddr + 0x20
            idsAddr = idsAddr + 0x20
            partyPosAddr = partyPosAddr + 0x20
            boxNumAddr = boxNumAddr + 0x20
            boxPosAddr = boxPosAddr + 0x20
            statsPartyPosAddr = statsPartyPosAddr + 0x20
            statsBoxPosAddr = statsBoxPosAddr + 0x20
            partyCheckAddr = partyCheckAddr + 0x20
            enemyAddr = enemyAddr + 0x20
            cgearEnemyAddr = cgearEnemyAddr + 0x20
            statsBoxAddr = statsBoxAddr + 0x20
            boxAddr = boxAddr + 0x20
            partyAddr = partyAddr + 0x20
            partyCounterAddr = partyCounterAddr + 0x20
        end
    elseif gen == 5.5 then
        if language ~= "USA" and language ~= "ITA" then
            prngAddr = prngAddr + 0x20
            mtSeedAddr = mtSeedAddr + 0x20
            idsAddr = idsAddr + 0x20
            partyPosAddr = partyPosAddr + 0x20
            boxNumAddr = boxNumAddr + 0x20
            boxPosAddr = boxPosAddr + 0x20
            statsPartyPosAddr = statsPartyPosAddr + 0x20
            statsBoxPosAddr = statsBoxPosAddr + 0x20
            statsBoxPosAddr2 = statsBoxPosAddr2 + 0x20
            enemyAddr = enemyAddr + 0x20
            statsBoxAddr = statsBoxAddr + 0x20
            boxAddr = boxAddr + 0x20
            currSelectedBox = currSelectedBox + 0x20
            partyAddr = partyAddr + 0x20
            partyCounterAddr = partyCounterAddr + 0x20
        else
            prngAddr = prngAddr + 0x40
            mtSeedAddr = mtSeedAddr + 0x40
            idsAddr = idsAddr + 0x40
            partyPosAddr = partyPosAddr + 0x40
            boxNumAddr = boxNumAddr + 0x40
            boxPosAddr = boxPosAddr + 0x40
            statsPartyPosAddr = statsPartyPosAddr + 0x40
            statsBoxPosAddr = statsBoxPosAddr + 0x40
            statsBoxPosAddr2 = statsBoxPosAddr2 + 0x40
            enemyAddr = enemyAddr + 0x40
            statsBoxAddr = statsBoxAddr + 0x40
            boxAddr = boxAddr + 0x40
            currSelectedBox = currSelectedBox + 0x40
            partyAddr = partyAddr + 0x40
            partyCounterAddr = partyCounterAddr + 0x40
        end
    end
end

function getBits(a,b,d)
	return rshift(a,b)%lshift(1,d)
end

function getHigh(a)
	return(rshift(a,16))
end

function menu()
	inp = input.get()
	if inp[controls[6]] and not prev[controls[6]] then
		if yfix == -185 then
			yfix = 7
		else
			yfix = -185
		end
	end
	if inp[controls[5]] and not prev[controls[5]] then
		if on == 1 then
			on = 2
		else
			on = 1
		end
	end
	if inp[controls[4]] and not prev[controls[4]] and view == 1 then
		sub = sub - 1
		if sub == 0 then
			sub = submax
		end
	end
	if inp[controls[3]] and not prev[controls[3]] and view == 1 then
		sub = sub + 1
		if sub == submax + 1 then
			sub = 1
		end
	end
	if inp[controls[2]] and not prev[controls[2]] then
		view = view - 1
		if view == 0 then
			view = viewmax
		end
	end
	if inp[controls[1]] and not prev[controls[1]] then
		view = view + 1
		if view == viewmax + 1 then
			view = 1
		end
	end
	prev = inp
end

function getPointer()
	if gameint == 1 then
		return mdword(0x02106FAC)
	elseif gameint == 2 then
		return mdword(0x0211186C)
	else
		return mdword(0x02101D2C)
	end
end

function getPidAddr()
    ind = sub
    if ind == 7 then
        ind = 1
    end
	if gameint == 1 then --Pearl
		enemyAddr = pointer + 0x364C8
		if view == 5 then
			return pointer + 0x36C6C
		elseif view == 4 then
			return mdword(enemyAddr) + 0x774 + 0x5B0 + 0xEC*(ind-1)
		elseif view == 3 then
			return mdword(enemyAddr) + 0x774 + 0xB60 + 0xEC*(ind-1)
		elseif view == 2 then
			return mdword(enemyAddr) + 0x774 + 0xEC*(ind-1)
		else
			return pointer + 0xD2AC + 0xEC*(ind-1)
		end
	elseif gameint == 2 then --HeartGold
		enemyAddr = pointer + 0x37970
		if view == 5 then
			return pointer + 0x38540
		elseif view == 4 then
			return mdword(enemyAddr) + 0x1C70 + 0xA1C + 0xEC*(ind-1)	
		elseif view == 3 then
			return mdword(enemyAddr) + 0x1C70 + 0x1438 + 0xEC*(ind-1)
		elseif view == 2 then
			return mdword(enemyAddr) + 0x1C70 + 0xEC*(ind-1)
		else
			return pointer + 0xD088 + 0xEC*(ind-1)
		end
	elseif gameint == 3 then --Platinum
		enemyAddr = pointer + 0x352F4
		if view == 5 then
			return pointer + 0x35AC4
		elseif view == 4 then
			return mdword(enemyAddr) + 0x7A0 + 0x5B0 + 0xEC*(ind-1)
		elseif view == 3 then
			return mdword(enemyAddr) + 0x7A0 + 0xB60 + 0xEC*(ind-1) 
		elseif view == 2 then
			return mdword(enemyAddr) + 0x7A0 + 0xEC*(ind-1) 
		else
			return pointer + 0xD094 + 0xEC*(ind-1)
		end
    elseif gameint == 4 or gameint == 5 then --BW
		if view == 5 then
			return enemyAddr
		elseif view == 4 then
			return partyAddr + 0x36E00 + 0xDC*(ind-1)
		elseif view == 3 then
			return enemyAddr + 0x1580		
		elseif view == 2 then
			return enemyAddr
		else -- view 1
			return partyAddr + 0xDC*(ind-1)
		end
	elseif gameint >= 6 then --BW 2
		if view == 5 then
			return enemyAddr
		elseif view == 4 then
			return partyAddr + 0x36E00 + 0xDC*(ind-1)
		elseif view == 3 then
			return enemyAddr + 0x1580		
		elseif view == 2 then
			return enemyAddr
		else -- view 1
			return partyAddr + 0xDC*(ind-1)
		end
    end
end

function getNatSign(a)
	sign = ""
	if nat % 6 == 0 then
		sign = ""
	elseif a == "atk" then
		if nat < 5 then
			sign = "+"
		elseif nat % 5 == 0 then
			sign = "-"
		end
	elseif a == "def" then
		if nat > 4 and nat < 10 then
			sign = "+"
		elseif nat % 5 == 1 then
			sign = "-"
		end
	elseif a == "spe" then
		if nat > 9 and nat < 15 then
			sign = "+"
		elseif nat % 5 == 2 then
			sign = "-"
		end
	elseif a == "spa" then
		if nat > 14 and nat < 20 then
			sign = "+"
		elseif nat % 5 == 3 then
			sign = "-"
		end
	elseif a == "spd" then
		if nat > 19 then
			sign = "+"
		elseif nat % 5 == 4 then
			sign = "-"
		end
	end
	return sign
end

function getIVClr(a)
	color = "white"
	if a > 29 then
		color = "green"
	elseif a < 2 then
		color = "red"
	end
	return color
end

function next(s, mul1, mul2, sum)
    local a = mul1 * (s % 65536) + rshift(s, 16) * mul2
    local b = mul2 * (s % 65536) + (a % 65536) * 65536 + sum
    local c = b % 4294967296
    return c
end

function back(s)
    local a = 0x9638 * (s % 65536) + rshift(s, 16) * 0x806D
    local b = 0x806D * (s % 65536) + (a % 65536) * 65536 + 0xA384E6F9
    local c = b % 4294967296
    return c
end

function decryptPokemon()
    pidAddr = getPidAddr()
    pid = mdword(pidAddr)
   
    checksum = mword(pidAddr + 6)
    shiftValue = (rshift((bnd(pid, 0x3E000)), 0xD)) % 24
   
    BlockAoff = (BlockA[shiftValue + 1] - 1) * 32
    BlockBoff = (BlockB[shiftValue + 1] - 1) * 32
    BlockCoff = (BlockC[shiftValue + 1] - 1) * 32
    BlockDoff = (BlockD[shiftValue + 1] - 1) * 32
   
    -- Block A
    prng = checksum
    for i = 1, BlockA[shiftValue + 1] - 1 do
        prng = next(prng, 0x5F74, 0x8241, 0xCBA72510) -- 16 cycles
    end
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    pokemonID = bxr(mword(pidAddr + BlockAoff + 8), getHigh(prng))
    if pokemonID > 650 then
        pokemonID = 1
    end
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    heldItem = bxr(mword(pidAddr + BlockAoff + 2 + 8), getHigh(prng))
    if heldItem > 639 then
        pokemonID = 1
        heldItem = 1
    end
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    OTID = bxr(mword(pidAddr + BlockAoff + 4 + 8), getHigh(prng))
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    OTSID = bxr(mword(pidAddr + BlockAoff + 6 + 8), getHigh(prng))
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    ability = bxr(mword(pidAddr + BlockAoff + 12 + 8), getHigh(prng))
    friendship_or_steps_to_hatch = getBits(ability, 0, 8)
    ability = getBits(ability, 8, 8) + 1
    if ability > 164 then
        pokemonID = 1
        ability = 1
    end
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    evs[1] = bxr(mword(pidAddr + BlockAoff + 16 + 8), getHigh(prng))
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    evs[2] = bxr(mword(pidAddr + BlockAoff + 18 + 8), getHigh(prng))
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    evs[3] = bxr(mword(pidAddr + BlockAoff + 20 + 8), getHigh(prng))
   
    hpev =  getBits(evs[1], 0, 8)
    atkev = getBits(evs[1], 8, 8)
    defev = getBits(evs[2], 0, 8)
    speev = getBits(evs[2], 8, 8)
    spaev = getBits(evs[3], 0, 8)
    spdev = getBits(evs[3], 8, 8)
   
    -- Block B
    prng = checksum
    for i = 1, BlockB[shiftValue + 1] - 1 do
        prng = next(prng, 0x5F74, 0x8241, 0xCBA72510) -- 16 cycles
    end
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    move[1] = bxr(mword(pidAddr + BlockBoff + 8), getHigh(prng)) + 1
    if move[1] > 559 then
        pokemonID = 1
        move[1] = 1
    end
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    move[2] = bxr(mword(pidAddr + BlockBoff + 2 + 8), getHigh(prng)) + 1
    if move[2] > 559 then
        pokemonID = 1
        move[2] = 1
    end
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    move[3] = bxr(mword(pidAddr + BlockBoff + 4 + 8), getHigh(prng)) + 1
    if move[3] > 559 then
        pokemonID = 1
        move[3] = 1
    end
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    move[4] = bxr(mword(pidAddr + BlockBoff + 6 + 8), getHigh(prng)) + 1
    if move[4] > 559 then
        pokemonID = 1
        move[4] = 1
    end
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    moveppaux = bxr(mword(pidAddr + BlockBoff + 8 + 8), getHigh(prng))
    movepp[1] = getBits(moveppaux, 0, 8)
    movepp[2] = getBits(moveppaux, 8, 8)
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    moveppaux = bxr(mword(pidAddr + BlockBoff + 10 + 8), getHigh(prng))
    movepp[3] = getBits(moveppaux, 0, 8)
    movepp[4] = getBits(moveppaux, 8, 8)
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
   
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    ivspart[1] = bxr(mword(pidAddr + BlockBoff + 16 + 8), getHigh(prng))
    prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    ivspart[2] = bxr(mword(pidAddr + BlockBoff + 18 + 8), getHigh(prng))
    ivs = ivspart[1]  + lshift(ivspart[2], 16)
   
    hpiv  = getBits(ivs, 0, 5)
    atkiv = getBits(ivs, 5, 5)
    defiv = getBits(ivs, 10, 5)
    speiv = getBits(ivs, 15, 5)
    spaiv = getBits(ivs, 20, 5)
    spdiv = getBits(ivs, 25, 5)
    isEgg = getBits(ivs, 30, 1) == 1

    if gen == 4 then
        -- Gen 4 Nature
        nat = pid % 25
    else
        -- Gen 5 Nature
        prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
		prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
		prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
		nat = bxr(memory.readword(pidAddr + BlockBoff + 24 + 8), getHigh(prng))
		nat = getBits(nat,8,8)
		if nat > 24 then
			pokemonID = -1
		end
    end
   
    -- Calculate Hidden Power
    hiddentype = floor(((hpiv % 2) + 2*(atkiv % 2) + 4*(defiv % 2) + 8*(speiv % 2) + 16*(spaiv % 2) + 32*(spdiv % 2))*15 / 63)
    hiddenpower = 30 + floor(((rshift(hpiv, 1) % 2) + 2*(rshift(atkiv, 1) % 2) + 4*(rshift(defiv, 1) % 2)
                    + 8*(rshift(speiv, 1) % 2) + 16*(rshift(spaiv, 1) % 2) + 32*(rshift(spdiv, 1) % 2)) * 40 / 63)

    -- -- Block D
    -- prng = checksum
    -- for i = 1, BlockD[shiftValue + 1] - 1 do
    --     prng = next(prng, 0x5F74, 0x8241, 0xCBA72510) -- 16 cycles
    -- end
   
    -- prng = next(prng, 0xCFDD, 0xDF21, 0x67DBB608) -- 8 cycles
    -- prng = next(prng, 0xEE06, 0x7F11, 0x31B0DDE4) -- 4 cycles
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- pkrs = bxr(mword(pidAddr + BlockDoff + 0x1A + 8), getHigh(prng))
    -- pkrs = getBits(pkrs, 0, 8)
   
    -- prng = pid
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- level = getBits(bxr(mword(pidAddr + 0x8C), getHigh(prng)), 0, 8)
   
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- hpstat = bxr(mword(pidAddr + 0x8E), getHigh(prng))
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- maxhpstat = bxr(mword(pidAddr + 0x90), getHigh(prng))
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- atkstat = bxr(mword(pidAddr + 0x92), getHigh(prng))
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- defstat = bxr(mword(pidAddr + 0x94), getHigh(prng))
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- spestat = bxr(mword(pidAddr + 0x96), getHigh(prng))
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- spastat = bxr(mword(pidAddr + 0x98), getHigh(prng))
    -- prng = next(prng, 0x41C6, 0x4E6D, 0x6073)
    -- spdstat = bxr(mword(pidAddr + 0x9A), getHigh(prng))
   end

function buildseed()
	delay=mdword(0x021BF6A8+delay_off)+21
	timehex=mdword(0x023FFDEC)
	datehex=mdword(0x023FFDE8)
	hour=format("%02X",(timehex%0x100)%0x40)	-- memory stores as decimal, but Lua reads as hex. Convert.
	minute=format("%02X",(rshift(timehex%0x10000,8)))
	second=format("%02X",(mbyte(0x02FFFDEE)))
	year=format("%02X",(mbyte(0x02FFFDE8)))
	month=format("%02X",(mbyte(0x02FFFDE9)))
	day=format("%02X",(mbyte(0x02FFFDEA)))
	ab=(month*day+minute+second)%256	-- Build Seed
	cd=hour
	cgd=delay%65536 +1		-- can tweak for calibration
	abcd=ab*0x100+cd
	efgh=(year+cgd)%0x10000
	nextseed=ab*0x1000000+cd*0x10000+efgh	-- Seed is built
	return nextseed		
end

-- Period parameters
local N = 624
local M = 397
local MATRIX_A = 0x9908B0DF  -- constant vector a
local UPPER_MASK = 0x80000000  -- most significant w-r bits
local LOWER_MASK = 0x7FFFFFFF  -- least significant r bits

local mt = {}  -- the array for the state vector
local mti = N + 1  -- mti == N + 1 means mt[N] is not initialized

-- initializes mt[N] with a seed
function randomseed(s)
 s = bnd(s, 0xFFFFFFFF)
 mt[1] = s
 for i = 1, N - 1 do
  -- s = 1812433253 * (bxr(s, rshift(s, 30))) + i
  s = bxr(s, rshift(s, 30))
  local s_lo = bnd(s, 0xFFFF)
  local s_hi = rshift(s, 16)
  local s_lo2 = bnd(1812433253 * s_lo, 0xFFFFFFFF)
  local s_hi2 = bnd(1812433253 * s_hi, 0xFFFF)
  s = br(lshift(rshift(s_lo2, 16) + s_hi2, 16), bnd(s_lo2, 0xFFFF))
  -- s = bnd(s + i, 0xFFFFFFFF)
  local s_lim = -tobit(s)
  -- assumes i < 2^31
  if (s_lim > 0 and s_lim <= i) then
   s = i - s_lim
  else
   s = s + i
  end
  mt[i + 1] = s
  -- See Knuth TAOCP Vol2. 3rd Ed. P.106 for multiplier.
  -- In the previous versions, MSBs of the seed affect
  -- only MSBs of the array mt[].
  -- 2002/01/09 modified by Makoto Matsumoto
 end

 mti = N
end

local mag01 = {0, MATRIX_A}  -- mag01[x] = x * MATRIX_A  for x = 0, 1

-- generates a random number on [0, 0xFFFFFFFF] - interval
function random_int32()
    local y

    if (mti >= N) then  -- generate N words at one time
        local kk

        if (mti == N + 1) then  -- if init_genrand() has not been called,
            mt19937.randomseed(5489)  -- a default initial seed is used
        end

        for kk = 1, N - M do
            y = br(bnd(mt[kk], UPPER_MASK), bnd(mt[kk + 1], LOWER_MASK))
            mt[kk] = bxr(mt[kk + M], rshift(y, 1), mag01[1 + bnd(y, 1)])
        end
        for kk = N - M + 1, N - 1 do
            y = br(bnd(mt[kk], UPPER_MASK), bnd(mt[kk + 1], LOWER_MASK))
            mt[kk] = bxr(mt[kk + (M - N)], rshift(y, 1), mag01[1 + bnd(y, 1)])
        end
        y = br(bnd(mt[N], UPPER_MASK), bnd(mt[1], LOWER_MASK))
        mt[N] = bxr(mt[M], rshift(y, 1), mag01[1 + bnd(y, 1)])

        mti = 0
    end

    y = mt[mti + 1]
    mti = mti + 1

    return y
end

function buildSeedCGear()  -- Predict C-Gear Seed
    ab = (month * day + minute + second) % 256  -- Build Seed
    cd = hour
    cgd = delay % 65536 + 1
    abcd = ab * 0x100 + cd
    efgh = (year + cgd) % 0x10000
    betaseed = ab * 0x1000000 + cd * 0x10000 + efgh  -- Seed before MAC applied
    cgearseed = betaseed + mac  -- Seed after MAC applied, return this value.
   
    return cgearseed
   end
   
function getCGearSeed()  -- C-Gear Seed Generation
    strMtSeed = string.format("%08X", mtSeed)  -- Mersenne Twister untempered is in one format while the memory is in another
    ab = (month * day + minute + second) % 256  -- Build Seed
    cd = hour
    cgd = delay % 65536 - 1
    abcd = ab * 0x100 + cd
    efgh = (year + cgd) % 0x10000
    nextseed = ab * 0x1000000 + cd * 0x10000 + efgh
    calculatedCGear = (ab * 0x1000000 + cd * 0x10000 + efgh + mac) % 0x100000000  -- Seed is built
    randomseed(calculatedCGear)
    cgearCheck = string.format("%08X", random_int32())
   
    if strMtSeed ~= cgearCheck then
        cgd = cgd - 1  -- Subtract 1 from delay to check a different set.
        ab = (month * day + minute + second) % 256  -- Rebuild seed, try again.
        cd = hour
        abcd = ab * 0x100 + cd
        efgh = (year + cgd) % 0x10000
        calculatedCGear = (ab * 0x1000000 + cd * 0x10000 + efgh + mac) % 0x100000000
        randomseed(calculatedCGear)
        cgearCheck = string.format("%08X", random_int32())
    end
   
    hitMtSeed = calculatedCGear
    hitDelay = cgd
    hitDate = string.format("%02d/%02d/%d\n%02d:%02d:%02d", month, day, 2000 + year, hour, minute, second)
end

function calcFrameJump(tempCurr, curr)
    calibrationFrame = 0
    if tempCurr ~= curr then
        tempCurr2 = tempCurr
        while tempCurr ~= curr and tempCurr2 ~= curr do
            tempCurr = next(tempCurr, 0x6C07, 0x8965, 0x269EC3)
            tempCurr2 = back(tempCurr2)
            calibrationFrame = calibrationFrame + 1
            if calibrationFrame > 99999 then
                calibrationFrame = 0
                break
            end
        end
        if tempCurr2 == curr then
            calibrationFrame = (-1) * calibrationFrame
            tempCurrLow = tempCurr2
        else
            tempCurrLow = tempCurr
        end
    end
    return calibrationFrame
end

pointer = getPointer()
print(format("%08X",pointer))
function fn()
	menu()
    if gen == 4 then
        currseed = mdword(0x021BFB14+seed_off)
        seed = mdword(0x021BFB18+seed_off)
        fcurrseed = mdword(0x021BFB14+seed_off)
        finitial = mdword(0x021BFB18+seed_off)
        advance = 0
            
        -- Detect initial seeding
        if mdword(0x021BFB18+seed_off) == currseed then
            initial = mdword(0x021BFB14+seed_off)
            if currseed ~= 0x00000000 then
                advance = 0
                iadvance = 0
            end
        end
        if mdword(0x021BFB14) == 0x00000000 then	-- if seed is 0, reset everything
            advance = 0
            iadvance = 0
        end

        -- PIDRNG Advance Counting
        if fcurrseed ~= finitial then
            if fcurrseed ~= 0x00000000 then
                while finitial ~= fcurrseed do
                    finitial = next(finitial, 0x41C6, 0x4E6D, 0x6073)
                    initial = mdword(0x021BFB18+seed_off)
                    advance = advance + 1
                    if advance > 9999 then 
                        break
                    end
                end
            end
        end
            
        -- IRNG Advance Counting
        if mdword(0x02100834+mt_off) >= 624 then
            iadvance = 0
        else
            iadvance = mdword(0x02100834+mt_off)
        end
    elseif gen >= 5 then
        if mdword(prngAddr) ~= 0 and initSet == 0 then
            initSeedHigh = mdword(prngAddr + 0x4)
            initSeedLow = mdword(prngAddr)
            print(string.format("Initial Seed: %08X%08X", initSeedHigh, initSeedLow))
            tempCurrLow = initSeedLow
            prevMtSeed = mdword(mtSeedAddr)
            initSet = 1
        elseif mdword(prngAddr) == 0 then
            initSeedHigh = 0
            initSeedLow = 0
            frame = 0
            initSet = 0
            hitMtSeed = 0
            hitDelay = 0
            hitDate = "01/01/2000\n00:00:00"
        end
          
        currSeedHigh = mdword(prngAddr + 0x4)
        currSeedLow = mdword(prngAddr)
        mtSeed = mdword(mtSeedAddr)
          
        if mdword(mtSeedAddr + 0x9C0) == 624 then
            ivsFrame = 0
        else
            ivsFrame = mdword(mtSeedAddr + 0x9C0)
        end
          
        frame = frame + calcFrameJump(tempCurrLow, currSeedLow)
          
        delay = mdword(0x02FFFC3C)
        timehex = mdword(0x023FFDEC)
        datehex = mdword(0x023FFDE8)
        hour = string.format("%02X", (timehex % 0x100) % 0x40)
        minute = string.format("%02X", (rshift(timehex % 0x10000, 8)))
        second = string.format("%02X", (mbyte(0x02FFFDEE)))
        year = string.format("%02X", (mbyte(0x02FFFDE8)))
        month = string.format("%02X", (mbyte(0x02FFFDE9)))
        day = string.format("%02X", (mbyte(0x02FFFDEA)))
          
        if prevMtSeed ~= mtSeed and delay > 200 then
            prevMtSeed = mtSeed
            getCGearSeed()
        end
          
        prevMtSeed = mtSeed
    end
    if on == 1 then
        pointer = getPointer()
        substr = ""
        if view == 1 then
            substr = sub
        end
        box(5,yfix-5,145,yfix+128,"#000000A0", "white")
        text(10,yfix, format("%s %s",views[view],substr), "white")
        text(128-((string.len(game)/2)*6),yfix, game, "green")
        if view < 6 and sub < 7 then
            decryptPokemon()
            if pokemonID == -1 then
                text(10,yfix+10, "Invalid Pokemon Data", "red")
            else
                if isegg == 1 then
                    text(10,yfix+10, format("Species: %s egg",pokemon[pokemonID + 1]), "white")
                else
                    text(10,yfix+10, format("Species: %s",pokemon[pokemonID + 1]), "white")
                end
                tsv = bxr(OTID,OTSID)
                psv = bxr(rshift(pid,16), bnd(pid,0xFFFF))
                sv = bxr(tsv,psv)
                shiny = " "
                pidcolor = "white"
                if sv < 8 then
                    shiny = "STAR"
                    pidcolor = "green"
                end
                if sv == 0 then
                    shiny = "SQUARE"
                    pidcolor = "green"
                end
                text(10,yfix+20, format("Nature: %s", nature[nat+1]), "white")
                text(10,yfix+30, format("Ability: %s", abilities[ability]))
                text(10,yfix+40, format("PID: %08X %s",pid,shiny), pidcolor)
                text(10,yfix+50, format("HP: %s %s",typeOrder[hiddentype+1],hiddenpower), "white")
                
                text(10,yfix+60,format("HP  IV:  %02d",hpiv), getIVClr(hpiv))
                text(10,yfix+70,format("ATK IV:  %02d%s",atkiv,getNatSign("atk")), getIVClr(atkiv))
                text(10,yfix+80,format("DEF IV:  %02d%s",defiv,getNatSign("def")), getIVClr(defiv))
                text(10,yfix+90,format("SAT IV:  %02d%s",spaiv,getNatSign("spa")), getIVClr(spaiv))
                text(10,yfix+100,format("SDF IV:  %02d%s",spdiv,getNatSign("spd")), getIVClr(spdiv))
                text(10,yfix+110,format("SPE IV:  %02d%s",speiv,getNatSign("spe")), getIVClr(speiv))
            end
        -- 7th Party Page
        elseif sub == 7 then
            if gen == 4 then
                ids = mdword(mdword(id_pointer) + id_off)
                sid = floor(ids / 0x10000)
                tid = ids % 0x10000
            else
                ids = mdword(idsAddr)
                sid = floor(ids / 0x10000)
                tid = ids % 0x10000
            end
            text(10,yfix+10, format("TID: %05d",tid))
            text(10,yfix+20, format("SID: %05d",sid))
            text(10,yfix+30, format("FULL TSV: %05d",bxr(tid,sid)))
            text(10,yfix+40, format("TSV: %04d",rshift(bxr(tid,sid),3)))
            text(10,yfix+50, format("TRV: %X",bxr(tid,sid)%8))
            text(10,yfix+60, format("G6+TSV: %04d",rshift(bxr(tid,sid),4)))
            text(10,yfix+70, format("G6+TRV: %X",bxr(tid,sid)%16))

        -- RNG screen
        elseif view == 6 then
            if gen == 4 then
                text(10,yfix+10,format("Initial Seed: %08X", initial))
                text(10,yfix+20,format("Current Seed: %08X", currseed))
                text(10,yfix+30,format("IVRNG Advance: %d", iadvance))
                text(10,yfix+40,format("PIDRNG Advance: %d", advance))
                if advance == 0 then
                    text(10,yfix+50,format("Delay: %d", mdword(0x021BF6A8+delay_off)+21))
                    text(10,yfix+60,format("Next Seed: %08X", buildseed()))
                end
            else
                text(10,yfix+10,format("Initial Seed: \n%08X%08X", initSeedHigh, initSeedLow))
                text(10,yfix+30,format("Current Seed: \n%08X%08X", currSeedHigh, currSeedLow))
                text(10,yfix+50,format("PID Frame: %d", frame))
                text(10,yfix+60,format("IVs Frame: %d", ivsFrame))
                text(10,yfix+70,format("%02d/%02d/%d", month, day, 2000 + year))
                text(10,yfix+80,format("%02d:%02d:%02d", hour, minute, second))
            end
        elseif view == 7 then
            if gen ~= 4 then
                text(10,yfix+10,format("Next C-Gear: %08X", buildSeedCGear()))
                text(10,yfix+20,format("Delay: %d", delay))
                text(10,yfix+30,format("C-Gear Seed: %08X", hitMtSeed))
                text(10,yfix+40,format("Hit Delay: %d", hitDelay))
                text(10,yfix+50,format("Hit Date:\n%s", hitDate))
            end
        end
    end
end

gui.register(fn)