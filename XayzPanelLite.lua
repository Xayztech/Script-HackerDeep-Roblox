local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("XayzPanelLite") then
    CoreGui.XayzPanelLite:Destroy()
end

local AudioLibrary = {
    {Name = "Chill Electronic", ID = 9048375035},
    {Name = "Upbeat Pop", ID = 9037463698},
    {Name = "Action Synth", ID = 9046863332},
    {Name = "Lofi Study", ID = 9043887091},
    {Name = "Epic Boss Fight", ID = 9047100551},
    {Name = "BRAZILIAN PHONK", ID = 85635811474451},
    {Name = "67 KID PHONK", ID = 125476440612900},
    {Name = "PHONK DRIFT", ID = 72653741821355},
    {Name = "FUNK INFERNA V2 Phonk (Deep Slowed)", ID = 86375151296706},
    {Name = "Psycho Phonk Slay", ID = 105100211445392},
    {Name = "AB4T", ID = 17422173467},
    {Name = "Above Phonk", ID = 89824897586105},
    {Name = "Alanwaad", ID = 17422074849},
    {Name = "Analog Vibes", ID = 138801603792399},
    {Name = "Assassin's Ride", ID = 73326647630445},
    {Name = "Back & Front", ID = 14145627474},
    {Name = "Bell Pepper", ID = 14145626111},
    {Name = "Black Seed", ID = 14145622615},
    {Name = "Blackout Drift", ID = 85290495098172},
    {Name = "Bloody Phonk", ID = 136350225160627},
    {Name = "Brazil Fiesta", ID = 125498129824026},
    {Name = "Breathing", ID = 137940368194253},
    {Name = "Burn the Night", ID = 136579058345590},
    {Name = "Chill Phonk", ID = 136974179670066},
    {Name = "Cowbell God", ID = 16190760005},
    {Name = "Dark Phonk Damage", ID = 105529482486905},
    {Name = "Desprezo", ID = 139435437308948},
    {Name = "Dionic", ID = 15689445424},
    {Name = "Don't Stop", ID = 135916877300061},
    {Name = "Down2Kill", ID = 16190760285},
    {Name = "Drooly", ID = 8053389869},
    {Name = "DTI Phonk", ID = 139161205970637},
    {Name = "Emotional Damage", ID = 14145621151},
    {Name = "End the Soft", ID = 93203762220779},
    {Name = "F-Phonk", ID = 101326109963284},
    {Name = "Funk Fiesta", ID = 139959590610806},
    {Name = "Fusion", ID = 136062265232554},
    {Name = "Gabbermix", ID = 18841887539},
    {Name = "Ghostblade Phonk", ID = 90441404910975},
    {Name = "Ghostly Stream", ID = 137589724762757},
    {Name = "Gigachand Phonk", ID = 134366188285514},
    {Name = "Hellfire Highway", ID = 136757074728111},
    {Name = "Heptraxous", ID = 8185857772},
    {Name = "HR -Eeyuh", ID = 16190782181},
    {Name = "Infinite", ID = 16190784875},
    {Name = "Invade Groom", ID = 15689453529},
    {Name = "Ladylike", ID = 139783457310815},
    {Name = "Last Hope", ID = 137436868877550},
    {Name = "Lost Phonk", ID = 139266399633943},
    {Name = "Low Down", ID = 137787889626447},
    {Name = "Mad Phonk", ID = 140274552295461},
    {Name = "Mad Phonk Energy", ID = 123636731441495},
    {Name = "Mad Phonk Pyscho", ID = 137599668691145},
    {Name = "Melancholy", ID = 138592111223571},
    {Name = "Metamorphosis", ID = 15689451063},
    {Name = "Metaverse", ID = 17422168798},
    {Name = "Monster Bass", ID = 14145623658},
    {Name = "Montagem", ID = 138682744064257},
    {Name = "No Brakes", ID = 135621572019998},
    {Name = "No Lights", ID = 14145623221},
    {Name = "Pac Man Phonk", ID = 120889371113999},
    {Name = "Phonk Da Rua", ID = 104596909675653},
    {Name = "Phonk Killaz", ID = 86179292245507},
    {Name = "Phonk of Darkness", ID = 116896498238234},
    {Name = "Phonk't Out", ID = 14145625743},
    {Name = "Pscyhopath", ID = 139333523265411},
    {Name = "Pure Phonk Violence", ID = 96461852889782},
    {Name = "Quando", ID = 137705500872153},
    {Name = "Raging Blood", ID = 138239009909667},
    {Name = "Raven Theme", ID = 14145621445},
    {Name = "Raw", ID = 139815305627554},
    {Name = "Raw Phonk Energy", ID = 135549022646779},
    {Name = "Reckless Drift Run", ID = 83348506277910},
    {Name = "Redemption", ID = 16190783774},
    {Name = "Reforest Glitch", ID = 138379611912655},
    {Name = "Robo Phonk", ID = 136932193331774},
    {Name = "Savage Slay Phonk", ID = 71837666565538},
    {Name = "Silicon Heartbeat", ID = 136954753954258},
    {Name = "Sinistra", ID = 15689443663},
    {Name = "Soul Crusher's Ride", ID = 120296689321275},
    {Name = "Stupid Remix", ID = 16662833837},
    {Name = "The Final Phonk", ID = 14145620056},
    {Name = "Twisted Killer Flow", ID = 89198968265350},
    {Name = "Ultima", ID = 16190756998},
    {Name = "Unbreakable", ID = 14145626744},
    {Name = "Uzipack", ID = 18841894272},
    {Name = "Vozes De Anjo", ID = 138399043067580},
    {Name = "Wasn V2", ID = 106495464414175},
    {Name = "Wassa", ID = 17422207260},
    {Name = "Die With A Smile - Lady Gaga & Bruno Mars", ID = 9175675404},
    {Name = "APT. - ROSE & Bruno Mars", ID = 9162822014},
    {Name = "A Bar Song (Tipsy) - Shaboozey", ID = 9019426415},
    {Name = "BIRDS OF A FEATHER - Billie Eilish", ID = 9025309340},
    {Name = "Lose Control - Teddy Swims", ID = 8998705678},
    {Name = "Luther - Kendrick Lamar & SZA", ID = 9047574337},
    {Name = "As It Was - Harry Styles", ID = 9128660909},
    {Name = "Stay - The Kid LAROI & Justin Bieber", ID = 6991475693},
    {Name = "Blinding Lights - The Weeknd", ID = 5028637536},
    {Name = "Savage Love - Jason Derulo", ID = 4640671238},
    {Name = "Steve's Lava Chicken", ID = 94446515790251},
    {Name = "Raining Tacos", ID = 142376088},
    {Name = "Metal Pipe Falling", ID = 6729922069},
    {Name = "Emotional Damage (Steven He)", ID = 8362816791},
    {Name = "Deku Sussy Baka", ID = 6537919656},
    {Name = "Thomas The Train Remix", ID = 642935512},
    {Name = "Deja Vu (Initial D)", ID = 4285827657},
    {Name = "SpongeBob Theme", ID = 318925857},
    {Name = "Wii Sports Theme", ID = 3106656207},
    {Name = "FUS RO DAH!!!", ID = 130776150},
    {Name = "God's Plan - Drake", ID = 1665926924},
    {Name = "Industry Baby - Lil Nas X", ID = 7253841629},
    {Name = "Lucid Dreams - Juice WRLD", ID = 8036100972},
    {Name = "Stronger - Kanye West", ID = 136209425},
    {Name = "Tokyo Drift - Teriyaki Boyz", ID = 1837015626},
    {Name = "SAD GIRLZ LUV MONEY - Amaarae", ID = 8026236684},
    {Name = "Heat Waves - Glass Animals", ID = 6432181830},
    {Name = "Dress to Impress Phonk", ID = 139161205970637},
    {Name = "Skibidi Toilet Phonk", ID = 122863102226559},
    {Name = "Brazilian Phonk (Bass Heavy)", ID = 108621585736031},
    {Name = "Fade - Alan Walker", ID = 292315830},
    {Name = "Spectre - Alan Walker", ID = 313726644},
    {Name = "Dreams - Lost Sky", ID = 7547342615},
    {Name = "Candyland - Tobu", ID = 118939739460633},
    {Name = "Sunburst - Tobu", ID = 121336636707861},
    {Name = "Silent Forest Ambient", ID = 81821734193614},
    {Name = "Tokyo Machine - PLAY", ID = 5410085763},
    {Name = "Clair de Lune", ID = 1838457617},
    {Name = "Fur Elise", ID = 450051032},
    {Name = "Moonlight Sonata", ID = 445023353},
    {Name = "Gymnopedie No. 1", ID = 9045766377},
    {Name = "Better Call Saul Theme", ID = 9106904975},
    {Name = "Squid Game Theme", ID = 7535587224},
    {Name = "Mii Channel Music", ID = 143666548},
    {Name = "Spider-Man Black Suit", ID = 9108472930},
    {Name = "Who's That Pokemon?", ID = 130767090},
    {Name = "Team Fortress 2 Theme", ID = 166378555},
    {Name = "PHONK || GVIKXTSU - TOKYO DRIFT", ID = 5077810864},
    {Name = "Билли Джин (Phonk Edition)", ID = 5020637545},
    {Name = "Phonk | Japan Drift | Hard phonk", ID = 5569815928},
    {Name = "cowbell phonk", ID = 4802537905},
    {Name = "IGARASHI KANTA - IN A HOOD NEAR YOU", ID = 5341452861},
    {Name = "phonk 1", ID = 5430239955},
    {Name = "Phonk 2", ID = 5155225687},
    {Name = "PHONK GOD", ID = 1282047646},
    {Name = "PHONK PHONK YEA", ID = 3353217023},
    {Name = "Kaito Shoma - Scary Garry (Clean Version)", ID = 6468836696},
    {Name = "Phonk beat", ID = 4639821753},
    {Name = "Phonk 3", ID = 4856328587},
    {Name = "Phonk 4", ID = 6056177578},
    {Name = "Phonk 5", ID = 6198813202},
    {Name = "Saint Phonk", ID = 4711248332},
    {Name = "Gimme Gimme Gimme (Phonk)", ID = 5030657350},
    {Name = "Кит ты маму мав (phonk)", ID = 5569300394},
    {Name = "Phonk type beat cowbell", ID = 4642779401},
    {Name = "Смешарики - От винта (PHONK REMIX)", ID = 5422507571},
    {Name = "Phonk beat :D", ID = 2849963683},
    {Name = "tones and I - Bad Child", ID = 5315279926},
    {Name = "Everybody Loves An Outlaw - I See Red", ID = 5808184278},
    {Name = "Frank Ocean - Chanel", ID = 1725273277},
    {Name = "Kali Uchis - Telepatia (slowed and reverb)", ID = 6403599974},
    {Name = "Nya! Arigato", ID = 6441347468},
    {Name = "BTS - Fake Love", ID = 1894066752},
    {Name = "Dua Lipa - Levitating", ID = 6606223785},
    {Name = "Illijah - On My Way", ID = 249672730},
    {Name = "Chikatto Chika Chika", ID = 5937000690},
    {Name = "Casi - No Limit", ID = 748726200},
    {Name = "Kim Dracula - Paparazzi (Lady Gaga cover)", ID = 6177409271},
    {Name = "Doja Cat - Say So", ID = 521116871},
    {Name = "Tesher - Jalebi Baby", ID = 6463211475},
    {Name = "Capone - Oh No", ID = 5253604010},
    {Name = "Clairo - Sofia", ID = 5760198930},
    {Name = "2Pac - Life Goes On", ID = 186317099},
    {Name = "Royal & the Serpent - Overwhelmed", ID = 5595658625},
    {Name = "Tina Turner - What's Love Got to Do with It", ID = 5145539495},
    {Name = "Baby Bash ft. Frankie J - Suga Suga", ID = 225150067},
    {Name = "Taylor Swift - You Belong With Me", ID = 6159978466},
    {Name = "Studio Killers - Jenny", ID = 63735955004},
    {Name = "Laffy Taffy", ID = 5478866871},
    {Name = "Billie Eilish - Ocean Eyes", ID = 1321038120},
    {Name = "Billie Eilish - My Future", ID = 5622020090},
    {Name = "Maroon 5 - Payphone", ID = 131396974},
    {Name = "Lady Gaga - Applause", ID = 130964099},
    {Name = "Clean Bandit ft. Demi Lovato - Solo Remix", ID = 2106186490},
    {Name = "Maaron 5 - Girls Like You ft. Cardi B", ID = 2211976041},
    {Name = "Juice Wrld - Armed & Dangerous", ID = 2498066534},
    {Name = "Paulo Londra - Adan Y Eva", ID = 2637276471},
    {Name = "Ariana Grande - What Do You Mean One Last Time", ID = 360160735},
    {Name = "Hello darkness, my old friend", ID = 145045371},
    {Name = "Steven Universe - Stronger Than You", ID = 225999739},
    {Name = "The Song of The Dragonborn", ID = 138297303},
    {Name = "Ava Max - Sweet but Psycho", ID = 2529951321},
    {Name = "Alec Benjamin - The Water Fountain", ID = 615938297},
    {Name = "Undertale - Battle Against A True Hero", ID = 333552980},
    {Name = "Imagine Dragons - Radioactive", ID = 132826277},
    {Name = "Major Lazer & DJ Snake - Lean On", ID = 239533935},
    {Name = "Old Town Road", ID = 2862170886},
    {Name = "I'M BEAN, MR. BEAN SONG", ID = 947518032},
    {Name = "Eminem - Lose Yourself", ID = 5906295202},
    {Name = "Fade - Alan Walker", ID = 348661804},
    {Name = "Nightcore - Alan walker - Alone", ID = 690128049},
    {Name = "Alan Walker - Alone", ID = 563602751},
    {Name = "Alan Walker - Fade (Versi 2)", ID = 279463893},
    {Name = "Alan Walker - Alone (Versi 2)", ID = 595922379},
    {Name = "Alan Walker - Fade [ Loop ]", ID = 389020916},
    {Name = "Alan Walkers The Spectre", ID = 2341234054},
    {Name = "Alan Walker - Spectre [1000 SALES!]", ID = 219506834},
    {Name = "Alan Walker - Force [NCS]", ID = 235509194},
    {Name = "Alan Walker - Force", ID = 279206936},
    {Name = "Alan Walker - Faded (Sep Remix)", ID = 466047335},
    {Name = "Alan walker faded", ID = 647977098},
    {Name = "Alan Walker - Fade (120 Sec)", ID = 297920627},
    {Name = "Alan Walker - Fade Piano Version", ID = 511905424},
    {Name = "Alan Walker - Routine", ID = 686514556},
    {Name = "Fade- Alan Walker(Loud)", ID = 397784170},
    {Name = "Alan Walker - Alone (Versi 3)", ID = 681903629},
    {Name = "Sing Me To Sleep - Alan Walker (ultimate remix)", ID = 473930460},
    {Name = "Alan Walker - 135", ID = 576481790},
    {Name = "Alan Walker - Fade [NCS Release] (Versi 2)", ID = 343744100},
    {Name = "Alan Walker - Fade [NCS Release] [FULL]", ID = 531158940},
    {Name = "Alan Walker - Faded (Osias Trap Remix)", ID = 365638345},
    {Name = "Alan Walker - New Heart", ID = 604107654},
    {Name = "Nightcore Faded (Alan WalkerLyrics)", ID = 585817132},
    {Name = "Alan Walker - Faded (Trap Remix)", ID = 698945367},
    {Name = "Obama sings Alan Walker - Faded", ID = 476185978},
    {Name = "Alan Walker - Fade (Versi 3)", ID = 468785462},
    {Name = "Alan Walker - Memories", ID = 479089458},
    {Name = "Alan Walker - Dennis 2014", ID = 656527673},
    {Name = "Alan Walker - Sing Me To Sleep (DOPEDROP Remix)", ID = 574259562},
    {Name = "Alan Walker - Faded (Sep Remix) 2", ID = 419901901},
    {Name = "Alan Walker - Hope", ID = 656519674},
    {Name = "Alan Walker - Memories 2", ID = 604106116},
    {Name = "Alan Walker- Faded (Edited)", ID = 588039699},
    {Name = "Alan Walker - Force (Versi 2)", ID = 233471598},
    {Name = "Alan Walker - Fade (Versi 4)", ID = 227475817},
    {Name = "Alan Walker - Flying dreams (2 min)", ID = 472494704},
    {Name = "Alan Walker - Faded (Instrumental)", ID = 468232574},
    {Name = "Alan Walker - Sing Me To Sleep (Instrumental)", ID = 444155664},
    {Name = "Alan Walker - Fade (Versi 5)", ID = 693428358},
    {Name = "Alan Walker - Faded Mix", ID = 421000798},
    {Name = "NightcoreFaded (Alan WalkerLyrics) 2", ID = 585799776},
    {Name = "Alan Walker - Force (Full Song)", ID = 644914256},
    {Name = "Alan Walker - Spectre (Versi 2)", ID = 279207008},
    {Name = "Alan Walkers - Lily", ID = 3144033802},
    {Name = "Alan Walker - Fade (Versi 6)", ID = 279206904},
    {Name = "Big universe - Alan Walker", ID = 604103411},
    {Name = "On my way - Alan Walker", ID = 3426464651},
    {Name = "Multo - Cup of Joe", ID = 118668717534464},
    {Name = "WHERE WE ARE", ID = 118538313029983},
    {Name = "Where We Are V2", ID = 117600599480279}
}

local Languages = {"EN", "ID", "ES", "JP", "RU"}
local CurrentLangIndex = 1

local Translations = {
    EN = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "LANGUAGE: ENGLISH",
        CloneHolder = "Enter Target Username...",
        CloneBtn = "CLONE AVATAR",
        HeadlessBtn = "ENABLE HEADLESS",
        StatsToggle = "SHOW FPS/PING/CPS",
        AntiFling = "ANTI FLING (NO COLLISION)",
        NDSBtn = "TEST DISASTER POP-UP",
        SpeedHolder = "Set WalkSpeed (Def: 16)",
        JumpHolder = "Set JumpPower (Def: 50)",
        GravHolder = "Set Gravity (Def: 196.2)",
        KeepStats = "AUTO-KEEP STATS (ANTI-RESET)",
        EmoteHolder = "Enter Animation ID...",
        EmoteBtn = "PLAY ANIMATION",
        Searching = "Searching...",
        NotFound = "Not Found!",
        HeadlessActive = "HEADLESS ACTIVE!",
        DisasterTitle = "DISASTER DETECTED!",
        DisasterDesc = "Tsunami incoming! Get to high ground immediately!",
        InvalidID = "Invalid ID!",
        OpenMusic = "OPEN MUSIC PLAYER",
        SearchMusic = "Search Music...",
        Playing = "Playing"
    },
    ID = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "BAHASA: INDONESIA",
        CloneHolder = "Masukkan Username Target...",
        CloneBtn = "TIRU AVATAR",
        HeadlessBtn = "AKTIFKAN KEPALA HILANG",
        StatsToggle = "TAMPILKAN FPS/PING/CPS",
        AntiFling = "ANTI PENTAL (TEMBUS)",
        NDSBtn = "TES POP-UP BENCANA",
        SpeedHolder = "Atur Kecepatan (Awal: 16)",
        JumpHolder = "Atur Lompatan (Awal: 50)",
        GravHolder = "Atur Gravitasi (Awal: 196.2)",
        KeepStats = "TAHAN STATUS (ANTI-RESET)",
        EmoteHolder = "Masukkan ID Animasi...",
        EmoteBtn = "PUTAR ANIMASI",
        Searching = "Mencari...",
        NotFound = "Tidak Ditemukan!",
        HeadlessActive = "KEPALA HILANG AKTIF!",
        DisasterTitle = "BENCANA TERDETEKSI!",
        DisasterDesc = "Tsunami datang! Segera pergi ke tempat tinggi!",
        InvalidID = "ID Tidak Valid!",
        OpenMusic = "BUKA PEMUTAR MUSIK",
        SearchMusic = "Cari Musik...",
        Playing = "Memutar"
    },
    ES = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "IDIOMA: ESPAÑOL",
        CloneHolder = "Ingrese Nombre de Usuario...",
        CloneBtn = "CLONAR AVATAR",
        HeadlessBtn = "ACTIVAR SIN CABEZA",
        StatsToggle = "MOSTRAR FPS/PING/CPS",
        AntiFling = "ANTI VUELO (SIN COLISIÓN)",
        NDSBtn = "PROBAR ALERTA",
        SpeedHolder = "Velocidad (Def: 16)",
        JumpHolder = "Salto (Def: 50)",
        GravHolder = "Gravedad (Def: 196.2)",
        KeepStats = "MANTENER STATS",
        EmoteHolder = "Ingrese ID de Animación...",
        EmoteBtn = "REPRODUCIR ANIMACIÓN",
        Searching = "Buscando...",
        NotFound = "¡No Encontrado!",
        HeadlessActive = "¡SIN CABEZA ACTIVO!",
        DisasterTitle = "¡DESASTRE DETECTADO!",
        DisasterDesc = "¡Tsunami en camino! ¡Sube a un lugar alto!",
        InvalidID = "¡ID Inválido!",
        OpenMusic = "ABRIR REPRODUCTOR",
        SearchMusic = "Buscar Música...",
        Playing = "Reproduciendo"
    },
    JP = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "言語: 日本語",
        CloneHolder = "ユーザー名を入力...",
        CloneBtn = "アバターをクローン",
        HeadlessBtn = "ヘッドレスを有効化",
        StatsToggle = "FPS/PINGを表示",
        AntiFling = "アンチフリング",
        NDSBtn = "災害ポップアップ",
        SpeedHolder = "歩行速度 (標準: 16)",
        JumpHolder = "ジャンプ力 (標準: 50)",
        GravHolder = "重力 (標準: 196.2)",
        KeepStats = "ステータス維持",
        EmoteHolder = "アニメーションID...",
        EmoteBtn = "アニメーション再生",
        Searching = "検索中...",
        NotFound = "見つかりません!",
        HeadlessActive = "ヘッドレス有効!",
        DisasterTitle = "災害検知!",
        DisasterDesc = "津波が来ます！すぐに高台へ！",
        InvalidID = "無効なID!",
        OpenMusic = "音楽プレーヤーを開く",
        SearchMusic = "音楽を検索...",
        Playing = "再生中"
    },
    RU = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "ЯЗЫК: РУССКИЙ",
        CloneHolder = "Введите имя пользователя...",
        CloneBtn = "КЛОНИРОВАТЬ АВАТАР",
        HeadlessBtn = "БЕЗ ГОЛОВЫ",
        StatsToggle = "ПОКАЗАТЬ FPS/PING/CPS",
        AntiFling = "АНТИ-ПОЛЕТ",
        NDSBtn = "ТЕСТ УВЕДОМЛЕНИЯ",
        SpeedHolder = "Скорость (Станд: 16)",
        JumpHolder = "Прыжок (Станд: 50)",
        GravHolder = "Гравитация (Станд: 196.2)",
        KeepStats = "АВТО-СОХРАНЕНИЕ",
        EmoteHolder = "Введите ID анимации...",
        EmoteBtn = "ВОСПРОИЗВЕСТИ",
        Searching = "Поиск...",
        NotFound = "Не найдено!",
        HeadlessActive = "БЕЗ ГОЛОВЫ АКТИВНО!",
        DisasterTitle = "БЕДСТВИЕ!",
        DisasterDesc = "Приближается цунами! На возвышенность!",
        InvalidID = "Неверный ID!",
        OpenMusic = "ОТКРЫТЬ ПЛЕЕР",
        SearchMusic = "Поиск музыки...",
        Playing = "Играет"
    }
}

local LocalizedElements = {}

local function RegisterLang(instance, key, isPlaceholder)
    table.insert(LocalizedElements, {Element = instance, Key = key, IsPlaceholder = isPlaceholder})
    local langData = Translations[Languages[CurrentLangIndex]]
    if isPlaceholder then
        instance.PlaceholderText = langData[key]
    else
        instance.Text = langData[key]
    end
end

local function UpdateAllLanguage()
    local langData = Translations[Languages[CurrentLangIndex]]
    for _, item in pairs(LocalizedElements) do
        if item.IsPlaceholder then
            item.Element.PlaceholderText = langData[item.Key]
        else
            item.Element.Text = langData[item.Key]
        end
    end
end

local function GetString(key)
    return Translations[Languages[CurrentLangIndex]][key]
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "XayzPanelLite"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 380, 0, 500)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local Topbar = Instance.new("Frame")
Topbar.Size = UDim2.new(1, 0, 0, 40)
Topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Topbar.BorderSizePixel = 0
Topbar.ZIndex = 10
Topbar.Parent = MainFrame

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local TopbarHider = Instance.new("Frame")
TopbarHider.Size = UDim2.new(1, 0, 0, 10)
TopbarHider.Position = UDim2.new(0, 0, 1, -10)
TopbarHider.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
TopbarHider.BorderSizePixel = 0
TopbarHider.ZIndex = 10
TopbarHider.Parent = Topbar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 200)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.ZIndex = 10
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Topbar
RegisterLang(Title, "Title", false)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.ZIndex = 10
CloseBtn.Parent = Topbar

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 40, 0, 40)
MinBtn.Position = UDim2.new(1, -80, 0, 0)
MinBtn.BackgroundTransparency = 1
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.ZIndex = 10
MinBtn.Parent = Topbar

local MainMenuFrame = Instance.new("Frame")
MainMenuFrame.Size = UDim2.new(1, 0, 1, -40)
MainMenuFrame.Position = UDim2.new(0, 0, 0, 40)
MainMenuFrame.BackgroundTransparency = 1
MainMenuFrame.Parent = MainFrame

local ScrollMenu = Instance.new("ScrollingFrame")
ScrollMenu.Size = UDim2.new(1, -20, 1, -10)
ScrollMenu.Position = UDim2.new(0, 10, 0, 5)
ScrollMenu.BackgroundTransparency = 1
ScrollMenu.ScrollBarThickness = 4
ScrollMenu.CanvasSize = UDim2.new(0, 0, 0, 900)
ScrollMenu.Parent = MainMenuFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollMenu

local function CreateButton(langKey, color, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    RegisterLang(btn, langKey, false)
    
    return btn
end

local function CreateTextBox(langKey, parent)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, -10, 0, 40)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = box
    
    RegisterLang(box, langKey, true)
    
    return box
end

local function CreateToggle(langKey, parent)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 40)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    toggleFrame.Parent = parent
    
    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(0, 6)
    corner1.Parent = toggleFrame
    
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 15, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = toggleFrame
    RegisterLang(lbl, langKey, false)
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 25)
    btn.Position = UDim2.new(1, -75, 0.5, -12.5)
    btn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    btn.Text = "OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.Parent = toggleFrame
    
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 6)
    corner2.Parent = btn
    
    return btn
end

local LanguageBtn = CreateButton("LangBtn", Color3.fromRGB(100, 100, 100), ScrollMenu)
local OpenMusicBtn = CreateButton("OpenMusic", Color3.fromRGB(30, 215, 96), ScrollMenu) 
local Section1 = CreateTextBox("CloneHolder", ScrollMenu)
local CloneBtn = CreateButton("CloneBtn", Color3.fromRGB(0, 150, 255), ScrollMenu)
local HeadlessBtn = CreateButton("HeadlessBtn", Color3.fromRGB(150, 50, 255), ScrollMenu)
local StatsToggleBtn = CreateToggle("StatsToggle", ScrollMenu)
local AntiFlingToggleBtn = CreateToggle("AntiFling", ScrollMenu)
local NDSBtn = CreateButton("NDSBtn", Color3.fromRGB(255, 150, 0), ScrollMenu)
local SpeedInput = CreateTextBox("SpeedHolder", ScrollMenu)
local JumpInput = CreateTextBox("JumpHolder", ScrollMenu)
local GravInput = CreateTextBox("GravHolder", ScrollMenu)
local ModsToggleBtn = CreateToggle("KeepStats", ScrollMenu)
local EmoteInput = CreateTextBox("EmoteHolder", ScrollMenu)
local EmoteBtn = CreateButton("EmoteBtn", Color3.fromRGB(0, 200, 100), ScrollMenu)

local AudioPlayer = Instance.new("Sound")
AudioPlayer.Parent = CoreGui

local MusicFrame = Instance.new("Frame")
MusicFrame.Size = UDim2.new(1, 0, 1, -40)
MusicFrame.Position = UDim2.new(1, 0, 0, 40)
MusicFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MusicFrame.BorderSizePixel = 0
MusicFrame.ZIndex = 5
MusicFrame.Parent = MainFrame

local BackBtn = Instance.new("TextButton")
BackBtn.Size = UDim2.new(0, 40, 0, 40)
BackBtn.Position = UDim2.new(0, 10, 0, 10)
BackBtn.BackgroundTransparency = 1
BackBtn.Text = "<"
BackBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
BackBtn.Font = Enum.Font.GothamBold
BackBtn.TextSize = 24
BackBtn.ZIndex = 6
BackBtn.Parent = MusicFrame

local SearchContainer = Instance.new("Frame")
SearchContainer.Size = UDim2.new(1, 0, 1, 0)
SearchContainer.BackgroundTransparency = 1
SearchContainer.ZIndex = 5
SearchContainer.Parent = MusicFrame

local MusicSearchBox = Instance.new("TextBox")
MusicSearchBox.Size = UDim2.new(1, -80, 0, 40)
MusicSearchBox.Position = UDim2.new(0, 60, 0, 10)
MusicSearchBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MusicSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MusicSearchBox.Font = Enum.Font.Gotham
MusicSearchBox.TextSize = 14
MusicSearchBox.ZIndex = 6
MusicSearchBox.Parent = SearchContainer

local MusicSearchCorner = Instance.new("UICorner")
MusicSearchCorner.CornerRadius = UDim.new(1, 0)
MusicSearchCorner.Parent = MusicSearchBox
RegisterLang(MusicSearchBox, "SearchMusic", true)

local MusicListScroll = Instance.new("ScrollingFrame")
MusicListScroll.Size = UDim2.new(1, -20, 1, -70)
MusicListScroll.Position = UDim2.new(0, 10, 0, 60)
MusicListScroll.BackgroundTransparency = 1
MusicListScroll.ScrollBarThickness = 2
MusicListScroll.ZIndex = 6
MusicListScroll.Parent = SearchContainer

local MusicListLayout = Instance.new("UIListLayout")
MusicListLayout.Padding = UDim.new(0, 5)
MusicListLayout.Parent = MusicListScroll

local NowPlayingContainer = Instance.new("Frame")
NowPlayingContainer.Size = UDim2.new(1, 0, 1, 0)
NowPlayingContainer.Position = UDim2.new(1, 0, 0, 0)
NowPlayingContainer.BackgroundTransparency = 1
NowPlayingContainer.ZIndex = 5
NowPlayingContainer.Parent = MusicFrame

local AlbumArt = Instance.new("ImageLabel")
AlbumArt.Size = UDim2.new(0, 200, 0, 200)
AlbumArt.Position = UDim2.new(0.5, -100, 0, 50)
AlbumArt.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AlbumArt.Image = "rbxassetid://6031097225"
AlbumArt.ZIndex = 6
AlbumArt.Parent = NowPlayingContainer

local AlbumArtCorner = Instance.new("UICorner")
AlbumArtCorner.CornerRadius = UDim.new(0, 10)
AlbumArtCorner.Parent = AlbumArt

local SongTitleLbl = Instance.new("TextLabel")
SongTitleLbl.Size = UDim2.new(1, -40, 0, 30)
SongTitleLbl.Position = UDim2.new(0, 20, 0, 270)
SongTitleLbl.BackgroundTransparency = 1
SongTitleLbl.Text = "Song Title ♬𖦤"
SongTitleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
SongTitleLbl.Font = Enum.Font.GothamBold
SongTitleLbl.TextSize = 20
SongTitleLbl.ZIndex = 6
SongTitleLbl.Parent = NowPlayingContainer

local ProgressBg = Instance.new("Frame")
ProgressBg.Size = UDim2.new(1, -60, 0, 4)
ProgressBg.Position = UDim2.new(0, 30, 0, 330)
ProgressBg.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ProgressBg.BorderSizePixel = 0
ProgressBg.ZIndex = 6
ProgressBg.Parent = NowPlayingContainer

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressFill.BorderSizePixel = 0
ProgressFill.ZIndex = 7
ProgressFill.Parent = ProgressBg

local ProgressBall = Instance.new("Frame")
ProgressBall.Size = UDim2.new(0, 12, 0, 12)
ProgressBall.Position = UDim2.new(1, -6, 0.5, -6)
ProgressBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ProgressBall.ZIndex = 8
ProgressBall.Parent = ProgressFill

local ProgressBallCorner = Instance.new("UICorner")
ProgressBallCorner.CornerRadius = UDim.new(1, 0)
ProgressBallCorner.Parent = ProgressBall

local PrevBtn = Instance.new("TextButton")
PrevBtn.Size = UDim2.new(0, 40, 0, 40)
PrevBtn.Position = UDim2.new(0.5, -90, 0, 360)
PrevBtn.BackgroundTransparency = 1
PrevBtn.Text = "⏮"
PrevBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PrevBtn.Font = Enum.Font.GothamBold
PrevBtn.TextSize = 18
PrevBtn.ZIndex = 6
PrevBtn.Parent = NowPlayingContainer

local PlayPauseBtn = Instance.new("TextButton")
PlayPauseBtn.Size = UDim2.new(0, 50, 0, 50)
PlayPauseBtn.Position = UDim2.new(0.5, -25, 0, 355)
PlayPauseBtn.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
PlayPauseBtn.Text = "❚❚"
PlayPauseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
PlayPauseBtn.Font = Enum.Font.GothamBold
PlayPauseBtn.TextSize = 20
PlayPauseBtn.ZIndex = 6
PlayPauseBtn.Parent = NowPlayingContainer

local PlayPauseCorner = Instance.new("UICorner")
PlayPauseCorner.CornerRadius = UDim.new(1, 0)
PlayPauseCorner.Parent = PlayPauseBtn

local StopBtn = Instance.new("TextButton")
StopBtn.Size = UDim2.new(0, 30, 0, 30)
StopBtn.Position = UDim2.new(0.5, -135, 0, 365)
StopBtn.BackgroundTransparency = 1
StopBtn.Text = "█"
StopBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextSize = 18
StopBtn.ZIndex = 6
StopBtn.Parent = NowPlayingContainer

local NextBtn = Instance.new("TextButton")
NextBtn.Size = UDim2.new(0, 40, 0, 40)
NextBtn.Position = UDim2.new(0.5, 50, 0, 360)
NextBtn.BackgroundTransparency = 1
NextBtn.Text = "⏭"
NextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NextBtn.Font = Enum.Font.GothamBold
NextBtn.TextSize = 18
NextBtn.ZIndex = 6
NextBtn.Parent = NowPlayingContainer

local CurrentSongIndex = 1
local IsInPlayerView = false

local function LoadMusicList(filter)
    for _, child in pairs(MusicListScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local count = 0
    for index, song in pairs(AudioLibrary) do
        if filter == "" or string.find(string.lower(song.Name), string.lower(filter)) then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 50)
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            btn.Text = "  " .. song.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.ZIndex = 6
            btn.Parent = MusicListScroll
            
            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                CurrentSongIndex = index
                AudioPlayer.SoundId = "rbxassetid://" .. song.ID
                AudioPlayer:Play()
                SongTitleLbl.Text = song.Name
                PlayPauseBtn.Text = "||"
                
                IsInPlayerView = true
                TweenService:Create(SearchContainer, TweenInfo.new(0.3), {Position = UDim2.new(-1, 0, 0, 0)}):Play()
                TweenService:Create(NowPlayingContainer, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            end)
            count = count + 1
        end
    end
    MusicListScroll.CanvasSize = UDim2.new(0, 0, 0, count * 55)
end

LoadMusicList("")

MusicSearchBox.Changed:Connect(function(prop)
    if prop == "Text" then
        LoadMusicList(MusicSearchBox.Text)
    end
end)

OpenMusicBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainMenuFrame, TweenInfo.new(0.3), {Position = UDim2.new(-1, 0, 0, 40)}):Play()
    TweenService:Create(MusicFrame, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 40)}):Play()
end)

BackBtn.MouseButton1Click:Connect(function()
    if IsInPlayerView then
        IsInPlayerView = false
        TweenService:Create(SearchContainer, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        TweenService:Create(NowPlayingContainer, TweenInfo.new(0.3), {Position = UDim2.new(1, 0, 0, 0)}):Play()
    else
        TweenService:Create(MusicFrame, TweenInfo.new(0.3), {Position = UDim2.new(1, 0, 0, 40)}):Play()
        TweenService:Create(MainMenuFrame, TweenInfo.new(0.3), {Position = UDim2.new(0, 0, 0, 40)}):Play()
    end
end)

PlayPauseBtn.MouseButton1Click:Connect(function()
    if AudioPlayer.IsPlaying then
        AudioPlayer:Pause()
        PlayPauseBtn.Text = "▶︎"
    else
        AudioPlayer:Resume()
        PlayPauseBtn.Text = "❚❚"
    end
end)

StopBtn.MouseButton1Click:Connect(function()
    AudioPlayer:Stop()
    PlayPauseBtn.Text = "▶︎"
end)

local function PlayIndex(index)
    if index > #AudioLibrary then
        index = 1
    elseif index < 1 then
        index = #AudioLibrary
    end
    CurrentSongIndex = index
    local song = AudioLibrary[index]
    AudioPlayer.SoundId = "rbxassetid://" .. song.ID
    AudioPlayer:Play()
    SongTitleLbl.Text = song.Name
    PlayPauseBtn.Text = "❚❚"
end

NextBtn.MouseButton1Click:Connect(function()
    PlayIndex(CurrentSongIndex + 1)
end)

PrevBtn.MouseButton1Click:Connect(function()
    PlayIndex(CurrentSongIndex - 1)
end)

RunService.RenderStepped:Connect(function()
    if AudioPlayer.IsLoaded and AudioPlayer.TimeLength > 0 then
        local progress = AudioPlayer.TimePosition / AudioPlayer.TimeLength
        ProgressFill.Size = UDim2.new(progress, 0, 1, 0)
    else
        ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    end
end)

MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 380, 0, 500)}):Play()

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    AudioPlayer:Destroy()
end)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 380, 0, 40)}):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3), {Size = UDim2.new(0, 380, 0, 500)}):Play()
    end
end)

LanguageBtn.MouseButton1Click:Connect(function()
    CurrentLangIndex = CurrentLangIndex + 1
    if CurrentLangIndex > #Languages then
        CurrentLangIndex = 1
    end
    UpdateAllLanguage()
end)

CloneBtn.MouseButton1Click:Connect(function()
    local targetName = Section1.Text
    if targetName == "" then
        return
    end
    CloneBtn.Text = GetString("Searching")
    
    local success, userId = pcall(function()
        return Players:GetUserIdFromNameAsync(targetName)
    end)
    
    if success and userId then
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            local desc = Players:GetHumanoidDescriptionFromUserId(userId)
            humanoid:ApplyDescription(desc)
            CloneBtn.Text = GetString("CloneBtn")
        end
    else
        CloneBtn.Text = GetString("NotFound")
        task.wait(2)
        CloneBtn.Text = GetString("CloneBtn")
    end
end)

HeadlessBtn.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        char.Head.Transparency = 1
        if char.Head:FindFirstChild("face") then
            char.Head.face:Destroy()
        end
        if char.Head:FindFirstChildOfClass("SpecialMesh") then
            char.Head:FindFirstChildOfClass("SpecialMesh"):Destroy()
        end
        HeadlessBtn.Text = GetString("HeadlessActive")
        task.wait(2)
        HeadlessBtn.Text = GetString("HeadlessBtn")
    end
end)

local StatsHUD = Instance.new("Frame")
StatsHUD.Size = UDim2.new(0, 140, 0, 90)
StatsHUD.Position = UDim2.new(1, -150, 0, 20)
StatsHUD.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
StatsHUD.BackgroundTransparency = 0.4
StatsHUD.Visible = false
StatsHUD.Parent = ScreenGui

local StatsHUDCorner = Instance.new("UICorner")
StatsHUDCorner.CornerRadius = UDim.new(0, 8)
StatsHUDCorner.Parent = StatsHUD

local function CreateStatLabel(text, posY, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 25)
    lbl.Position = UDim2.new(0, 10, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = StatsHUD
    return lbl
end

local FPSText = CreateStatLabel("FPS: 0", 5, Color3.fromRGB(0, 255, 100))
local PingText = CreateStatLabel("PING: 0 ms", 32, Color3.fromRGB(255, 200, 0))
local CPSText = CreateStatLabel("CPS: 0", 59, Color3.fromRGB(0, 200, 255))

local statsEnabled = false
local clicks = {}

StatsToggleBtn.MouseButton1Click:Connect(function()
    statsEnabled = not statsEnabled
    if statsEnabled then
        StatsToggleBtn.Text = "ON"
        StatsToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    else
        StatsToggleBtn.Text = "OFF"
        StatsToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
    StatsHUD.Visible = statsEnabled
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
        table.insert(clicks, tick())
    end
end)

local keepStats = false
local customWS = 16
local customJP = 50
local customGrav = 196.2

ModsToggleBtn.MouseButton1Click:Connect(function()
    keepStats = not keepStats
    if keepStats then
        ModsToggleBtn.Text = "ON"
        ModsToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    else
        ModsToggleBtn.Text = "OFF"
        ModsToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
    
    if tonumber(SpeedInput.Text) then
        customWS = tonumber(SpeedInput.Text)
    end
    if tonumber(JumpInput.Text) then
        customJP = tonumber(JumpInput.Text)
    end
    if tonumber(GravInput.Text) then
        customGrav = tonumber(GravInput.Text)
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    if statsEnabled then
        FPSText.Text = "FPS: " .. tostring(math.floor(1 / deltaTime))
        local ping = 0
        pcall(function()
            ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
        PingText.Text = "PING: " .. tostring(ping) .. " ms"
        
        local currentTick = tick()
        for i = #clicks, 1, -1 do
            if currentTick - clicks[i] > 1 then
                table.remove(clicks, i)
            end
        end
        CPSText.Text = "CPS: " .. tostring(#clicks)
    end
    
    if keepStats then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = customWS
            char.Humanoid.UseJumpPower = true
            char.Humanoid.JumpPower = customJP
            Workspace.Gravity = customGrav
        end
    end
end)

local antiFling = false
AntiFlingToggleBtn.MouseButton1Click:Connect(function()
    antiFling = not antiFling
    if antiFling then
        AntiFlingToggleBtn.Text = "ON"
        AntiFlingToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    else
        AntiFlingToggleBtn.Text = "OFF"
        AntiFlingToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

RunService.Stepped:Connect(function()
    if antiFling then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end
end)

local function ShowModernNotification(title, desc, duration)
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.new(0, 300, 0, 80)
    NotifFrame.Position = UDim2.new(0.5, -150, 0, -100)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    NotifFrame.Parent = ScreenGui
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 8)
    NotifCorner.Parent = NotifFrame
    
    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Size = UDim2.new(1, -20, 0, 30)
    TitleLbl.Position = UDim2.new(0, 10, 0, 5)
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.TextColor3 = Color3.fromRGB(255, 200, 0)
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextSize = 16
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.Parent = NotifFrame
    
    local DescLbl = Instance.new("TextLabel")
    DescLbl.Size = UDim2.new(1, -20, 0, 40)
    DescLbl.Position = UDim2.new(0, 10, 0, 35)
    DescLbl.BackgroundTransparency = 1
    DescLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    DescLbl.Font = Enum.Font.Gotham
    DescLbl.TextSize = 14
    DescLbl.TextWrapped = true
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.Parent = NotifFrame
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -150, 0, 50)}):Play()
    
    task.spawn(function()
        for i = duration, 1, -1 do
            TitleLbl.Text = "⚠️ " .. title .. " (" .. i .. "s)"
            task.wait(1)
        end
        TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -150, 0, -100)}):Play()
        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

NDSBtn.MouseButton1Click:Connect(function()
    ShowModernNotification(GetString("DisasterTitle"), GetString("DisasterDesc"), 10)
end)

local currentAnimTrack = nil
EmoteBtn.MouseButton1Click:Connect(function()
    local animId = EmoteInput.Text
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") or animId == "" then
        return
    end
    
    local numericId = string.match(animId, "%d+")
    if not numericId then
        return
    end
    
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. numericId
    local humanoid = char:FindFirstChild("Humanoid")
    
    if currentAnimTrack then
        currentAnimTrack:Stop()
    end
    
    local success, err = pcall(function()
        local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
        currentAnimTrack = animator:LoadAnimation(anim)
        currentAnimTrack:Play()
    end)
    
    if not success then
        EmoteBtn.Text = GetString("InvalidID")
        task.wait(2)
        EmoteBtn.Text = GetString("EmoteBtn")
    end
end)