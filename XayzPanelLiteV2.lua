local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local AudioLibrary = {
    {
        Name = "Chill Electronic",
        ID = 9048375035
    },
    {
        Name = "Upbeat Pop",
        ID = 9037463698
    },
    {
        Name = "Action Synth",
        ID = 9046863332
    },
    {
        Name = "Lofi Study",
        ID = 9043887091
    },
    {
        Name = "Epic Boss Fight",
        ID = 9047100551
    },
    {
        Name = "BRAZILIAN PHONK",
        ID = 85635811474451
    },
    {
        Name = "67 KID PHONK",
        ID = 125476440612900
    },
    {
        Name = "PHONK DRIFT",
        ID = 72653741821355
    },
    {
        Name = "FUNK INFERNA V2 Phonk (Deep Slowed)",
        ID = 86375151296706
    },
    {
        Name = "Psycho Phonk Slay",
        ID = 105100211445392
    },
    {
        Name = "AB4T",
        ID = 17422173467
    },
    {
        Name = "Above Phonk",
        ID = 89824897586105
    },
    {
        Name = "Alanwaad",
        ID = 17422074849
    },
    {
        Name = "Analog Vibes",
        ID = 138801603792399
    },
    {
        Name = "Assassin's Ride",
        ID = 73326647630445
    },
    {
        Name = "Back & Front",
        ID = 14145627474
    },
    {
        Name = "Bell Pepper",
        ID = 14145626111
    },
    {
        Name = "Black Seed",
        ID = 14145622615
    },
    {
        Name = "Blackout Drift",
        ID = 85290495098172
    },
    {
        Name = "Bloody Phonk",
        ID = 136350225160627
    },
    {
        Name = "Brazil Fiesta",
        ID = 125498129824026
    },
    {
        Name = "Breathing",
        ID = 137940368194253
    },
    {
        Name = "Burn the Night",
        ID = 136579058345590
    },
    {
        Name = "Chill Phonk",
        ID = 136974179670066
    },
    {
        Name = "Cowbell God",
        ID = 16190760005
    },
    {
        Name = "Dark Phonk Damage",
        ID = 105529482486905
    },
    {
        Name = "Desprezo",
        ID = 139435437308948
    },
    {
        Name = "Dionic",
        ID = 15689445424
    },
    {
        Name = "Don't Stop",
        ID = 135916877300061
    },
    {
        Name = "Down2Kill",
        ID = 16190760285
    },
    {
        Name = "Drooly",
        ID = 8053389869
    },
    {
        Name = "DTI Phonk",
        ID = 139161205970637
    },
    {
        Name = "Emotional Damage",
        ID = 14145621151
    },
    {
        Name = "End the Soft",
        ID = 93203762220779
    },
    {
        Name = "F-Phonk",
        ID = 101326109963284
    },
    {
        Name = "Funk Fiesta",
        ID = 139959590610806
    },
    {
        Name = "Fusion",
        ID = 136062265232554
    },
    {
        Name = "Gabbermix",
        ID = 18841887539
    },
    {
        Name = "Ghostblade Phonk",
        ID = 90441404910975
    },
    {
        Name = "Ghostly Stream",
        ID = 137589724762757
    },
    {
        Name = "Gigachand Phonk",
        ID = 134366188285514
    },
    {
        Name = "Hellfire Highway",
        ID = 136757074728111
    },
    {
        Name = "Heptraxous",
        ID = 8185857772
    },
    {
        Name = "HR -Eeyuh",
        ID = 16190782181
    },
    {
        Name = "Infinite",
        ID = 16190784875
    },
    {
        Name = "Invade Groom",
        ID = 15689453529
    },
    {
        Name = "Ladylike",
        ID = 139783457310815
    },
    {
        Name = "Last Hope",
        ID = 137436868877550
    },
    {
        Name = "Lost Phonk",
        ID = 139266399633943
    },
    {
        Name = "Low Down",
        ID = 137787889626447
    },
    {
        Name = "Mad Phonk",
        ID = 140274552295461
    },
    {
        Name = "Mad Phonk Energy",
        ID = 123636731441495
    },
    {
        Name = "Mad Phonk Pyscho",
        ID = 137599668691145
    },
    {
        Name = "Melancholy",
        ID = 138592111223571
    },
    {
        Name = "Metamorphosis",
        ID = 15689451063
    },
    {
        Name = "Metaverse",
        ID = 17422168798
    },
    {
        Name = "Monster Bass",
        ID = 14145623658
    },
    {
        Name = "Montagem",
        ID = 138682744064257
    },
    {
        Name = "No Brakes",
        ID = 135621572019998
    },
    {
        Name = "No Lights",
        ID = 14145623221
    },
    {
        Name = "Pac Man Phonk",
        ID = 120889371113999
    },
    {
        Name = "Phonk Da Rua",
        ID = 104596909675653
    },
    {
        Name = "Phonk Killaz",
        ID = 86179292245507
    },
    {
        Name = "Phonk of Darkness",
        ID = 116896498238234
    },
    {
        Name = "Phonk't Out",
        ID = 14145625743
    },
    {
        Name = "Pscyhopath",
        ID = 139333523265411
    },
    {
        Name = "Pure Phonk Violence",
        ID = 96461852889782
    },
    {
        Name = "Quando",
        ID = 137705500872153
    },
    {
        Name = "Raging Blood",
        ID = 138239009909667
    },
    {
        Name = "Raven Theme",
        ID = 14145621445
    },
    {
        Name = "Raw",
        ID = 139815305627554
    },
    {
        Name = "Raw Phonk Energy",
        ID = 135549022646779
    },
    {
        Name = "Reckless Drift Run",
        ID = 83348506277910
    },
    {
        Name = "Redemption",
        ID = 16190783774
    },
    {
        Name = "Reforest Glitch",
        ID = 138379611912655
    },
    {
        Name = "Robo Phonk",
        ID = 136932193331774
    },
    {
        Name = "Savage Slay Phonk",
        ID = 71837666565538
    },
    {
        Name = "Silicon Heartbeat",
        ID = 136954753954258
    },
    {
        Name = "Sinistra",
        ID = 15689443663
    },
    {
        Name = "Soul Crusher's Ride",
        ID = 120296689321275
    },
    {
        Name = "Stupid Remix",
        ID = 16662833837
    },
    {
        Name = "The Final Phonk",
        ID = 14145620056
    },
    {
        Name = "Twisted Killer Flow",
        ID = 89198968265350
    },
    {
        Name = "Ultima",
        ID = 16190756998
    },
    {
        Name = "Unbreakable",
        ID = 14145626744
    },
    {
        Name = "Uzipack",
        ID = 18841894272
    },
    {
        Name = "Vozes De Anjo",
        ID = 138399043067580
    },
    {
        Name = "Wasn V2",
        ID = 106495464414175
    },
    {
        Name = "Wassa",
        ID = 17422207260
    },
    {
        Name = "Die With A Smile - Lady Gaga & Bruno Mars",
        ID = 9175675404
    },
    {
        Name = "APT. - ROSE & Bruno Mars",
        ID = 9162822014
    },
    {
        Name = "A Bar Song (Tipsy) - Shaboozey",
        ID = 9019426415
    },
    {
        Name = "BIRDS OF A FEATHER - Billie Eilish",
        ID = 9025309340
    },
    {
        Name = "Lose Control - Teddy Swims",
        ID = 8998705678
    },
    {
        Name = "Luther - Kendrick Lamar & SZA",
        ID = 9047574337
    },
    {
        Name = "As It Was - Harry Styles",
        ID = 9128660909
    },
    {
        Name = "Stay - The Kid LAROI & Justin Bieber",
        ID = 6991475693
    },
    {
        Name = "Blinding Lights - The Weeknd",
        ID = 5028637536
    },
    {
        Name = "Savage Love - Jason Derulo",
        ID = 4640671238
    },
    {
        Name = "Steve's Lava Chicken",
        ID = 94446515790251
    },
    {
        Name = "Raining Tacos",
        ID = 142376088
    },
    {
        Name = "Metal Pipe Falling",
        ID = 6729922069
    },
    {
        Name = "Emotional Damage (Steven He)",
        ID = 8362816791
    },
    {
        Name = "Deku Sussy Baka",
        ID = 6537919656
    },
    {
        Name = "Thomas The Train Remix",
        ID = 642935512
    },
    {
        Name = "Deja Vu (Initial D)",
        ID = 4285827657
    },
    {
        Name = "SpongeBob Theme",
        ID = 318925857
    },
    {
        Name = "Wii Sports Theme",
        ID = 3106656207
    },
    {
        Name = "FUS RO DAH!!!",
        ID = 130776150
    },
    {
        Name = "God's Plan - Drake",
        ID = 1665926924
    },
    {
        Name = "Industry Baby - Lil Nas X",
        ID = 7253841629
    },
    {
        Name = "Lucid Dreams - Juice WRLD",
        ID = 8036100972
    },
    {
        Name = "Stronger - Kanye West",
        ID = 136209425
    },
    {
        Name = "Tokyo Drift - Teriyaki Boyz",
        ID = 1837015626
    },
    {
        Name = "SAD GIRLZ LUV MONEY - Amaarae",
        ID = 8026236684
    },
    {
        Name = "Heat Waves - Glass Animals",
        ID = 6432181830
    },
    {
        Name = "Dress to Impress Phonk",
        ID = 139161205970637
    },
    {
        Name = "Skibidi Toilet Phonk",
        ID = 122863102226559
    },
    {
        Name = "Brazilian Phonk (Bass Heavy)",
        ID = 108621585736031
    },
    {
        Name = "Fade - Alan Walker",
        ID = 292315830
    },
    {
        Name = "Spectre - Alan Walker",
        ID = 313726644
    },
    {
        Name = "Dreams - Lost Sky",
        ID = 7547342615
    },
    {
        Name = "Candyland - Tobu",
        ID = 118939739460633
    },
    {
        Name = "Sunburst - Tobu",
        ID = 121336636707861
    },
    {
        Name = "Silent Forest Ambient",
        ID = 81821734193614
    },
    {
        Name = "Tokyo Machine - PLAY",
        ID = 5410085763
    },
    {
        Name = "Clair de Lune",
        ID = 1838457617
    },
    {
        Name = "Fur Elise",
        ID = 450051032
    },
    {
        Name = "Moonlight Sonata",
        ID = 445023353
    },
    {
        Name = "Gymnopedie No. 1",
        ID = 9045766377
    },
    {
        Name = "Better Call Saul Theme",
        ID = 9106904975
    },
    {
        Name = "Squid Game Theme",
        ID = 7535587224
    },
    {
        Name = "Mii Channel Music",
        ID = 143666548
    },
    {
        Name = "Spider-Man Black Suit",
        ID = 9108472930
    },
    {
        Name = "Who's That Pokemon?",
        ID = 130767090
    },
    {
        Name = "Team Fortress 2 Theme",
        ID = 166378555
    },
    {
        Name = "PHONK || GVIKXTSU - TOKYO DRIFT",
        ID = 5077810864
    },
    {
        Name = "Билли Джин (Phonk Edition)",
        ID = 5020637545
    },
    {
        Name = "Phonk | Japan Drift | Hard phonk",
        ID = 5569815928
    },
    {
        Name = "cowbell phonk",
        ID = 4802537905
    },
    {
        Name = "IGARASHI KANTA - IN A HOOD NEAR YOU",
        ID = 5341452861
    },
    {
        Name = "phonk 1",
        ID = 5430239955
    },
    {
        Name = "Phonk 2",
        ID = 5155225687
    },
    {
        Name = "PHONK GOD",
        ID = 1282047646
    },
    {
        Name = "PHONK PHONK YEA",
        ID = 3353217023
    },
    {
        Name = "Kaito Shoma - Scary Garry (Clean Version)",
        ID = 6468836696
    },
    {
        Name = "Phonk beat",
        ID = 4639821753
    },
    {
        Name = "Phonk 3",
        ID = 4856328587
    },
    {
        Name = "Phonk 4",
        ID = 6056177578
    },
    {
        Name = "Phonk 5",
        ID = 6198813202
    },
    {
        Name = "Saint Phonk",
        ID = 4711248332
    },
    {
        Name = "Gimme Gimme Gimme (Phonk)",
        ID = 5030657350
    },
    {
        Name = "Кит ты маму мав (phonk)",
        ID = 5569300394
    },
    {
        Name = "Phonk type beat cowbell",
        ID = 4642779401
    },
    {
        Name = "Смешарики - От винта (PHONK REMIX)",
        ID = 5422507571
    },
    {
        Name = "Phonk beat :D",
        ID = 2849963683
    },
    {
        Name = "tones and I - Bad Child",
        ID = 5315279926
    },
    {
        Name = "Everybody Loves An Outlaw - I See Red",
        ID = 5808184278
    },
    {
        Name = "Frank Ocean - Chanel",
        ID = 1725273277
    },
    {
        Name = "Kali Uchis - Telepatia (slowed and reverb)",
        ID = 6403599974
    },
    {
        Name = "Nya! Arigato",
        ID = 6441347468
    },
    {
        Name = "BTS - Fake Love",
        ID = 1894066752
    },
    {
        Name = "Dua Lipa - Levitating",
        ID = 6606223785
    },
    {
        Name = "Illijah - On My Way",
        ID = 249672730
    },
    {
        Name = "Chikatto Chika Chika",
        ID = 5937000690
    },
    {
        Name = "Casi - No Limit",
        ID = 748726200
    },
    {
        Name = "Kim Dracula - Paparazzi (Lady Gaga cover)",
        ID = 6177409271
    },
    {
        Name = "Doja Cat - Say So",
        ID = 521116871
    },
    {
        Name = "Tesher - Jalebi Baby",
        ID = 6463211475
    },
    {
        Name = "Capone - Oh No",
        ID = 5253604010
    },
    {
        Name = "Clairo - Sofia",
        ID = 5760198930
    },
    {
        Name = "2Pac - Life Goes On",
        ID = 186317099
    },
    {
        Name = "Royal & the Serpent - Overwhelmed",
        ID = 5595658625
    },
    {
        Name = "Tina Turner - What's Love Got to Do with It",
        ID = 5145539495
    },
    {
        Name = "Baby Bash ft. Frankie J - Suga Suga",
        ID = 225150067
    },
    {
        Name = "Taylor Swift - You Belong With Me",
        ID = 6159978466
    },
    {
        Name = "Studio Killers - Jenny",
        ID = 63735955004
    },
    {
        Name = "Laffy Taffy",
        ID = 5478866871
    },
    {
        Name = "Billie Eilish - Ocean Eyes",
        ID = 1321038120
    },
    {
        Name = "Billie Eilish - My Future",
        ID = 5622020090
    },
    {
        Name = "Maroon 5 - Payphone",
        ID = 131396974
    },
    {
        Name = "Lady Gaga - Applause",
        ID = 130964099
    },
    {
        Name = "Clean Bandit ft. Demi Lovato - Solo Remix",
        ID = 2106186490
    },
    {
        Name = "Maaron 5 - Girls Like You ft. Cardi B",
        ID = 2211976041
    },
    {
        Name = "Juice Wrld - Armed & Dangerous",
        ID = 2498066534
    },
    {
        Name = "Paulo Londra - Adan Y Eva",
        ID = 2637276471
    },
    {
        Name = "Ariana Grande - What Do You Mean One Last Time",
        ID = 360160735
    },
    {
        Name = "Hello darkness, my old friend",
        ID = 145045371
    },
    {
        Name = "Steven Universe - Stronger Than You",
        ID = 225999739
    },
    {
        Name = "The Song of The Dragonborn",
        ID = 138297303
    },
    {
        Name = "Ava Max - Sweet but Psycho",
        ID = 2529951321
    },
    {
        Name = "Alec Benjamin - The Water Fountain",
        ID = 615938297
    },
    {
        Name = "Undertale - Battle Against A True Hero",
        ID = 333552980
    },
    {
        Name = "Imagine Dragons - Radioactive",
        ID = 132826277
    },
    {
        Name = "Major Lazer & DJ Snake - Lean On",
        ID = 239533935
    },
    {
        Name = "Old Town Road",
        ID = 2862170886
    },
    {
        Name = "I'M BEAN, MR. BEAN SONG",
        ID = 947518032
    },
    {
        Name = "Eminem - Lose Yourself",
        ID = 5906295202
    },
    {
        Name = "Fade - Alan Walker (Versi 1)",
        ID = 348661804
    },
    {
        Name = "Nightcore - Alan walker - Alone",
        ID = 690128049
    },
    {
        Name = "Alan Walker - Alone",
        ID = 563602751
    },
    {
        Name = "Alan Walker - Fade (Versi 2)",
        ID = 279463893
    },
    {
        Name = "Alan Walker - Alone (Versi 2)",
        ID = 595922379
    },
    {
        Name = "Alan Walker - Fade [ Loop ]",
        ID = 389020916
    },
    {
        Name = "Alan Walkers The Spectre",
        ID = 2341234054
    },
    {
        Name = "Alan Walker - Spectre [1000 SALES!]",
        ID = 219506834
    },
    {
        Name = "Alan Walker - Force [NCS]",
        ID = 235509194
    },
    {
        Name = "Alan Walker - Force",
        ID = 279206936
    },
    {
        Name = "Alan Walker - Faded (Sep Remix)",
        ID = 466047335
    },
    {
        Name = "Alan walker faded",
        ID = 647977098
    },
    {
        Name = "Alan Walker - Fade (120 Sec)",
        ID = 297920627
    },
    {
        Name = "Alan Walker - Fade Piano Version",
        ID = 511905424
    },
    {
        Name = "Alan Walker - Routine",
        ID = 686514556
    },
    {
        Name = "Fade- Alan Walker(Loud)",
        ID = 397784170
    },
    {
        Name = "Alan Walker - Alone (Versi 3)",
        ID = 681903629
    },
    {
        Name = "Sing Me To Sleep - Alan Walker (ultimate remix)",
        ID = 473930460
    },
    {
        Name = "Alan Walker - 135",
        ID = 576481790
    },
    {
        Name = "Alan Walker - Fade [NCS Release] (Versi 2)",
        ID = 343744100
    },
    {
        Name = "Alan Walker - Fade [NCS Release] [FULL]",
        ID = 531158940
    },
    {
        Name = "Alan Walker - Faded (Osias Trap Remix)",
        ID = 365638345
    },
    {
        Name = "Alan Walker - New Heart",
        ID = 604107654
    },
    {
        Name = "Nightcore Faded (Alan WalkerLyrics)",
        ID = 585817132
    },
    {
        Name = "Alan Walker - Faded (Trap Remix)",
        ID = 698945367
    },
    {
        Name = "Obama sings Alan Walker - Faded",
        ID = 476185978
    },
    {
        Name = "Alan Walker - Fade (Versi 3)",
        ID = 468785462
    },
    {
        Name = "Alan Walker - Memories",
        ID = 479089458
    },
    {
        Name = "Alan Walker - Dennis 2014",
        ID = 656527673
    },
    {
        Name = "Alan Walker - Sing Me To Sleep (DOPEDROP Remix)",
        ID = 574259562
    },
    {
        Name = "Alan Walker - Faded (Sep Remix) 2",
        ID = 419901901
    },
    {
        Name = "Alan Walker - Hope",
        ID = 656519674
    },
    {
        Name = "Alan Walker - Memories 2",
        ID = 604106116
    },
    {
        Name = "Alan Walker- Faded (Edited)",
        ID = 588039699
    },
    {
        Name = "Alan Walker - Force (Versi 2)",
        ID = 233471598
    },
    {
        Name = "Alan Walker - Fade (Versi 4)",
        ID = 227475817
    },
    {
        Name = "Alan Walker - Flying dreams (2 min)",
        ID = 472494704
    },
    {
        Name = "Alan Walker - Faded (Instrumental)",
        ID = 468232574
    },
    {
        Name = "Alan Walker - Sing Me To Sleep (Instrumental)",
        ID = 444155664
    },
    {
        Name = "Alan Walker - Fade (Versi 5)",
        ID = 693428358
    },
    {
        Name = "Alan Walker - Faded Mix",
        ID = 421000798
    },
    {
        Name = "NightcoreFaded (Alan WalkerLyrics) 2",
        ID = 585799776
    },
    {
        Name = "Alan Walker - Force (Full Song)",
        ID = 644914256
    },
    {
        Name = "Alan Walker - Spectre (Versi 2)",
        ID = 279207008
    },
    {
        Name = "Alan Walkers - Lily",
        ID = 3144033802
    },
    {
        Name = "Alan Walker - Fade (Versi 6)",
        ID = 279206904
    },
    {
        Name = "Big universe - Alan Walker",
        ID = 604103411
    },
    {
        Name = "On my way - Alan Walker",
        ID = 3426464651
    },
    {
        Name = "Multo - Cup of Joe",
        ID = 118668717534464
    },
    {
        Name = "WHERE WE ARE",
        ID = 118538313029983
    },
    {
        Name = "Where We Are V2",
        ID = 117600599480279
    },
    {
        Name = "DEAF KEV - Invincible",
        ID = 259816079
    },
    {
        Name = "Lost Sky - Vision",
        ID = 3073775476
    },
    {
        Name = "Prismo - Weakness",
        ID = 696691506
    },
    {
        Name = "JJD - Future",
        ID = 1283379898
    },
    {
        Name = "Dirty Palm - Oblivion",
        ID = 1221704843
    },
    {
        Name = "WATEVA - Ber Zer Ker",
        ID = 2149254684
    },
    {
        Name = "Diamond Eyes - Everything",
        ID = 1613711615
    },
    {
        Name = "Electro-Light - Symbolism",
        ID = 948704371
    },
    {
        Name = "Prismo - Stronger",
        ID = 1384066755
    },
    {
        Name = "Robin Hustin - Light It Up feat Jex",
        ID = 2291227488
    },
    {
        Name = "Zaza - Be Together",
        ID = 599679668
    },
    {
        Name = "Diamond Eyes - Everything V2",
        ID = 163252235
    },
    {
        Name = "Alan Walker - Alone Chorus Loop",
        ID = 622599224
    },
    {
        Name = "Alan Walker - All Falls Down",
        ID = 1163496902
    },
    {
        Name = "Alan Walker - Alone We Rabbitz Remix",
        ID = 609066000
    },
    {
        Name = "Alan Walker - Spectre Piano SHORT",
        ID = 492155111
    },
    {
        Name = "Alan Walker - Faded Roial Remix",
        ID = 491520623
    },
    {
        Name = "Alan Walker and Sia - Faded Cheap remix",
        ID = 514515964
    },
    {
        Name = "Playful Massacre",
        ID = 115520764429413
    },
    {
        Name = "Smezir_2",
        ID = 99084314273118
    },
    {
        Name = "CLIMA LINDO",
        ID = 118507373399694
    },
    {
        Name = "bad apple",
        ID = 123572020022002
    },
    {
        Name = "DJ GOIB BLIZZARD",
        ID = 83788133229034
    },
    {
        Name = "Don't Let Me Down (Alan Walker)",
        ID = 84621839524281
    },
    {
        Name = "Don't Let Me Down (Alan Walker) V2",
        ID = 131797878133678
    },
    {
        Name = "Thunderclap (JJK)",
        ID = 103590461924679
    },
    {
        Name = "Waiting Room 2",
        ID = 127554829179688
    },
    {
        Name = "Hakari Dance Theme Private Pure Love Train",
        ID = 136208016606825
    },
    {
        Name = "Ai Dua Em Ve",
        ID = 114079764270779
    },
    {
        Name = "So retro forsaken music",
        ID = 114463678931188
    },
    {
        Name = "forsaken caramell music",
        ID = 123048251088564
    },
    {
        Name = "styleing gangnam",
        ID = 86468479687169
    },
    {
        Name = "Desperate Gamble",
        ID = 127012663233191
    },
    {
        Name = "Broken Stalls",
        ID = 100342664971650
    },
    {
        Name = "Infinite Void",
        ID = 131649240815291
    },
    {
        Name = "Cursed Showdown",
        ID = 101593085288560
    },
    {
        Name = "Vei Slay Solto",
        ID = 119824506266281
    },
    {
        Name = "AVAKIRI!",
        ID = 89750212764961
    },
    {
        Name = "PRESSAO BEM SOLTO (SLOWED)",
        ID = 120021246334271
    },
    {
        Name = "MONTAGEM CONMIDO",
        ID = 93461183313089
    },
    {
        Name = "FISSION (SPED UP)",
        ID = 134011921316879
    },
    {
        Name = "QUESTRO (SUPER SLOWED)",
        ID = 90675169478235
    },
    {
        Name = "FUNK FORTADA (SLOWED)",
        ID = 73351216000380
    },
    {
        Name = "BRUXANZION",
        ID = 110991416454626
    },
    {
        Name = "FUNK OSIGMA (SLOWED)",
        ID = 77659460864754
    },
    {
        Name = "BOOYA",
        ID = 101772318848071
    },
    {
        Name = "FUSION (ORIGINAL)",
        ID = 89180400948567
    },
    {
        Name = "NOVA LA NOCHE (ULTRA SLOWED)",
        ID = 94032061631217
    },
    {
        Name = "MELODIA DE VERAO (ULTRA SPED UP)",
        ID = 72844613532784
    },
    {
        Name = "FUSION (SLOWED)",
        ID = 92500405029901
    },
    {
        Name = "XENON",
        ID = 127502623565534
    },
    {
        Name = "FISSION (ORIGINAL)",
        ID = 118349786848415
    },
    {
        Name = "ESCALATE",
        ID = 85306184126616
    },
    {
        Name = "RESISTANCE TREINAMENTO (SLOWED)",
        ID = 139470412088097
    },
    {
        Name = "CRYSTAL LINK (SUPER SLOWED)",
        ID = 79400027040201
    },
    {
        Name = "UH BUFON VEI (OVER SLOWED)",
        ID = 133815463890793
    }
}

local DefaultLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient
}

local State = {
    Fly = false,
    FlySpeed = 1,
    Noclip = false,
    GodMode = false,
    InfJump = false,
    DoubleJump = false,
    Wallhop = false,
    Tornado = false,
    AntiAfk = true,
    SpeedEnabled = false,
    WalkSpeed = 16,
    JumpEnabled = false,
    JumpPower = 50,
    GravityEnabled = false,
    Gravity = 196.2,
    Freeze = false,
    JumpCount = 0,
    AutoClickerPlaying = false,
    AutoClickerSpeed = 0.5,
    Crosshair = false,
    CrosshairSpin = false,
    CrosshairRainbow = false,
    CrosshairRotation = 0,
    FullBright = false,
    Invisible = false,
    AntiFling = false,
    StatsHUD = false
}

local ClickPoints = {

}

local Languages = {
    "DEFAULT",
    "EN",
    "ID",
    "ES",
    "RU",
    "ZH",
    "JP",
    "FR",
    "DE",
    "PT",
    "IT",
    "KO",
    "AR",
    "HI",
    "TR",
    "VI",
    "TH",
    "PL",
    "NL",
    "UK",
    "TL",
    "MS",
    "SV",
    "CS",
    "HU",
    "RO",
    "FI",
    "DA",
    "NO",
    "EL",
    "BG"
}

local CurrentLangIndex = 1

local Translations = {
    DEFAULT = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "LANGUAGE: DEFAULT (RECOMMENDED)",
        TabMain = "PLAYER",
        TabVisual = "VISUAL",
        TabTools = "TOOLS",
        TabWorld = "WORLD",
        TabExec = "EXECUTOR",
        TabUlt = "ULTIMATE",
        TabMusic = "MUSIC",
        Fly = "Mobile Fly",
        FlySpeed = "Fly Speed (Def: 50)",
        InfJump = "Infinity Jump",
        DoubleJump = "Double Jump",
        Wallhop = "Wallhop",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Enable Speed",
        SetSpeed = "Set WalkSpeed",
        EnableJump = "Enable JumpPower",
        SetJump = "Set JumpPower",
        EnableGrav = "Enable Gravity",
        SetGrav = "Set Gravity",
        Freeze = "Freeze (Lag Switch)",
        GodMode = "God Mode",
        Noclip = "Noclip",
        Tornado = "Tornado (Aura)",
        Booster = "FPS Booster",
        Roshade = "Roshade (Real 4K)",
        FullBright = "Full Bright",
        CapFPS = "120 FPS Cap",
        ACMobile = "Auto Clicker",
        Invis = "Invisible (Vanish)",
        ResetChar = "Reset Character",
        ExecEgor = "Execute Egor Script",
        ExecXayz = "Xayz ESP + AIM",
        UltCross = "Ultimate Crosshair",
        TPName = "TP To Player (Name)",
        TPBtn = "TELEPORT NOW",
        ExecCode = "EXECUTE",
        ClearCode = "CLEAR",
        CopyCode = "CLIPBOARD",
        CloneHolder = "Clone Avatar (Name/ID)",
        CloneBtn = "CLONE AVATAR",
        HeadlessBtn = "ENABLE HEADLESS",
        AntiFlingBtn = "Anti Fling (No Collision)",
        NDSBtn = "TEST DISASTER POP-UP",
        EmoteHolder = "Enter Animation ID...",
        EmoteBtn = "PLAY ANIMATION",
        StatsBtn = "Show FPS/PING/CPS",
        SearchMusic = "Search Audio Library...",
        NowPlaying = "Not Playing Anything",
        BtnPlayPause = "❚❚︎",
        BtnStop = "█",
        BtnNext = "⏭",
        BtnPrev = "⏮",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Points: ",
        SpeedStr = "Speed",
        AdvCrossTitle = "Crosshair Settings",
        SizeStr = "Size",
        TransStr = "Transparency",
        ImgStr = "Image ID",
        TglSpin = "Toggle Spin",
        TglRain = "Toggle Rainbow",
        TglShape = "Toggle Shape",
        RedStr = "Red",
        CyanStr = "Cyan",
        AdvBoostTitle = "Booster Settings",
        PlasMode = "Plastic Mode",
        BitMode = "6-BIT Mode",
        NoPart = "Remove Particles",
        AdvShadeTitle = "Shader Settings",
        TglShade = "Toggle Shadows",
        TglBlur = "Toggle Blur",
        HighCon = "Cinema Contrast",
        NotifFound = "Found",
        NotifErr = "Error",
        NotifExec = "Executed",
        NotifSucc = "Success",
        CloneSucc = "Avatar Cloned!",
        CloneFail = "User Not Found!",
        HeadSucc = "Headless Active!",
        AnimFail = "Animation Failed!",
        DisasterT = "DISASTER DETECTED",
        DisasterD = "Tsunami incoming! Run!"
    },
    EN = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "LANGUAGE: ENGLISH",
        TabMain = "PLAYER",
        TabVisual = "VISUAL",
        TabTools = "TOOLS",
        TabWorld = "WORLD",
        TabExec = "EXECUTOR",
        TabUlt = "ULTIMATE",
        TabMusic = "MUSIC",
        Fly = "Mobile Fly",
        FlySpeed = "Fly Speed (Def: 50)",
        InfJump = "Infinity Jump",
        DoubleJump = "Double Jump",
        Wallhop = "Wallhop",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Enable Speed",
        SetSpeed = "Set WalkSpeed",
        EnableJump = "Enable JumpPower",
        SetJump = "Set JumpPower",
        EnableGrav = "Enable Gravity",
        SetGrav = "Set Gravity",
        Freeze = "Freeze (Lag Switch)",
        GodMode = "God Mode",
        Noclip = "Noclip",
        Tornado = "Tornado (Aura)",
        Booster = "FPS Booster",
        Roshade = "Roshade (Real 4K)",
        FullBright = "Full Bright",
        CapFPS = "120 FPS Cap",
        ACMobile = "Auto Clicker",
        Invis = "Invisible (Vanish)",
        ResetChar = "Reset Character",
        ExecEgor = "Execute Egor Script",
        ExecXayz = "Xayz ESP + AIM",
        UltCross = "Ultimate Crosshair",
        TPName = "TP To Player (Name)",
        TPBtn = "TELEPORT NOW",
        ExecCode = "EXECUTE",
        ClearCode = "CLEAR",
        CopyCode = "CLIPBOARD",
        CloneHolder = "Clone Avatar (Name/ID)",
        CloneBtn = "CLONE AVATAR",
        HeadlessBtn = "ENABLE HEADLESS",
        AntiFlingBtn = "Anti Fling (No Collision)",
        NDSBtn = "TEST DISASTER POP-UP",
        EmoteHolder = "Enter Animation ID...",
        EmoteBtn = "PLAY ANIMATION",
        StatsBtn = "Show FPS/PING/CPS",
        SearchMusic = "Search AudioLibrary...",
        NowPlaying = "Not Playing Anything",
        BtnPlayPause = "PLAY / PAUSE",
        BtnStop = "STOP",
        BtnNext = "NEXT >>",
        BtnPrev = "<< PREVIOUS",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Points: ",
        SpeedStr = "Speed",
        AdvCrossTitle = "Crosshair Settings",
        SizeStr = "Size",
        TransStr = "Transparency",
        ImgStr = "Image ID",
        TglSpin = "Toggle Spin",
        TglRain = "Toggle Rainbow",
        TglShape = "Toggle Shape",
        RedStr = "Red",
        CyanStr = "Cyan",
        AdvBoostTitle = "Booster Settings",
        PlasMode = "Plastic Mode",
        BitMode = "6-BIT Mode",
        NoPart = "Remove Particles",
        AdvShadeTitle = "Shader Settings",
        TglShade = "Toggle Shadows",
        TglBlur = "Toggle Blur",
        HighCon = "Cinema Contrast",
        NotifFound = "Found",
        NotifErr = "Error",
        NotifExec = "Executed",
        NotifSucc = "Success",
        CloneSucc = "Avatar Cloned!",
        CloneFail = "User Not Found!",
        HeadSucc = "Headless Active!",
        AnimFail = "Animation Failed!",
        DisasterT = "DISASTER DETECTED",
        DisasterD = "Tsunami incoming! Run!"
    },
    ID = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "BAHASA: INDONESIA",
        TabMain = "PEMAIN",
        TabVisual = "VISUAL",
        TabTools = "ALAT",
        TabWorld = "DUNIA",
        TabExec = "EKSEKUTOR",
        TabUlt = "ULTIMAT",
        TabMusic = "MUSIK",
        Fly = "Terbang Mode HP",
        FlySpeed = "Kecepatan Terbang (Awal: 50)",
        InfJump = "Lompat Tak Terbatas",
        DoubleJump = "Lompat Ganda",
        Wallhop = "Lompat Dinding",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Aktifkan Kecepatan",
        SetSpeed = "Atur Kecepatan",
        EnableJump = "Aktifkan Lompatan",
        SetJump = "Atur Lompatan",
        EnableGrav = "Aktifkan Gravitasi",
        SetGrav = "Atur Gravitasi",
        Freeze = "Beku (Buat Lag)",
        GodMode = "Mode Dewa",
        Noclip = "Tembus Tembok",
        Tornado = "Tornado (Aura)",
        Booster = "Peningkat FPS",
        Roshade = "Roshade (Asli 4K)",
        FullBright = "Terang Penuh",
        CapFPS = "Batas 120 FPS",
        ACMobile = "Pengeklik Otomatis",
        Invis = "Tembus Pandang",
        ResetChar = "Mati / Ulang Karakter",
        ExecEgor = "Jalankan Skrip Egor",
        ExecXayz = "Xayz ESP + AIM",
        UltCross = "Kekeran Penuh",
        TPName = "Pindah Ke Pemain (Nama)",
        TPBtn = "PINDAH SEKARANG",
        ExecCode = "JALANKAN",
        ClearCode = "BERSIHKAN",
        CopyCode = "SALIN TEKS",
        CloneHolder = "Tiru Avatar (Nama/ID)",
        CloneBtn = "TIRU AVATAR",
        HeadlessBtn = "AKTIFKAN KEPALA HILANG",
        AntiFlingBtn = "Anti Pental (Tembus)",
        NDSBtn = "TES MUNCUL BENCANA",
        EmoteHolder = "Masukkan ID Animasi...",
        EmoteBtn = "PUTAR ANIMASI",
        StatsBtn = "Tampilkan FPS/PING/CPS",
        SearchMusic = "Cari AudioLibrary...",
        NowPlaying = "Tidak Memutar Apapun",
        BtnPlayPause = "PUTAR / JEDA",
        BtnStop = "BERHENTI",
        BtnNext = "SELANJUTNYA >>",
        BtnPrev = "<< SEBELUMNYA",
        BtnStart = "MULAI",
        BtnStopAC = "BERHENTI",
        PointsStr = "Titik: ",
        SpeedStr = "Kecepatan",
        AdvCrossTitle = "Pengaturan Kekeran",
        SizeStr = "Ukuran",
        TransStr = "Transparan",
        ImgStr = "ID Gambar",
        TglSpin = "Ubah Putaran",
        TglRain = "Ubah Pelangi",
        TglShape = "Ubah Bentuk",
        RedStr = "Merah",
        CyanStr = "Biru Muda",
        AdvBoostTitle = "Pengaturan Peningkat",
        PlasMode = "Mode Plastik",
        BitMode = "Mode 6-BIT",
        NoPart = "Hapus Partikel",
        AdvShadeTitle = "Pengaturan Bayangan",
        TglShade = "Ubah Bayangan",
        TglBlur = "Ubah Buram",
        HighCon = "Kontras Bioskop",
        NotifFound = "Ditemukan",
        NotifErr = "Gagal",
        NotifExec = "Berjalan",
        NotifSucc = "Berhasil",
        CloneSucc = "Avatar Ditiru!",
        CloneFail = "Nama Tidak Ada!",
        HeadSucc = "Kepala Hilang!",
        AnimFail = "Animasi Gagal!",
        DisasterT = "BENCANA MUNCUL",
        DisasterD = "Tsunami datang! Lari!"
    },
    ES = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "IDIOMA: ESPAÑOL",
        TabMain = "JUGADOR",
        TabVisual = "VISUAL",
        TabTools = "HERRAMIENTAS",
        TabWorld = "MUNDO",
        TabExec = "EJECUTOR",
        TabUlt = "ÚLTIMO",
        TabMusic = "MÚSICA",
        Fly = "Volar (Móvil)",
        FlySpeed = "Velocidad de Vuelo",
        InfJump = "Salto Infinito",
        DoubleJump = "Doble Salto",
        Wallhop = "Salto de Pared",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Activar Velocidad",
        SetSpeed = "Ajustar Velocidad",
        EnableJump = "Activar Salto",
        SetJump = "Ajustar Salto",
        EnableGrav = "Activar Gravedad",
        SetGrav = "Ajustar Gravedad",
        Freeze = "Congelar",
        GodMode = "Modo Dios",
        Noclip = "Atravesar Paredes",
        Tornado = "Tornado (Aura)",
        Booster = "Acelerador de FPS",
        Roshade = "Roshade (4K Real)",
        FullBright = "Brillo Completo",
        CapFPS = "Límite 120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Invisible",
        ResetChar = "Reiniciar Personaje",
        ExecEgor = "Ejecutar Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Punto de Mira Ultimate",
        TPName = "TP a Jugador (Nombre)",
        TPBtn = "TELETRANSPORTAR AHORA",
        ExecCode = "EJECUTAR",
        ClearCode = "LIMPIAR",
        CopyCode = "COPIAR",
        CloneHolder = "Clonar Avatar",
        CloneBtn = "CLONAR",
        HeadlessBtn = "ACTIVAR SIN CABEZA",
        AntiFlingBtn = "Anti Fling",
        NDSBtn = "PROBAR DESASTRE",
        EmoteHolder = "ID de Animación...",
        EmoteBtn = "REPRODUCIR ANIMACIÓN",
        StatsBtn = "Mostrar FPS",
        SearchMusic = "Buscar Audio...",
        NowPlaying = "No Hay Nada Reproduciendo",
        BtnPlayPause = "REPRODUCIR / PAUSAR",
        BtnStop = "DETENER",
        BtnNext = "SIGUIENTE >>",
        BtnPrev = "<< ANTERIOR",
        BtnStart = "INICIAR",
        BtnStopAC = "DETENER",
        PointsStr = "Puntos: ",
        SpeedStr = "Velocidad",
        AdvCrossTitle = "Ajustes de Mira",
        SizeStr = "Tamaño",
        TransStr = "Transparencia",
        ImgStr = "ID de Imagen",
        TglSpin = "Activar Giro",
        TglRain = "Activar Arcoíris",
        TglShape = "Activar Forma",
        RedStr = "Rojo",
        CyanStr = "Cian",
        AdvBoostTitle = "Ajustes de Acelerador",
        PlasMode = "Modo Plástico",
        BitMode = "Modo 6-BIT",
        NoPart = "Quitar Partículas",
        AdvShadeTitle = "Ajustes de Sombras",
        TglShade = "Activar Sombras",
        TglBlur = "Activar Desenfoque",
        HighCon = "Contraste",
        NotifFound = "Encontrado",
        NotifErr = "Error",
        NotifExec = "Ejecutado",
        NotifSucc = "Éxito",
        CloneSucc = "¡Clonado!",
        CloneFail = "¡No Encontrado!",
        HeadSucc = "¡Sin Cabeza!",
        AnimFail = "¡Fallida!",
        DisasterT = "DESASTRE DETECTADO",
        DisasterD = "¡Corre!"
    },
    RU = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "ЯЗЫК: РУССКИЙ",
        TabMain = "ИГРОК",
        TabVisual = "ВИЗУАЛ",
        TabTools = "ИНСТРУМЕНТЫ",
        TabWorld = "МИР",
        TabExec = "ИСПОЛНИТЕЛЬ",
        TabUlt = "УЛЬТИМАТУМ",
        TabMusic = "МУЗЫКА",
        Fly = "Полет",
        FlySpeed = "Скорость Полета",
        InfJump = "Бесконечный Прыжок",
        DoubleJump = "Двойной Прыжок",
        Wallhop = "Прыжок по стене",
        AntiAfk = "Анти-АФК",
        EnableSpeed = "Включить Скорость",
        SetSpeed = "Установить Скорость",
        EnableJump = "Включить Прыжок",
        SetJump = "Установить Прыжок",
        EnableGrav = "Включить Гравитацию",
        SetGrav = "Установить Гравитацию",
        Freeze = "Заморозка",
        GodMode = "Режим Бога",
        Noclip = "Проход сквозь стены",
        Tornado = "Торнадо",
        Booster = "Бустер FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Полная Яркость",
        CapFPS = "Лимит 120 FPS",
        ACMobile = "Автокликер",
        Invis = "Невидимость",
        ResetChar = "Сбросить Персонажа",
        ExecEgor = "Скрипт Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Прицел",
        TPName = "ТП К Игроку",
        TPBtn = "ТЕЛЕПОРТ",
        ExecCode = "ВЫПОЛНИТЬ",
        ClearCode = "ОЧИСТИТЬ",
        CopyCode = "СКОПИРОВАТЬ",
        CloneHolder = "Клонировать Аватар",
        CloneBtn = "КЛОНИРОВАТЬ",
        HeadlessBtn = "БЕЗ ГОЛОВЫ",
        AntiFlingBtn = "Анти Отлет",
        NDSBtn = "ТЕСТ КАТАСТРОФЫ",
        EmoteHolder = "ID Анимации...",
        EmoteBtn = "ИГРАТЬ АНИМАЦИЮ",
        StatsBtn = "Показать FPS",
        SearchMusic = "Поиск Аудио...",
        NowPlaying = "Ничего не играет",
        BtnPlayPause = "ИГРАТЬ / ПАУЗА",
        BtnStop = "СТОП",
        BtnNext = "СЛЕДУЮЩИЙ",
        BtnPrev = "ПРЕДЫДУЩИЙ",
        BtnStart = "СТАРТ",
        BtnStopAC = "СТОП",
        PointsStr = "Очки: ",
        SpeedStr = "Скорость",
        AdvCrossTitle = "Настройки Прицела",
        SizeStr = "Размер",
        TransStr = "Прозрачность",
        ImgStr = "ID Картинки",
        TglSpin = "Вращение",
        TglRain = "Радуга",
        TglShape = "Форма",
        RedStr = "Красный",
        CyanStr = "Бирюзовый",
        AdvBoostTitle = "Настройки Бустера",
        PlasMode = "Пластик",
        BitMode = "6-БИТ Режим",
        NoPart = "Убрать Частицы",
        AdvShadeTitle = "Настройки Теней",
        TglShade = "Включить Тени",
        TglBlur = "Включить Размытие",
        HighCon = "Кино Контраст",
        NotifFound = "Найдено",
        NotifErr = "Ошибка",
        NotifExec = "Выполнено",
        NotifSucc = "Успешно",
        CloneSucc = "Клонирован!",
        CloneFail = "Не найден!",
        HeadSucc = "Без Головы Активно!",
        AnimFail = "Ошибка Анимации!",
        DisasterT = "КАТАСТРОФА",
        DisasterD = "Беги!"
    },
    ZH = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "语言: 中文",
        TabMain = "玩家",
        TabVisual = "视觉",
        TabTools = "工具",
        TabWorld = "世界",
        TabExec = "执行器",
        TabUlt = "终极",
        TabMusic = "音乐",
        Fly = "飞行",
        FlySpeed = "飞行速度",
        InfJump = "无限跳跃",
        DoubleJump = "二段跳",
        Wallhop = "卡墙跳",
        AntiAfk = "防挂机",
        EnableSpeed = "开启加速",
        SetSpeed = "设置速度",
        EnableJump = "开启跳跃提升",
        SetJump = "设置跳跃力",
        EnableGrav = "开启重力",
        SetGrav = "设置重力",
        Freeze = "冻结",
        GodMode = "上帝模式",
        Noclip = "穿墙",
        Tornado = "龙卷风",
        Booster = "FPS 提升",
        Roshade = "Roshade (4K)",
        FullBright = "最高亮度",
        CapFPS = "120 FPS",
        ACMobile = "自动点击",
        Invis = "隐身",
        ResetChar = "重置角色",
        ExecEgor = "执行 Egor",
        ExecXayz = "Xayz 透视",
        UltCross = "终极准星",
        TPName = "传送到玩家",
        TPBtn = "立即传送",
        ExecCode = "执行",
        ClearCode = "清除",
        CopyCode = "复制",
        CloneHolder = "克隆外观",
        CloneBtn = "克隆",
        HeadlessBtn = "无头模式",
        AntiFlingBtn = "防击飞",
        NDSBtn = "测试灾难",
        EmoteHolder = "输入动画 ID...",
        EmoteBtn = "播放动画",
        StatsBtn = "显示 FPS",
        SearchMusic = "搜索音频...",
        NowPlaying = "当前没有播放",
        BtnPlayPause = "播放 / 暂停",
        BtnStop = "停止",
        BtnNext = "下一首",
        BtnPrev = "上一首",
        BtnStart = "开始",
        BtnStopAC = "停止",
        PointsStr = "点数: ",
        SpeedStr = "速度",
        AdvCrossTitle = "准星设置",
        SizeStr = "大小",
        TransStr = "透明度",
        ImgStr = "图片 ID",
        TglSpin = "旋转",
        TglRain = "彩虹色",
        TglShape = "形状",
        RedStr = "红色",
        CyanStr = "青色",
        AdvBoostTitle = "提升器设置",
        PlasMode = "塑料模式",
        BitMode = "6-BIT",
        NoPart = "移除粒子",
        AdvShadeTitle = "着色器设置",
        TglShade = "阴影",
        TglBlur = "模糊",
        HighCon = "对比度",
        NotifFound = "已找到",
        NotifErr = "错误",
        NotifExec = "已执行",
        NotifSucc = "成功",
        CloneSucc = "克隆成功！",
        CloneFail = "未找到用户！",
        HeadSucc = "无头激活！",
        AnimFail = "失败！",
        DisasterT = "检测到灾难",
        DisasterD = "快跑！"
    },
    JP = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "言語: 日本語",
        TabMain = "プレイヤー",
        TabVisual = "ビジュアル",
        TabTools = "ツール",
        TabWorld = "ワールド",
        TabExec = "実行",
        TabUlt = "究極",
        TabMusic = "音楽",
        Fly = "飛行",
        FlySpeed = "飛行速度",
        InfJump = "無限ジャンプ",
        DoubleJump = "二段ジャンプ",
        Wallhop = "壁ジャンプ",
        AntiAfk = "放置対策",
        EnableSpeed = "スピード有効",
        SetSpeed = "スピード設定",
        EnableJump = "ジャンプ有効",
        SetJump = "ジャンプ設定",
        EnableGrav = "重力有効",
        SetGrav = "重力設定",
        Freeze = "フリーズ",
        GodMode = "無敵",
        Noclip = "壁抜け",
        Tornado = "竜巻",
        Booster = "FPS ブースト",
        Roshade = "Roshade (4K)",
        FullBright = "フルブライト",
        CapFPS = "120 FPS",
        ACMobile = "連打",
        Invis = "透明化",
        ResetChar = "リセット",
        ExecEgor = "Egor 実行",
        ExecXayz = "Xayz ESP",
        UltCross = "クロスヘア",
        TPName = "テレポート",
        TPBtn = "今すぐテレポート",
        ExecCode = "実行",
        ClearCode = "クリア",
        CopyCode = "コピー",
        CloneHolder = "クローン",
        CloneBtn = "クローン実行",
        HeadlessBtn = "ヘッドレス",
        AntiFlingBtn = "吹き飛び防止",
        NDSBtn = "災害テスト",
        EmoteHolder = "アニメID...",
        EmoteBtn = "再生",
        StatsBtn = "FPS 表示",
        SearchMusic = "音楽検索...",
        NowPlaying = "再生なし",
        BtnPlayPause = "再生 / 一時停止",
        BtnStop = "停止",
        BtnNext = "次へ",
        BtnPrev = "前へ",
        BtnStart = "開始",
        BtnStopAC = "停止",
        PointsStr = "ポイント: ",
        SpeedStr = "速度",
        AdvCrossTitle = "クロスヘア設定",
        SizeStr = "サイズ",
        TransStr = "透明度",
        ImgStr = "画像 ID",
        TglSpin = "回転",
        TglRain = "虹色",
        TglShape = "形状",
        RedStr = "赤",
        CyanStr = "シアン",
        AdvBoostTitle = "画質設定",
        PlasMode = "プラスチック",
        BitMode = "6-BIT",
        NoPart = "パーティクル無効",
        AdvShadeTitle = "影設定",
        TglShade = "影",
        TglBlur = "ぼかし",
        HighCon = "コントラスト",
        NotifFound = "発見",
        NotifErr = "エラー",
        NotifExec = "完了",
        NotifSucc = "成功",
        CloneSucc = "クローン成功！",
        CloneFail = "見つかりません！",
        HeadSucc = "ヘッドレス有効！",
        AnimFail = "失敗！",
        DisasterT = "災害検知",
        DisasterD = "逃げて！"
    },
    FR = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "LANGUE: FRANÇAIS",
        TabMain = "JOUEUR",
        TabVisual = "VISUEL",
        TabTools = "OUTILS",
        TabWorld = "MONDE",
        TabExec = "EXÉCUTEUR",
        TabUlt = "ULTIME",
        TabMusic = "MUSIQUE",
        Fly = "Vol",
        FlySpeed = "Vitesse Vol",
        InfJump = "Saut Infini",
        DoubleJump = "Double Saut",
        Wallhop = "Saut Mural",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Activer Vitesse",
        SetSpeed = "Régler Vitesse",
        EnableJump = "Activer Saut",
        SetJump = "Régler Saut",
        EnableGrav = "Activer Gravité",
        SetGrav = "Régler Gravité",
        Freeze = "Geler",
        GodMode = "Mode Dieu",
        Noclip = "Passe-Muraille",
        Tornado = "Tornade",
        Booster = "Boost FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Luminosité Max",
        CapFPS = "Max 120 FPS",
        ACMobile = "Auto Clic",
        Invis = "Invisible",
        ResetChar = "Réinitialiser",
        ExecEgor = "Exécuter Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Viseur",
        TPName = "TP Joueur",
        TPBtn = "TÉLÉPORTER",
        ExecCode = "EXÉCUTER",
        ClearCode = "EFFACER",
        CopyCode = "COPIER",
        CloneHolder = "Cloner (Nom/ID)",
        CloneBtn = "CLONER",
        HeadlessBtn = "SANS TÊTE",
        AntiFlingBtn = "Anti-Éjection",
        NDSBtn = "TEST DÉSASTRE",
        EmoteHolder = "ID Animation...",
        EmoteBtn = "JOUER",
        StatsBtn = "Afficher FPS",
        SearchMusic = "Chercher Audio...",
        NowPlaying = "Rien en cours",
        BtnPlayPause = "LECTURE / PAUSE",
        BtnStop = "STOP",
        BtnNext = "SUIVANT",
        BtnPrev = "PRÉCÉDENT",
        BtnStart = "DÉMARRER",
        BtnStopAC = "STOP",
        PointsStr = "Points: ",
        SpeedStr = "Vitesse",
        AdvCrossTitle = "Réglages Viseur",
        SizeStr = "Taille",
        TransStr = "Transparence",
        ImgStr = "ID Image",
        TglSpin = "Tourner",
        TglRain = "Arc-en-ciel",
        TglShape = "Forme",
        RedStr = "Rouge",
        CyanStr = "Cyan",
        AdvBoostTitle = "Réglages Boost",
        PlasMode = "Mode Plastique",
        BitMode = "Mode 6-BIT",
        NoPart = "Sans Particules",
        AdvShadeTitle = "Réglages Ombres",
        TglShade = "Ombres",
        TglBlur = "Flou",
        HighCon = "Contraste",
        NotifFound = "Trouvé",
        NotifErr = "Erreur",
        NotifExec = "Exécuté",
        NotifSucc = "Succès",
        CloneSucc = "Cloné !",
        CloneFail = "Introuvable !",
        HeadSucc = "Actif !",
        AnimFail = "Échec !",
        DisasterT = "DÉSASTRE",
        DisasterD = "Fuyez !"
    },
    DE = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "SPRACHE: DEUTSCH",
        TabMain = "SPIELER",
        TabVisual = "VISUELL",
        TabTools = "WERKZEUGE",
        TabWorld = "WELT",
        TabExec = "AUSFÜHREN",
        TabUlt = "ULTIMATIV",
        TabMusic = "MUSIK",
        Fly = "Fliegen",
        FlySpeed = "Flugtempo",
        InfJump = "Unendlich Sprung",
        DoubleJump = "Doppelsprung",
        Wallhop = "Wandsprung",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Tempo An",
        SetSpeed = "Tempo setzen",
        EnableJump = "Sprung An",
        SetJump = "Sprung setzen",
        EnableGrav = "Schwerkraft An",
        SetGrav = "Schwerkraft setzen",
        Freeze = "Einfrieren",
        GodMode = "Gottmodus",
        Noclip = "Durch Wände",
        Tornado = "Tornado",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Hell",
        CapFPS = "120 FPS",
        ACMobile = "Auto Klicker",
        Invis = "Unsichtbar",
        ResetChar = "Zurücksetzen",
        ExecEgor = "Egor Starten",
        ExecXayz = "Xayz ESP",
        UltCross = "Fadenkreuz",
        TPName = "TP zu Spieler",
        TPBtn = "TELEPORT",
        ExecCode = "START",
        ClearCode = "LÖSCHEN",
        CopyCode = "KOPIEREN",
        CloneHolder = "Klon (Name/ID)",
        CloneBtn = "KLONEN",
        HeadlessBtn = "KOPFLOS",
        AntiFlingBtn = "Anti-Wurf",
        NDSBtn = "KATASTROPHE TEST",
        EmoteHolder = "Animations-ID...",
        EmoteBtn = "ABSPIELEN",
        StatsBtn = "FPS Zeigen",
        SearchMusic = "Audio suchen...",
        NowPlaying = "Nichts spielt",
        BtnPlayPause = "PLAY / PAUSE",
        BtnStop = "STOPP",
        BtnNext = "WEITER",
        BtnPrev = "ZURÜCK",
        BtnStart = "START",
        BtnStopAC = "STOPP",
        PointsStr = "Punkte: ",
        SpeedStr = "Tempo",
        AdvCrossTitle = "Fadenkreuz Setup",
        SizeStr = "Größe",
        TransStr = "Transparenz",
        ImgStr = "Bild ID",
        TglSpin = "Drehen",
        TglRain = "Regenbogen",
        TglShape = "Form",
        RedStr = "Rot",
        CyanStr = "Cyan",
        AdvBoostTitle = "Boost Setup",
        PlasMode = "Plastik",
        BitMode = "6-BIT",
        NoPart = "Keine Partikel",
        AdvShadeTitle = "Schatten Setup",
        TglShade = "Schatten",
        TglBlur = "Unschärfe",
        HighCon = "Kontrast",
        NotifFound = "Gefunden",
        NotifErr = "Fehler",
        NotifExec = "Ausgeführt",
        NotifSucc = "Erfolg",
        CloneSucc = "Geklont!",
        CloneFail = "Nicht gefunden!",
        HeadSucc = "Aktiv!",
        AnimFail = "Fehler!",
        DisasterT = "GEFAHR",
        DisasterD = "Lauf!"
    },
    PT = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "IDIOMA: PORTUGUÊS",
        TabMain = "JOGADOR",
        TabVisual = "VISUAL",
        TabTools = "FERRAMENTAS",
        TabWorld = "MUNDO",
        TabExec = "EXECUTOR",
        TabUlt = "ÚLTIMO",
        TabMusic = "MÚSICA",
        Fly = "Voar",
        FlySpeed = "Velocidade Voo",
        InfJump = "Pulo Infinito",
        DoubleJump = "Pulo Duplo",
        Wallhop = "Pulo Parede",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Ativar Velocidade",
        SetSpeed = "Definir Veloc.",
        EnableJump = "Ativar Pulo",
        SetJump = "Definir Pulo",
        EnableGrav = "Ativar Gravidade",
        SetGrav = "Definir Gravidade",
        Freeze = "Congelar",
        GodMode = "Modo Deus",
        Noclip = "Atravessar Parede",
        Tornado = "Tornado",
        Booster = "Boost FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Brilho Máximo",
        CapFPS = "120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Invisível",
        ResetChar = "Resetar",
        ExecEgor = "Executar Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Mira Ultimate",
        TPName = "TP para Jogador",
        TPBtn = "TELEPORTAR",
        ExecCode = "EXECUTAR",
        ClearCode = "LIMPAR",
        CopyCode = "COPIAR",
        CloneHolder = "Clonar (Nome/ID)",
        CloneBtn = "CLONAR",
        HeadlessBtn = "SEM CABEÇA",
        AntiFlingBtn = "Anti Fling",
        NDSBtn = "TESTAR DESASTRE",
        EmoteHolder = "ID Animação...",
        EmoteBtn = "TOCAR",
        StatsBtn = "Mostrar FPS",
        SearchMusic = "Buscar Áudio...",
        NowPlaying = "Nada Tocando",
        BtnPlayPause = "PLAY / PAUSE",
        BtnStop = "PARAR",
        BtnNext = "PRÓXIMA",
        BtnPrev = "ANTERIOR",
        BtnStart = "INICIAR",
        BtnStopAC = "PARAR",
        PointsStr = "Pontos: ",
        SpeedStr = "Veloc.",
        AdvCrossTitle = "Config. Mira",
        SizeStr = "Tamanho",
        TransStr = "Transparência",
        ImgStr = "ID Imagem",
        TglSpin = "Girar",
        TglRain = "Arco-íris",
        TglShape = "Forma",
        RedStr = "Vermelho",
        CyanStr = "Ciano",
        AdvBoostTitle = "Config. Boost",
        PlasMode = "Plástico",
        BitMode = "6-BIT",
        NoPart = "Sem Partículas",
        AdvShadeTitle = "Sombras",
        TglShade = "Sombras",
        TglBlur = "Desfoque",
        HighCon = "Contraste",
        NotifFound = "Encontrado",
        NotifErr = "Erro",
        NotifExec = "Executado",
        NotifSucc = "Sucesso",
        CloneSucc = "Clonado!",
        CloneFail = "Não Encontrado!",
        HeadSucc = "Sem Cabeça!",
        AnimFail = "Falha!",
        DisasterT = "DESASTRE",
        DisasterD = "Corra!"
    },
    IT = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "LINGUA: ITALIANO",
        TabMain = "GIOCATORE",
        TabVisual = "VISUALE",
        TabTools = "STRUMENTI",
        TabWorld = "MONDO",
        TabExec = "ESECUTORE",
        TabUlt = "ULTIMO",
        TabMusic = "MUSICA",
        Fly = "Volo",
        FlySpeed = "Velocità Volo",
        InfJump = "Salto Infinito",
        DoubleJump = "Doppio Salto",
        Wallhop = "Salto Muro",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Attiva Velocità",
        SetSpeed = "Imposta Velocità",
        EnableJump = "Attiva Salto",
        SetJump = "Imposta Salto",
        EnableGrav = "Attiva Gravità",
        SetGrav = "Imposta Gravità",
        Freeze = "Congela",
        GodMode = "Modalità Dio",
        Noclip = "Passa Muri",
        Tornado = "Tornado",
        Booster = "Boost FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Luminosità Max",
        CapFPS = "120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Invisibile",
        ResetChar = "Resetta",
        ExecEgor = "Esegui Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Mirino",
        TPName = "TP a Giocatore",
        TPBtn = "TELETRASPORTO",
        ExecCode = "ESEGUI",
        ClearCode = "PULISCI",
        CopyCode = "COPIA",
        CloneHolder = "Clona (Nome/ID)",
        CloneBtn = "CLONA",
        HeadlessBtn = "SENZA TESTA",
        AntiFlingBtn = "Anti Lancio",
        NDSBtn = "TEST DISASTRO",
        EmoteHolder = "ID Animazione...",
        EmoteBtn = "AVVIA",
        StatsBtn = "Mostra FPS",
        SearchMusic = "Cerca Audio...",
        NowPlaying = "Nessuna riproduzione",
        BtnPlayPause = "PLAY / PAUSA",
        BtnStop = "STOP",
        BtnNext = "PROSSIMA",
        BtnPrev = "PRECEDENTE",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Punti: ",
        SpeedStr = "Velocità",
        AdvCrossTitle = "Impostazioni Mirino",
        SizeStr = "Dimensione",
        TransStr = "Trasparenza",
        ImgStr = "ID Immagine",
        TglSpin = "Ruota",
        TglRain = "Arcobaleno",
        TglShape = "Forma",
        RedStr = "Rosso",
        CyanStr = "Ciano",
        AdvBoostTitle = "Impostazioni Boost",
        PlasMode = "Plastica",
        BitMode = "6-BIT",
        NoPart = "No Particelle",
        AdvShadeTitle = "Ombre",
        TglShade = "Ombre",
        TglBlur = "Sfocatura",
        HighCon = "Contrasto",
        NotifFound = "Trovato",
        NotifErr = "Errore",
        NotifExec = "Eseguito",
        NotifSucc = "Successo",
        CloneSucc = "Clonato!",
        CloneFail = "Non Trovato!",
        HeadSucc = "Attivo!",
        AnimFail = "Fallito!",
        DisasterT = "DISASTRO",
        DisasterD = "Scappa!"
    },
    KO = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "언어: 한국어",
        TabMain = "플레이어",
        TabVisual = "시각",
        TabTools = "도구",
        TabWorld = "월드",
        TabExec = "실행기",
        TabUlt = "얼티밋",
        TabMusic = "음악",
        Fly = "비행",
        FlySpeed = "비행 속도",
        InfJump = "무한 점프",
        DoubleJump = "이단 점프",
        Wallhop = "벽 타기",
        AntiAfk = "잠수 방지",
        EnableSpeed = "스피드 켜기",
        SetSpeed = "속도 설정",
        EnableJump = "점프력 켜기",
        SetJump = "점프력 설정",
        EnableGrav = "중력 켜기",
        SetGrav = "중력 설정",
        Freeze = "정지",
        GodMode = "갓 모드",
        Noclip = "노클립",
        Tornado = "토네이도",
        Booster = "FPS 부스트",
        Roshade = "고화질",
        FullBright = "풀 브라이트",
        CapFPS = "120 FPS 제한",
        ACMobile = "오토 클릭",
        Invis = "투명화",
        ResetChar = "캐릭터 초기화",
        ExecEgor = "Egor 실행",
        ExecXayz = "Xayz ESP",
        UltCross = "크로스헤어",
        TPName = "텔레포트",
        TPBtn = "이동",
        ExecCode = "실행",
        ClearCode = "지우기",
        CopyCode = "복사",
        CloneHolder = "클론 (이름/ID)",
        CloneBtn = "아바타 복제",
        HeadlessBtn = "머리 없애기",
        AntiFlingBtn = "튕김 방지",
        NDSBtn = "재난 테스트",
        EmoteHolder = "애니메이션 ID...",
        EmoteBtn = "재생",
        StatsBtn = "FPS 보기",
        SearchMusic = "음악 검색...",
        NowPlaying = "재생 안 함",
        BtnPlayPause = "재생 / 일시정지",
        BtnStop = "정지",
        BtnNext = "다음",
        BtnPrev = "이전",
        BtnStart = "시작",
        BtnStopAC = "정지",
        PointsStr = "포인트: ",
        SpeedStr = "속도",
        AdvCrossTitle = "조준선 설정",
        SizeStr = "크기",
        TransStr = "투명도",
        ImgStr = "이미지 ID",
        TglSpin = "회전",
        TglRain = "무지개",
        TglShape = "모양",
        RedStr = "빨강",
        CyanStr = "시안",
        AdvBoostTitle = "부스터 설정",
        PlasMode = "플라스틱",
        BitMode = "6-BIT",
        NoPart = "입자 제거",
        AdvShadeTitle = "그림자 설정",
        TglShade = "그림자",
        TglBlur = "블러",
        HighCon = "대비",
        NotifFound = "발견",
        NotifErr = "오류",
        NotifExec = "실행됨",
        NotifSucc = "성공",
        CloneSucc = "복제 성공!",
        CloneFail = "유저 없음!",
        HeadSucc = "적용됨!",
        AnimFail = "실패!",
        DisasterT = "재난 감지",
        DisasterD = "도망쳐!"
    },
    AR = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "اللغة: العربية",
        TabMain = "لاعب",
        TabVisual = "بصري",
        TabTools = "أدوات",
        TabWorld = "عالم",
        TabExec = "منفذ",
        TabUlt = "مطلقة",
        TabMusic = "موسيقى",
        Fly = "طيران",
        FlySpeed = "سرعة الطيران",
        InfJump = "قفز لا نهائي",
        DoubleJump = "قفزة مزدوجة",
        Wallhop = "قفز جدار",
        AntiAfk = "ضد الخمول",
        EnableSpeed = "تفعيل السرعة",
        SetSpeed = "ضبط السرعة",
        EnableJump = "تفعيل القفز",
        SetJump = "ضبط القفز",
        EnableGrav = "تفعيل الجاذبية",
        SetGrav = "ضبط الجاذبية",
        Freeze = "تجميد",
        GodMode = "وضع الإله",
        Noclip = "اختراق الجدران",
        Tornado = "إعصار",
        Booster = "مسرع FPS",
        Roshade = "Roshade (4K)",
        FullBright = "سطوع كامل",
        CapFPS = "120 FPS",
        ACMobile = "نقر تلقائي",
        Invis = "مخفي",
        ResetChar = "إعادة تعيين",
        ExecEgor = "تشغيل Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "مؤشر",
        TPName = "انتقال إلى",
        TPBtn = "انتقال",
        ExecCode = "تشغيل",
        ClearCode = "مسح",
        CopyCode = "نسخ",
        CloneHolder = "استنساخ",
        CloneBtn = "استنساخ",
        HeadlessBtn = "بدون رأس",
        AntiFlingBtn = "ضد الطيران",
        NDSBtn = "اختبار كارثة",
        EmoteHolder = "معرف الحركة...",
        EmoteBtn = "تشغيل",
        StatsBtn = "عرض FPS",
        SearchMusic = "بحث صوت...",
        NowPlaying = "لا يوجد",
        BtnPlayPause = "تشغيل / إيقاف",
        BtnStop = "توقف",
        BtnNext = "التالي",
        BtnPrev = "السابق",
        BtnStart = "بدء",
        BtnStopAC = "توقف",
        PointsStr = "نقاط: ",
        SpeedStr = "سرعة",
        AdvCrossTitle = "إعدادات المؤشر",
        SizeStr = "حجم",
        TransStr = "شفافية",
        ImgStr = "ID الصورة",
        TglSpin = "دوران",
        TglRain = "قوس قزح",
        TglShape = "شكل",
        RedStr = "أحمر",
        CyanStr = "أزرق",
        AdvBoostTitle = "إعدادات الأداء",
        PlasMode = "بلاستيك",
        BitMode = "6-BIT",
        NoPart = "بدون جزيئات",
        AdvShadeTitle = "ظلال",
        TglShade = "ظلال",
        TglBlur = "ضبابية",
        HighCon = "تباين",
        NotifFound = "موجود",
        NotifErr = "خطأ",
        NotifExec = "تم",
        NotifSucc = "نجاح",
        CloneSucc = "تم الاستنساخ!",
        CloneFail = "غير موجود!",
        HeadSucc = "بدون رأس!",
        AnimFail = "فشل!",
        DisasterT = "كارثة",
        DisasterD = "اهرب!"
    },
    HI = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "भाषा: हिन्दी",
        TabMain = "खिलाड़ी",
        TabVisual = "दृश्य",
        TabTools = "उपकरण",
        TabWorld = "दुनिया",
        TabExec = "एक्ज़ीक्यूटर",
        TabUlt = "अंतिम",
        TabMusic = "संगीत",
        Fly = "उड़ान",
        FlySpeed = "उड़ान गति",
        InfJump = "अनंत कूद",
        DoubleJump = "डबल कूद",
        Wallhop = "दीवार कूद",
        AntiAfk = "एंटी-AFK",
        EnableSpeed = "गति चालू",
        SetSpeed = "गति सेट",
        EnableJump = "कूद चालू",
        SetJump = "कूद सेट",
        EnableGrav = "गुरुत्वाकर्षण",
        SetGrav = "गुरुत्व सेट",
        Freeze = "फ्रीज",
        GodMode = "गॉड मोड",
        Noclip = "नो क्लिप",
        Tornado = "बवंडर",
        Booster = "FPS बूस्ट",
        Roshade = "Roshade",
        FullBright = "पूरी रोशनी",
        CapFPS = "120 FPS",
        ACMobile = "ऑटो क्लिकर",
        Invis = "अदृश्य",
        ResetChar = "रीसेट",
        ExecEgor = "Egor चलाएं",
        ExecXayz = "Xayz ESP",
        UltCross = "क्रॉसहेयर",
        TPName = "TP",
        TPBtn = "टेलीपोर्ट",
        ExecCode = "चलाएं",
        ClearCode = "साफ करें",
        CopyCode = "कॉपी",
        CloneHolder = "क्लोन",
        CloneBtn = "क्लोन करें",
        HeadlessBtn = "बिना सिर",
        AntiFlingBtn = "एंटी-फ्लिंग",
        NDSBtn = "आपदा टेस्ट",
        EmoteHolder = "एनिमेशन ID...",
        EmoteBtn = "प्ले",
        StatsBtn = "FPS दिखाएं",
        SearchMusic = "ऑडियो खोजें...",
        NowPlaying = "कुछ नहीं",
        BtnPlayPause = "प्ले / पॉज़",
        BtnStop = "रुकें",
        BtnNext = "अगला",
        BtnPrev = "पिछला",
        BtnStart = "शुरू",
        BtnStopAC = "रुकें",
        PointsStr = "पॉइंट्स: ",
        SpeedStr = "गति",
        AdvCrossTitle = "क्रॉसहेयर सेटिंग्स",
        SizeStr = "आकार",
        TransStr = "पारदर्शिता",
        ImgStr = "चित्र ID",
        TglSpin = "घुमाएं",
        TglRain = "इंद्रधनुष",
        TglShape = "आकार",
        RedStr = "लाल",
        CyanStr = "सियान",
        AdvBoostTitle = "बूस्ट सेटिंग्स",
        PlasMode = "प्लास्टिक",
        BitMode = "6-BIT",
        NoPart = "कण हटाएं",
        AdvShadeTitle = "छाया",
        TglShade = "छाया चालू",
        TglBlur = "धुंधला",
        HighCon = "कंट्रास्ट",
        NotifFound = "मिला",
        NotifErr = "त्रुटि",
        NotifExec = "सफल",
        NotifSucc = "सफलता",
        CloneSucc = "क्लोन हुआ!",
        CloneFail = "नहीं मिला!",
        HeadSucc = "सक्रिय!",
        AnimFail = "विफल!",
        DisasterT = "आपदा",
        DisasterD = "भागो!"
    },
    TR = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "DİL: TÜRKÇE",
        TabMain = "OYUNCU",
        TabVisual = "GÖRSEL",
        TabTools = "ARAÇLAR",
        TabWorld = "DÜNYA",
        TabExec = "ÇALIŞTIR",
        TabUlt = "ULTRA",
        TabMusic = "MÜZİK",
        Fly = "Uçma",
        FlySpeed = "Uçma Hızı",
        InfJump = "Sonsuz Zıplama",
        DoubleJump = "Çifte Zıplama",
        Wallhop = "Duvar Zıplama",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Hız Aç",
        SetSpeed = "Hız Ayarla",
        EnableJump = "Zıplama Aç",
        SetJump = "Zıplama Ayarla",
        EnableGrav = "Yerçekimi Aç",
        SetGrav = "Yerçekimi Ayarla",
        Freeze = "Dondur",
        GodMode = "Ölümsüzlük",
        Noclip = "Duvar Geçme",
        Tornado = "Hortum",
        Booster = "FPS Arttır",
        Roshade = "Gerçekçi HD",
        FullBright = "Tam Parlak",
        CapFPS = "120 FPS",
        ACMobile = "Oto Tıklayıcı",
        Invis = "Görünmez",
        ResetChar = "Sıfırla",
        ExecEgor = "Egor Çalıştır",
        ExecXayz = "Xayz ESP",
        UltCross = "Nişangah",
        TPName = "Işınlan",
        TPBtn = "IŞINLAN",
        ExecCode = "ÇALIŞTIR",
        ClearCode = "TEMİZLE",
        CopyCode = "KOPYALA",
        CloneHolder = "Klonla (İsim/ID)",
        CloneBtn = "KLONLA",
        HeadlessBtn = "KAFASIZ YAP",
        AntiFlingBtn = "Fırlama Engeli",
        NDSBtn = "AFET TESTİ",
        EmoteHolder = "Animasyon ID...",
        EmoteBtn = "OYNAT",
        StatsBtn = "FPS Göster",
        SearchMusic = "Müzik Ara...",
        NowPlaying = "Çalan Yok",
        BtnPlayPause = "BAŞLAT / DURAKLAT",
        BtnStop = "DURDUR",
        BtnNext = "İLERİ",
        BtnPrev = "GERİ",
        BtnStart = "BAŞLAT",
        BtnStopAC = "DURDUR",
        PointsStr = "Puan: ",
        SpeedStr = "Hız",
        AdvCrossTitle = "Nişangah Ayarı",
        SizeStr = "Boyut",
        TransStr = "Şeffaflık",
        ImgStr = "Resim ID",
        TglSpin = "Döndür",
        TglRain = "Gökkuşağı",
        TglShape = "Şekil",
        RedStr = "Kırmızı",
        CyanStr = "Camgöbeği",
        AdvBoostTitle = "Performans Ayarı",
        PlasMode = "Plastik",
        BitMode = "6-BIT",
        NoPart = "Efektsiz",
        AdvShadeTitle = "Gölge",
        TglShade = "Gölgeler",
        TglBlur = "Bulanıklık",
        HighCon = "Kontrast",
        NotifFound = "Bulundu",
        NotifErr = "Hata",
        NotifExec = "Çalıştı",
        NotifSucc = "Başarılı",
        CloneSucc = "Klonlandı!",
        CloneFail = "Bulunamadı!",
        HeadSucc = "Aktif!",
        AnimFail = "Hata!",
        DisasterT = "AFET",
        DisasterD = "Kaç!"
    },
    VI = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "NGÔN NGỮ: TIẾNG VIỆT",
        TabMain = "NGƯỜI CHƠI",
        TabVisual = "HÌNH ẢNH",
        TabTools = "CÔNG CỤ",
        TabWorld = "THẾ GIỚI",
        TabExec = "MÃ LỆNH",
        TabUlt = "TỐI THƯỢNG",
        TabMusic = "NHẠC",
        Fly = "Bay",
        FlySpeed = "Tốc độ bay",
        InfJump = "Nhảy vô hạn",
        DoubleJump = "Nhảy kép",
        Wallhop = "Nhảy tường",
        AntiAfk = "Chống AFK",
        EnableSpeed = "Bật tốc độ",
        SetSpeed = "Chỉnh tốc độ",
        EnableJump = "Bật nhảy",
        SetJump = "Chỉnh lực nhảy",
        EnableGrav = "Bật trọng lực",
        SetGrav = "Chỉnh trọng lực",
        Freeze = "Đóng băng",
        GodMode = "Bất tử",
        Noclip = "Xuyên tường",
        Tornado = "Lốc xoáy",
        Booster = "Tăng FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Sáng tối đa",
        CapFPS = "120 FPS",
        ACMobile = "Tự động click",
        Invis = "Tàng hình",
        ResetChar = "Hồi sinh",
        ExecEgor = "Chạy Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Tâm ngắm",
        TPName = "Dịch chuyển",
        TPBtn = "ĐI NGAY",
        ExecCode = "CHẠY",
        ClearCode = "XÓA",
        CopyCode = "SAO CHÉP",
        CloneHolder = "Sao chép (Tên/ID)",
        CloneBtn = "SAO CHÉP",
        HeadlessBtn = "MẤT ĐẦU",
        AntiFlingBtn = "Chống văng",
        NDSBtn = "TEST THẢM HỌA",
        EmoteHolder = "ID Hiệu ứng...",
        EmoteBtn = "CHẠY",
        StatsBtn = "Hiện FPS",
        SearchMusic = "Tìm nhạc...",
        NowPlaying = "Không phát",
        BtnPlayPause = "PHÁT / DỪNG",
        BtnStop = "TẮT",
        BtnNext = "TIẾP",
        BtnPrev = "TRƯỚC",
        BtnStart = "BẮT ĐẦU",
        BtnStopAC = "TẮT",
        PointsStr = "Điểm: ",
        SpeedStr = "Tốc độ",
        AdvCrossTitle = "Cài đặt tâm",
        SizeStr = "Cỡ",
        TransStr = "Độ mờ",
        ImgStr = "ID Ảnh",
        TglSpin = "Xoay",
        TglRain = "Cầu vồng",
        TglShape = "Hình",
        RedStr = "Đỏ",
        CyanStr = "Lục lam",
        AdvBoostTitle = "Tăng tốc",
        PlasMode = "Nhựa",
        BitMode = "6-BIT",
        NoPart = "Xóa hạt",
        AdvShadeTitle = "Bóng",
        TglShade = "Bóng",
        TglBlur = "Mờ",
        HighCon = "Tương phản",
        NotifFound = "Đã thấy",
        NotifErr = "Lỗi",
        NotifExec = "Đã chạy",
        NotifSucc = "Thành công",
        CloneSucc = "Xong!",
        CloneFail = "Không thấy!",
        HeadSucc = "Đã mất đầu!",
        AnimFail = "Lỗi!",
        DisasterT = "THẢM HỌA",
        DisasterD = "Chạy!"
    },
    TH = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "ภาษา: ไทย",
        TabMain = "ผู้เล่น",
        TabVisual = "การมองเห็น",
        TabTools = "เครื่องมือ",
        TabWorld = "โลก",
        TabExec = "รันคำสั่ง",
        TabUlt = "สูงสุด",
        TabMusic = "เพลง",
        Fly = "บิน",
        FlySpeed = "ความเร็วบิน",
        InfJump = "กระโดดไม่จำกัด",
        DoubleJump = "กระโดดคู่",
        Wallhop = "กระโดดกำแพง",
        AntiAfk = "กันหลุด",
        EnableSpeed = "เปิดความเร็ว",
        SetSpeed = "ตั้งความเร็ว",
        EnableJump = "เปิดกระโดด",
        SetJump = "ตั้งกระโดด",
        EnableGrav = "เปิดแรงโน้มถ่วง",
        SetGrav = "ตั้งแรงโน้มถ่วง",
        Freeze = "แช่แข็ง",
        GodMode = "อมตะ",
        Noclip = "ทะลุกำแพง",
        Tornado = "พายุ",
        Booster = "เพิ่ม FPS",
        Roshade = "ภาพสวย",
        FullBright = "สว่างสุด",
        CapFPS = "120 FPS",
        ACMobile = "ออโต้คลิก",
        Invis = "ล่องหน",
        ResetChar = "รีเซ็ต",
        ExecEgor = "รัน Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "เป้าเล็ง",
        TPName = "วาร์ปไปหา",
        TPBtn = "วาร์ป",
        ExecCode = "รัน",
        ClearCode = "ล้าง",
        CopyCode = "คัดลอก",
        CloneHolder = "โคลน (ID)",
        CloneBtn = "โคลนร่าง",
        HeadlessBtn = "หัวขาด",
        AntiFlingBtn = "กันปลิว",
        NDSBtn = "เทสภัยพิบัติ",
        EmoteHolder = "ID อนิเมชั่น...",
        EmoteBtn = "เล่น",
        StatsBtn = "โชว์ FPS",
        SearchMusic = "ค้นหาเพลง...",
        NowPlaying = "ไม่ได้เล่น",
        BtnPlayPause = "เล่น / พัก",
        BtnStop = "หยุด",
        BtnNext = "ถัดไป",
        BtnPrev = "ก่อนหน้า",
        BtnStart = "เริ่ม",
        BtnStopAC = "หยุด",
        PointsStr = "แต้ม: ",
        SpeedStr = "เร็ว",
        AdvCrossTitle = "ตั้งค่าเป้า",
        SizeStr = "ขนาด",
        TransStr = "โปร่งใส",
        ImgStr = "ID รูป",
        TglSpin = "หมุน",
        TglRain = "สายรุ้ง",
        TglShape = "รูปทรง",
        RedStr = "แดง",
        CyanStr = "ฟ้า",
        AdvBoostTitle = "ตั้งค่าเร่ง",
        PlasMode = "พลาสติก",
        BitMode = "6-BIT",
        NoPart = "ลบเอฟเฟกต์",
        AdvShadeTitle = "เงา",
        TglShade = "เปิดเงา",
        TglBlur = "เบลอ",
        HighCon = "คอนทราสต์",
        NotifFound = "เจอแล้ว",
        NotifErr = "เออเร่อ",
        NotifExec = "รันแล้ว",
        NotifSucc = "สำเร็จ",
        CloneSucc = "โคลนแล้ว!",
        CloneFail = "ไม่พบผู้เล่น!",
        HeadSucc = "ใช้งานแล้ว!",
        AnimFail = "ล้มเหลว!",
        DisasterT = "อันตราย",
        DisasterD = "หนี!"
    },
    PL = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "JĘZYK: POLSKI",
        TabMain = "GRACZ",
        TabVisual = "WIZUALNE",
        TabTools = "NARZĘDZIA",
        TabWorld = "ŚWIAT",
        TabExec = "SKRYPTY",
        TabUlt = "ULTRA",
        TabMusic = "MUZYKA",
        Fly = "Latanie",
        FlySpeed = "Prędkość lotu",
        InfJump = "Niesk. Skok",
        DoubleJump = "Podwójny Skok",
        Wallhop = "Skok od ściany",
        AntiAfk = "Anty-AFK",
        EnableSpeed = "Włącz Prędkość",
        SetSpeed = "Ustaw Prędkość",
        EnableJump = "Włącz Skok",
        SetJump = "Siła Skoku",
        EnableGrav = "Włącz Grawitację",
        SetGrav = "Grawitacja",
        Freeze = "Zamrożenie",
        GodMode = "Tryb Boga",
        Noclip = "Przez Ściany",
        Tornado = "Tornado",
        Booster = "Boost FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Jasność",
        CapFPS = "120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Niewidzialność",
        ResetChar = "Zresetuj",
        ExecEgor = "Odpal Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Celownik",
        TPName = "TP do (Nazwa)",
        TPBtn = "TELEPORT",
        ExecCode = "ODPAL",
        ClearCode = "WYCZYŚĆ",
        CopyCode = "KOPIUJ",
        CloneHolder = "Klon (Nazwa/ID)",
        CloneBtn = "SKLONUJ",
        HeadlessBtn = "BEZ GŁOWY",
        AntiFlingBtn = "Anty-Odrzut",
        NDSBtn = "TEST KATASTROFY",
        EmoteHolder = "ID Animacji...",
        EmoteBtn = "ODTWÓRZ",
        StatsBtn = "Pokaż FPS",
        SearchMusic = "Szukaj audio...",
        NowPlaying = "Cisza",
        BtnPlayPause = "GRAJ / PAUZA",
        BtnStop = "STOP",
        BtnNext = "DALEJ",
        BtnPrev = "WSTECZ",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Punkty: ",
        SpeedStr = "Prędkość",
        AdvCrossTitle = "Ustawienia Celownika",
        SizeStr = "Rozmiar",
        TransStr = "Przezroczystość",
        ImgStr = "ID Obrazka",
        TglSpin = "Obrót",
        TglRain = "Tęcza",
        TglShape = "Kształt",
        RedStr = "Czerwony",
        CyanStr = "Cyjan",
        AdvBoostTitle = "Ustawienia Boostera",
        PlasMode = "Plastik",
        BitMode = "6-BIT",
        NoPart = "Brak Cząsteczek",
        AdvShadeTitle = "Cienie",
        TglShade = "Cienie",
        TglBlur = "Rozmycie",
        HighCon = "Kontrast",
        NotifFound = "Znaleziono",
        NotifErr = "Błąd",
        NotifExec = "Wykonano",
        NotifSucc = "Sukces",
        CloneSucc = "Sklonowano!",
        CloneFail = "Nie znaleziono!",
        HeadSucc = "Aktywny!",
        AnimFail = "Błąd!",
        DisasterT = "KATASTROFA",
        DisasterD = "Uciekaj!"
    },
    NL = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "TAAL: NEDERLANDS",
        TabMain = "SPELER",
        TabVisual = "VISUEEL",
        TabTools = "TOOLS",
        TabWorld = "WERELD",
        TabExec = "EXECUTOR",
        TabUlt = "ULTRA",
        TabMusic = "MUZIEK",
        Fly = "Vliegen",
        FlySpeed = "Vliegsnelheid",
        InfJump = "Oneindig Springen",
        DoubleJump = "Dubbele Sprong",
        Wallhop = "Muursprong",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Snelheid Aan",
        SetSpeed = "Snelheid Zetten",
        EnableJump = "Sprong Aan",
        SetJump = "Sprongkracht",
        EnableGrav = "Zwaartekracht Aan",
        SetGrav = "Zwaartekracht",
        Freeze = "Bevriezen",
        GodMode = "God Modus",
        Noclip = "Door Muren",
        Tornado = "Tornado",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Volle Helderheid",
        CapFPS = "120 FPS",
        ACMobile = "Auto Klikker",
        Invis = "Onzichtbaar",
        ResetChar = "Reset",
        ExecEgor = "Voer Egor uit",
        ExecXayz = "Xayz ESP",
        UltCross = "Vizier",
        TPName = "TP Naar",
        TPBtn = "TELEPORTEER",
        ExecCode = "UITVOEREN",
        ClearCode = "WISSEN",
        CopyCode = "KOPIËREN",
        CloneHolder = "Kloon (Naam/ID)",
        CloneBtn = "KLONEN",
        HeadlessBtn = "ZONDER HOOFD",
        AntiFlingBtn = "Anti Vliegen",
        NDSBtn = "RAMP TEST",
        EmoteHolder = "Animatie ID...",
        EmoteBtn = "AFSPELEN",
        StatsBtn = "Toon FPS",
        SearchMusic = "Zoek Audio...",
        NowPlaying = "Speelt Niks",
        BtnPlayPause = "SPEEL / PAUZE",
        BtnStop = "STOP",
        BtnNext = "VOLGENDE",
        BtnPrev = "VORIGE",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Punten: ",
        SpeedStr = "Snelheid",
        AdvCrossTitle = "Vizier Instellingen",
        SizeStr = "Grootte",
        TransStr = "Transparantie",
        ImgStr = "Afbeelding ID",
        TglSpin = "Draaien",
        TglRain = "Regenboog",
        TglShape = "Vorm",
        RedStr = "Rood",
        CyanStr = "Cyaan",
        AdvBoostTitle = "Boost Instellingen",
        PlasMode = "Plastic",
        BitMode = "6-BIT",
        NoPart = "Geen Deeltjes",
        AdvShadeTitle = "Schaduw",
        TglShade = "Schaduw",
        TglBlur = "Vervagen",
        HighCon = "Contrast",
        NotifFound = "Gevonden",
        NotifErr = "Fout",
        NotifExec = "Uitgevoerd",
        NotifSucc = "Succes",
        CloneSucc = "Gekloond!",
        CloneFail = "Niet Gevonden!",
        HeadSucc = "Actief!",
        AnimFail = "Mislukt!",
        DisasterT = "RAMP",
        DisasterD = "Ren!"
    },
    UK = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "МОВА: УКРАЇНСЬКА",
        TabMain = "ГРАВЕЦЬ",
        TabVisual = "ВІЗУАЛ",
        TabTools = "ІНСТРУМЕНТИ",
        TabWorld = "СВІТ",
        TabExec = "ВИКОНАВЕЦЬ",
        TabUlt = "УЛЬТА",
        TabMusic = "МУЗИКА",
        Fly = "Політ",
        FlySpeed = "Швидкість",
        InfJump = "Некін. Стрибок",
        DoubleJump = "Подвійний Стрибок",
        Wallhop = "Стрибок від стіни",
        AntiAfk = "Анти-АФК",
        EnableSpeed = "Увімк Швидкість",
        SetSpeed = "Швид. Ходьби",
        EnableJump = "Увімк Стрибок",
        SetJump = "Сила Стрибка",
        EnableGrav = "Увімк Гравітацію",
        SetGrav = "Гравітація",
        Freeze = "Заморозка",
        GodMode = "Режим Бога",
        Noclip = "Крізь стіни",
        Tornado = "Торнадо",
        Booster = "Буст FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Світло",
        CapFPS = "120 FPS",
        ACMobile = "Автоклікер",
        Invis = "Невидимка",
        ResetChar = "Скинути",
        ExecEgor = "Запуск Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Приціл",
        TPName = "ТП до гравця",
        TPBtn = "ТЕЛЕПОРТ",
        ExecCode = "ЗАПУСК",
        ClearCode = "ОЧИСТИТИ",
        CopyCode = "КОПІЯ",
        CloneHolder = "Клон (Ім'я/ID)",
        CloneBtn = "КЛОНУВАТИ",
        HeadlessBtn = "БЕЗ ГОЛОВИ",
        AntiFlingBtn = "Анти-Відкидання",
        NDSBtn = "ТЕСТ КАТАСТРОФИ",
        EmoteHolder = "ID Анімації...",
        EmoteBtn = "ГРАТИ",
        StatsBtn = "Показ FPS",
        SearchMusic = "Пошук музики...",
        NowPlaying = "Тиша",
        BtnPlayPause = "ПЛЕЙ / ПАУЗА",
        BtnStop = "СТОП",
        BtnNext = "НАСТ.",
        BtnPrev = "ПОПЕР.",
        BtnStart = "СТАРТ",
        BtnStopAC = "СТОП",
        PointsStr = "Очки: ",
        SpeedStr = "Швидкість",
        AdvCrossTitle = "Приціл",
        SizeStr = "Розмір",
        TransStr = "Прозорість",
        ImgStr = "ID Картинки",
        TglSpin = "Обертання",
        TglRain = "Веселка",
        TglShape = "Форма",
        RedStr = "Червоний",
        CyanStr = "Ціан",
        AdvBoostTitle = "Налаштування Бусту",
        PlasMode = "Пластик",
        BitMode = "6-BIT",
        NoPart = "Без Частинок",
        AdvShadeTitle = "Тіні",
        TglShade = "Увімк Тіні",
        TglBlur = "Розмиття",
        HighCon = "Контраст",
        NotifFound = "Знайдено",
        NotifErr = "Помилка",
        NotifExec = "Запущено",
        NotifSucc = "Успіх",
        CloneSucc = "Клоновано!",
        CloneFail = "Не знайдено!",
        HeadSucc = "Без Голови!",
        AnimFail = "Помилка!",
        DisasterT = "НЕБЕЗПЕКА",
        DisasterD = "Біжи!"
    },
    TL = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "WIKA: TAGALOG",
        TabMain = "MANLALARO",
        TabVisual = "BISWAL",
        TabTools = "MGA TOOL",
        TabWorld = "MUNDO",
        TabExec = "TIGAPATUPAD",
        TabUlt = "ULTIMATE",
        TabMusic = "MUSIKA",
        Fly = "Lipad",
        FlySpeed = "Bilis Lipad",
        InfJump = "Walang Hanggang Talon",
        DoubleJump = "Dobleng Talon",
        Wallhop = "Talon sa Pader",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Bilis On",
        SetSpeed = "Set Bilis",
        EnableJump = "Talon On",
        SetJump = "Set Talon",
        EnableGrav = "Gravity On",
        SetGrav = "Set Gravity",
        Freeze = "Tumigil",
        GodMode = "Diyos Mode",
        Noclip = "Lagpas Pader",
        Tornado = "Buhawi",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Maliwanag",
        CapFPS = "120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Di Nakikita",
        ResetChar = "Reset",
        ExecEgor = "Patakbuhin Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Asintada",
        TPName = "TP kay (Pangalan)",
        TPBtn = "TELEPORT",
        ExecCode = "PATAKBUHIN",
        ClearCode = "BURAHIN",
        CopyCode = "KOPYAHIN",
        CloneHolder = "Kopya (Pangalan/ID)",
        CloneBtn = "KOPYAHIN",
        HeadlessBtn = "WALANG ULO",
        AntiFlingBtn = "Anti-Talsik",
        NDSBtn = "TEST SAKUNA",
        EmoteHolder = "ID ng Animasyon...",
        EmoteBtn = "IPLAY",
        StatsBtn = "Ipakita FPS",
        SearchMusic = "Hanapin Audio...",
        NowPlaying = "Walang Tumutugtog",
        BtnPlayPause = "PLAY / PAUSE",
        BtnStop = "TIGIL",
        BtnNext = "SUSUNOD",
        BtnPrev = "NAKARAAN",
        BtnStart = "SIMULA",
        BtnStopAC = "TIGIL",
        PointsStr = "Puntos: ",
        SpeedStr = "Bilis",
        AdvCrossTitle = "Asintada Settings",
        SizeStr = "Laki",
        TransStr = "Linaw",
        ImgStr = "ID Larawan",
        TglSpin = "Ikot",
        TglRain = "Bahaghari",
        TglShape = "Hugis",
        RedStr = "Pula",
        CyanStr = "Cyan",
        AdvBoostTitle = "Boost Settings",
        PlasMode = "Plastik Mode",
        BitMode = "6-BIT",
        NoPart = "Walang Particles",
        AdvShadeTitle = "Anino",
        TglShade = "Anino",
        TglBlur = "Labo",
        HighCon = "Contrast",
        NotifFound = "Natagpuan",
        NotifErr = "Mali",
        NotifExec = "Napatakbo",
        NotifSucc = "Tagumpay",
        CloneSucc = "Nakopya!",
        CloneFail = "Hindi Natagpuan!",
        HeadSucc = "Walang Ulo!",
        AnimFail = "Nabigo!",
        DisasterT = "SAKUNA",
        DisasterD = "Takbo!"
    },
    MS = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "BAHASA: MELAYU",
        TabMain = "PEMAIN",
        TabVisual = "VISUAL",
        TabTools = "ALATAN",
        TabWorld = "DUNIA",
        TabExec = "EKSEKUTOR",
        TabUlt = "ULTIMAT",
        TabMusic = "MUZIK",
        Fly = "Terbang Mudah Alih",
        FlySpeed = "Kelajuan Terbang",
        InfJump = "Lompat Infiniti",
        DoubleJump = "Lompat Berganda",
        Wallhop = "Lompat Dinding",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Aktifkan Kelajuan",
        SetSpeed = "Tetapkan Kelajuan",
        EnableJump = "Aktifkan Lompatan",
        SetJump = "Tetapkan Lompatan",
        EnableGrav = "Aktifkan Graviti",
        SetGrav = "Tetapkan Graviti",
        Freeze = "Beku",
        GodMode = "Mod Dewa",
        Noclip = "Tembus Dinding",
        Tornado = "Putings Beliung",
        Booster = "Peningkat FPS",
        Roshade = "Roshade (4K)",
        FullBright = "Cerah Sepenuhnya",
        CapFPS = "Had 120 FPS",
        ACMobile = "Klik Automatik",
        Invis = "Tembus Pandang",
        ResetChar = "Semula Watak",
        ExecEgor = "Jalankan Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Kekeran Penuh",
        TPName = "Pindah Ke Pemain",
        TPBtn = "PINDAH SEKARANG",
        ExecCode = "JALANKAN",
        ClearCode = "BERSIHKAN",
        CopyCode = "SALIN",
        CloneHolder = "Tiru Avatar",
        CloneBtn = "TIRU",
        HeadlessBtn = "TANPA KEPALA",
        AntiFlingBtn = "Anti Lenting",
        NDSBtn = "UJI BENCANA",
        EmoteHolder = "ID Animasi...",
        EmoteBtn = "MAINKAN",
        StatsBtn = "Tunjuk FPS",
        SearchMusic = "Cari Audio...",
        NowPlaying = "Tiada Muzik",
        BtnPlayPause = "MAIN / JEDA",
        BtnStop = "BERHENTI",
        BtnNext = "SETERUSNYA",
        BtnPrev = "SEBELUMNYA",
        BtnStart = "MULA",
        BtnStopAC = "BERHENTI",
        PointsStr = "Mata: ",
        SpeedStr = "Kelajuan",
        AdvCrossTitle = "Tetapan Kekeran",
        SizeStr = "Saiz",
        TransStr = "Lutsinar",
        ImgStr = "ID Imej",
        TglSpin = "Pusing",
        TglRain = "Pelangi",
        TglShape = "Bentuk",
        RedStr = "Merah",
        CyanStr = "Biru Muda",
        AdvBoostTitle = "Tetapan Peningkat",
        PlasMode = "Mod Plastik",
        BitMode = "6-BIT",
        NoPart = "Buang Zarah",
        AdvShadeTitle = "Tetapan Bayang",
        TglShade = "Bayang",
        TglBlur = "Kabur",
        HighCon = "Kontras",
        NotifFound = "Ditemui",
        NotifErr = "Ralat",
        NotifExec = "Dijalankan",
        NotifSucc = "Berjaya",
        CloneSucc = "Berjaya Ditiru!",
        CloneFail = "Tidak Ditemui!",
        HeadSucc = "Aktif!",
        AnimFail = "Gagal!",
        DisasterT = "BENCANA",
        DisasterD = "Lari!"
    },
    SV = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "SPRÅK: SVENSKA",
        TabMain = "SPELARE",
        TabVisual = "VISUELLT",
        TabTools = "VERKTYG",
        TabWorld = "VÄRLD",
        TabExec = "KÖR",
        TabUlt = "ULTIMAT",
        TabMusic = "MUSIK",
        Fly = "Flyg",
        FlySpeed = "Flyghastighet",
        InfJump = "Oändligt Hopp",
        DoubleJump = "Dubbelhopp",
        Wallhop = "Vägg-hopp",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Aktivera Fart",
        SetSpeed = "Ställ in Fart",
        EnableJump = "Aktivera Hopp",
        SetJump = "Ställ in Hopp",
        EnableGrav = "Aktivera Gravitation",
        SetGrav = "Ställ in Grav.",
        Freeze = "Frys",
        GodMode = "Gudsläge",
        Noclip = "Gå Genom Väggar",
        Tornado = "Tornado",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Full Ljusstyrka",
        CapFPS = "120 FPS",
        ACMobile = "Autoklickare",
        Invis = "Osynlig",
        ResetChar = "Återställ Karaktär",
        ExecEgor = "Kör Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Korshår",
        TPName = "TP Till Spelare",
        TPBtn = "TELEPORTERA",
        ExecCode = "KÖR",
        ClearCode = "RENSA",
        CopyCode = "KOPIERA",
        CloneHolder = "Klona (Namn/ID)",
        CloneBtn = "KLONA",
        HeadlessBtn = "HUVUDLÖS",
        AntiFlingBtn = "Anti-Kast",
        NDSBtn = "TESTA KATASTROF",
        EmoteHolder = "Animations-ID...",
        EmoteBtn = "SPELA",
        StatsBtn = "Visa FPS",
        SearchMusic = "Sök Ljud...",
        NowPlaying = "Spelar Inget",
        BtnPlayPause = "SPELA / PAUS",
        BtnStop = "STOPP",
        BtnNext = "NÄSTA",
        BtnPrev = "FÖREGÅENDE",
        BtnStart = "STARTA",
        BtnStopAC = "STOPP",
        PointsStr = "Poäng: ",
        SpeedStr = "Fart",
        AdvCrossTitle = "Korshår Inställningar",
        SizeStr = "Storlek",
        TransStr = "Transparens",
        ImgStr = "Bild-ID",
        TglSpin = "Rotera",
        TglRain = "Regnbåge",
        TglShape = "Form",
        RedStr = "Röd",
        CyanStr = "Cyan",
        AdvBoostTitle = "Boost Inställningar",
        PlasMode = "Plastläge",
        BitMode = "6-BIT",
        NoPart = "Inga Partiklar",
        AdvShadeTitle = "Skuggor",
        TglShade = "Skuggor",
        TglBlur = "Oskärpa",
        HighCon = "Kontrast",
        NotifFound = "Hittad",
        NotifErr = "Fel",
        NotifExec = "Körd",
        NotifSucc = "Lyckades",
        CloneSucc = "Klonad!",
        CloneFail = "Hittades Inte!",
        HeadSucc = "Aktiv!",
        AnimFail = "Misslyckades!",
        DisasterT = "KATASTROF",
        DisasterD = "Spring!"
    },
    CS = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "JAZYK: ČEŠTINA",
        TabMain = "HRÁČ",
        TabVisual = "VIZUÁLY",
        TabTools = "NÁSTROJE",
        TabWorld = "SVĚT",
        TabExec = "SPUSTIT",
        TabUlt = "ULTIMÁTNÍ",
        TabMusic = "HUDBA",
        Fly = "Létání",
        FlySpeed = "Rychlost letu",
        InfJump = "Nekon. skok",
        DoubleJump = "Dvojitý skok",
        Wallhop = "Skok od zdi",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Zapnout rychlost",
        SetSpeed = "Nastavit rychlost",
        EnableJump = "Zapnout skok",
        SetJump = "Nastavit skok",
        EnableGrav = "Zapnout gravitaci",
        SetGrav = "Nastavit gravitaci",
        Freeze = "Zmrazit",
        GodMode = "Nesmrtelnost",
        Noclip = "Přes zdi",
        Tornado = "Tornádo",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Max. Jas",
        CapFPS = "120 FPS",
        ACMobile = "Autoklikr",
        Invis = "Neviditelnost",
        ResetChar = "Resetovat",
        ExecEgor = "Spustit Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Zaměřovač",
        TPName = "TP K Hráči",
        TPBtn = "TELEPORTOVAT",
        ExecCode = "SPUSTIT",
        ClearCode = "VYMAZAT",
        CopyCode = "KOPÍROVAT",
        CloneHolder = "Klonovat (Jméno/ID)",
        CloneBtn = "KLONOVAT",
        HeadlessBtn = "BEZ HLAVY",
        AntiFlingBtn = "Anti-Fling",
        NDSBtn = "TEST KATASTROFY",
        EmoteHolder = "ID Animace...",
        EmoteBtn = "PŘEHRÁT",
        StatsBtn = "Ukázat FPS",
        SearchMusic = "Hledat hudbu...",
        NowPlaying = "Nic nehraje",
        BtnPlayPause = "HRÁT / PAUZA",
        BtnStop = "STOP",
        BtnNext = "DALŠÍ",
        BtnPrev = "PŘEDCHOZÍ",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Body: ",
        SpeedStr = "Rychlost",
        AdvCrossTitle = "Nastavení zaměřovače",
        SizeStr = "Velikost",
        TransStr = "Průhlednost",
        ImgStr = "ID Obrázku",
        TglSpin = "Rotace",
        TglRain = "Duha",
        TglShape = "Tvar",
        RedStr = "Červená",
        CyanStr = "Tyrkysová",
        AdvBoostTitle = "Nastavení Boostu",
        PlasMode = "Plastový mód",
        BitMode = "6-BIT",
        NoPart = "Bez částic",
        AdvShadeTitle = "Stíny",
        TglShade = "Zapnout stíny",
        TglBlur = "Rozmazání",
        HighCon = "Kontrast",
        NotifFound = "Nalezeno",
        NotifErr = "Chyba",
        NotifExec = "Spuštěno",
        NotifSucc = "Úspěch",
        CloneSucc = "Klonováno!",
        CloneFail = "Nenalezeno!",
        HeadSucc = "Aktivní!",
        AnimFail = "Selhalo!",
        DisasterT = "KATASTROFA",
        DisasterD = "Uteč!"
    },
    HU = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "NYELV: MAGYAR",
        TabMain = "JÁTÉKOS",
        TabVisual = "VIZUÁLIS",
        TabTools = "ESZKÖZÖK",
        TabWorld = "VILÁG",
        TabExec = "FUTTATÓ",
        TabUlt = "ULTIMÉT",
        TabMusic = "ZENE",
        Fly = "Repülés",
        FlySpeed = "Repülés Seb.",
        InfJump = "Végtelen Ugrás",
        DoubleJump = "Dupla Ugrás",
        Wallhop = "Fal Ugrás",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Sebesség Be",
        SetSpeed = "Sebesség Állítás",
        EnableJump = "Ugrás Be",
        SetJump = "Ugrás Állítás",
        EnableGrav = "Gravitáció Be",
        SetGrav = "Gravitáció Állítás",
        Freeze = "Fagyasztás",
        GodMode = "Isten Mód",
        Noclip = "Falon Át",
        Tornado = "Tornádó",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Max Fényerő",
        CapFPS = "120 FPS",
        ACMobile = "Auto Klikker",
        Invis = "Láthatatlan",
        ResetChar = "Reset",
        ExecEgor = "Egor Futtatása",
        ExecXayz = "Xayz ESP",
        UltCross = "Célkereszt",
        TPName = "TP Játékoshoz",
        TPBtn = "TELEPORT",
        ExecCode = "FUTTAT",
        ClearCode = "TÖRLÉS",
        CopyCode = "MÁSOLÁS",
        CloneHolder = "Klónozás (Név/ID)",
        CloneBtn = "KLÓNOZÁS",
        HeadlessBtn = "FEJ NÉLKÜL",
        AntiFlingBtn = "Anti-Kilökés",
        NDSBtn = "KATASZTRÓFA TESZT",
        EmoteHolder = "Animáció ID...",
        EmoteBtn = "LEJÁTSZÁS",
        StatsBtn = "FPS Mutatása",
        SearchMusic = "Keresés...",
        NowPlaying = "Nincs Zene",
        BtnPlayPause = "PLAY / SZÜNET",
        BtnStop = "STOP",
        BtnNext = "KÖVETKEZŐ",
        BtnPrev = "ELŐZŐ",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Pontok: ",
        SpeedStr = "Sebesség",
        AdvCrossTitle = "Célkereszt Beállítás",
        SizeStr = "Méret",
        TransStr = "Átlátszóság",
        ImgStr = "Kép ID",
        TglSpin = "Forgás",
        TglRain = "Szivárvány",
        TglShape = "Forma",
        RedStr = "Piros",
        CyanStr = "Cián",
        AdvBoostTitle = "Boost Beállítás",
        PlasMode = "Műanyag Mód",
        BitMode = "6-BIT",
        NoPart = "Nincs Részecske",
        AdvShadeTitle = "Árnyékok",
        TglShade = "Árnyék Be",
        TglBlur = "Elmosás",
        HighCon = "Kontraszt",
        NotifFound = "Megtalálva",
        NotifErr = "Hiba",
        NotifExec = "Futtatva",
        NotifSucc = "Siker",
        CloneSucc = "Klónozva!",
        CloneFail = "Nem Található!",
        HeadSucc = "Aktív!",
        AnimFail = "Sikertelen!",
        DisasterT = "KATASZTRÓFA",
        DisasterD = "Fuss!"
    },
    RO = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "LIMBA: ROMÂNĂ",
        TabMain = "JUCĂTOR",
        TabVisual = "VIZUAL",
        TabTools = "UNELTE",
        TabWorld = "LUME",
        TabExec = "EXECUTOR",
        TabUlt = "ULTIM",
        TabMusic = "MUZICĂ",
        Fly = "Zbor",
        FlySpeed = "Viteză Zbor",
        InfJump = "Săritură Infinită",
        DoubleJump = "Săritură Dublă",
        Wallhop = "Săritură Zid",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Viteză On",
        SetSpeed = "Setează Viteză",
        EnableJump = "Săritură On",
        SetJump = "Setează Săritură",
        EnableGrav = "Gravitație On",
        SetGrav = "Setează Grav.",
        Freeze = "Îngheață",
        GodMode = "Mod Dumnezeu",
        Noclip = "Prin Pereți",
        Tornado = "Tornadă",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Luminozitate Max",
        CapFPS = "120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Invizibil",
        ResetChar = "Resetare",
        ExecEgor = "Rulează Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Țintă",
        TPName = "TP La Jucător",
        TPBtn = "TELEPORTEAZĂ",
        ExecCode = "RULEAZĂ",
        ClearCode = "ȘTERGE",
        CopyCode = "COPIAZĂ",
        CloneHolder = "Clonează (Nume/ID)",
        CloneBtn = "CLONEAZĂ",
        HeadlessBtn = "FĂRĂ CAP",
        AntiFlingBtn = "Anti-Zbor",
        NDSBtn = "TEST DEZASTRU",
        EmoteHolder = "ID Animație...",
        EmoteBtn = "JOACĂ",
        StatsBtn = "Arată FPS",
        SearchMusic = "Caută Audio...",
        NowPlaying = "Nimic în redare",
        BtnPlayPause = "PLAY / PAUZĂ",
        BtnStop = "STOP",
        BtnNext = "URMĂTOR",
        BtnPrev = "ANTERIOR",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Puncte: ",
        SpeedStr = "Viteză",
        AdvCrossTitle = "Setări Țintă",
        SizeStr = "Mărime",
        TransStr = "Transparență",
        ImgStr = "ID Imagine",
        TglSpin = "Rotește",
        TglRain = "Curcubeu",
        TglShape = "Formă",
        RedStr = "Roșu",
        CyanStr = "Cyan",
        AdvBoostTitle = "Setări Boost",
        PlasMode = "Mod Plastic",
        BitMode = "6-BIT",
        NoPart = "Fără Particule",
        AdvShadeTitle = "Umbre",
        TglShade = "Umbre On",
        TglBlur = "Ceață",
        HighCon = "Contrast",
        NotifFound = "Găsit",
        NotifErr = "Eroare",
        NotifExec = "Rulat",
        NotifSucc = "Succes",
        CloneSucc = "Clonat!",
        CloneFail = "Nu S-a Găsit!",
        HeadSucc = "Activ!",
        AnimFail = "Eșuat!",
        DisasterT = "DEZASTRU",
        DisasterD = "Fugi!"
    },
    FI = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "KIELI: SUOMI",
        TabMain = "PELAAJA",
        TabVisual = "VISUAALIT",
        TabTools = "TYÖKALUT",
        TabWorld = "MAAILMA",
        TabExec = "SUORITA",
        TabUlt = "ULTIMATE",
        TabMusic = "MUSIIKKI",
        Fly = "Lento",
        FlySpeed = "Lentonopeus",
        InfJump = "Loputon Hyppy",
        DoubleJump = "Tuplahyppy",
        Wallhop = "Seinähyppy",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Nopeus Päälle",
        SetSpeed = "Aseta Nopeus",
        EnableJump = "Hyppy Päälle",
        SetJump = "Aseta Hyppy",
        EnableGrav = "Painovoima Päälle",
        SetGrav = "Aseta Painovoima",
        Freeze = "Jäädytä",
        GodMode = "Jumaltila",
        Noclip = "Seinien Läpi",
        Tornado = "Tornado",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Täysi Kirkkaus",
        CapFPS = "120 FPS",
        ACMobile = "Autoclicker",
        Invis = "Näkymätön",
        ResetChar = "Nollaa Hahmo",
        ExecEgor = "Suorita Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Tähtäin",
        TPName = "TP Pelaajaan",
        TPBtn = "TELEPORTTAA",
        ExecCode = "SUORITA",
        ClearCode = "TYHJENNÄ",
        CopyCode = "KOPIOI",
        CloneHolder = "Kloonaa (Nimi/ID)",
        CloneBtn = "KLOONAA",
        HeadlessBtn = "ILMAN PÄÄTÄ",
        AntiFlingBtn = "Anti-Heitto",
        NDSBtn = "TESTAA KATASTROFI",
        EmoteHolder = "Animaatio ID...",
        EmoteBtn = "TOISTA",
        StatsBtn = "Näytä FPS",
        SearchMusic = "Etsi Ääntä...",
        NowPlaying = "Ei Soi Mitään",
        BtnPlayPause = "TOISTA / TAUKO",
        BtnStop = "SEIS",
        BtnNext = "SEURAAVA",
        BtnPrev = "EDELLINEN",
        BtnStart = "ALKU",
        BtnStopAC = "SEIS",
        PointsStr = "Pisteet: ",
        SpeedStr = "Nopeus",
        AdvCrossTitle = "Tähtäimen Asetukset",
        SizeStr = "Koko",
        TransStr = "Läpinäkyvyys",
        ImgStr = "Kuvan ID",
        TglSpin = "Pyöri",
        TglRain = "Sateenkaari",
        TglShape = "Muoto",
        RedStr = "Punainen",
        CyanStr = "Syaani",
        AdvBoostTitle = "Boost Asetukset",
        PlasMode = "Muovitila",
        BitMode = "6-BIT",
        NoPart = "Ei Hiukkasia",
        AdvShadeTitle = "Varjot",
        TglShade = "Varjot Päälle",
        TglBlur = "Sumennus",
        HighCon = "Kontrasti",
        NotifFound = "Löydetty",
        NotifErr = "Virhe",
        NotifExec = "Suoritettu",
        NotifSucc = "Onnistui",
        CloneSucc = "Kloonattu!",
        CloneFail = "Ei Löytynyt!",
        HeadSucc = "Aktiivinen!",
        AnimFail = "Epäonnistui!",
        DisasterT = "KATASTROFI",
        DisasterD = "Juokse!"
    },
    DA = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "SPROG: DANSK",
        TabMain = "SPILLER",
        TabVisual = "VISUEL",
        TabTools = "VÆRKTØJER",
        TabWorld = "VERDEN",
        TabExec = "KØR",
        TabUlt = "ULTIMATIV",
        TabMusic = "MUSIK",
        Fly = "Flyv",
        FlySpeed = "Flyvehastighed",
        InfJump = "Uendeligt Hop",
        DoubleJump = "Dobbelt Hop",
        Wallhop = "Væghop",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Aktivér Fart",
        SetSpeed = "Sæt Fart",
        EnableJump = "Aktivér Hop",
        SetJump = "Sæt Hop",
        EnableGrav = "Aktivér Tyngdekraft",
        SetGrav = "Sæt Tyngdekraft",
        Freeze = "Frys",
        GodMode = "Gud-tilstand",
        Noclip = "Gennem Vægge",
        Tornado = "Tornado",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Fuld Lys",
        CapFPS = "120 FPS",
        ACMobile = "Auto Klikker",
        Invis = "Usynlig",
        ResetChar = "Nulstil Karakter",
        ExecEgor = "Kør Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Sigtekorn",
        TPName = "TP Til Spiller",
        TPBtn = "TELEPORTÉR",
        ExecCode = "KØR",
        ClearCode = "RYD",
        CopyCode = "KOPIÉR",
        CloneHolder = "Klon (Navn/ID)",
        CloneBtn = "KLON",
        HeadlessBtn = "UDEN HOVED",
        AntiFlingBtn = "Anti-Kast",
        NDSBtn = "TEST KATASTROFE",
        EmoteHolder = "Animation ID...",
        EmoteBtn = "AFSPIL",
        StatsBtn = "Vis FPS",
        SearchMusic = "Søg Lyd...",
        NowPlaying = "Spiller Intet",
        BtnPlayPause = "AFSPIL / PAUSE",
        BtnStop = "STOP",
        BtnNext = "NÆSTE",
        BtnPrev = "FORRIGE",
        BtnStart = "START",
        BtnStopAC = "STOP",
        PointsStr = "Point: ",
        SpeedStr = "Fart",
        AdvCrossTitle = "Sigte Indstillinger",
        SizeStr = "Størrelse",
        TransStr = "Gennemsigtighed",
        ImgStr = "Billede ID",
        TglSpin = "Rotér",
        TglRain = "Regnbue",
        TglShape = "Form",
        RedStr = "Rød",
        CyanStr = "Cyan",
        AdvBoostTitle = "Boost Indstillinger",
        PlasMode = "Plastik Mode",
        BitMode = "6-BIT",
        NoPart = "Ingen Partikler",
        AdvShadeTitle = "Skygger",
        TglShade = "Skygger On",
        TglBlur = "Sløring",
        HighCon = "Kontrast",
        NotifFound = "Fundet",
        NotifErr = "Fejl",
        NotifExec = "Kørt",
        NotifSucc = "Succes",
        CloneSucc = "Klonet!",
        CloneFail = "Ikke Fundet!",
        HeadSucc = "Aktiv!",
        AnimFail = "Fejlede!",
        DisasterT = "KATASTROFE",
        DisasterD = "Løb!"
    },
    NO = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "SPRÅK: NORSK",
        TabMain = "SPILLER",
        TabVisual = "VISUELL",
        TabTools = "VERKTØY",
        TabWorld = "VERDEN",
        TabExec = "KJØR",
        TabUlt = "ULTIMAT",
        TabMusic = "MUSIKK",
        Fly = "Fly",
        FlySpeed = "Flyfart",
        InfJump = "Uendelig Hopp",
        DoubleJump = "Dobbelt Hopp",
        Wallhop = "Vegghopp",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Aktiver Fart",
        SetSpeed = "Sett Fart",
        EnableJump = "Aktiver Hopp",
        SetJump = "Sett Hopp",
        EnableGrav = "Aktiver Tyngdekraft",
        SetGrav = "Sett Tyngdekraft",
        Freeze = "Frys",
        GodMode = "Gudemodus",
        Noclip = "Gjennom Vegger",
        Tornado = "Tornado",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Maks Lys",
        CapFPS = "120 FPS",
        ACMobile = "Auto Klikker",
        Invis = "Usynlig",
        ResetChar = "Tilbakestill",
        ExecEgor = "Kjør Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Sikte",
        TPName = "TP Til Spiller",
        TPBtn = "TELEPORTER",
        ExecCode = "KJØR",
        ClearCode = "TØM",
        CopyCode = "KOPIER",
        CloneHolder = "Klon (Navn/ID)",
        CloneBtn = "KLON",
        HeadlessBtn = "HODELØS",
        AntiFlingBtn = "Anti-Kast",
        NDSBtn = "TEST KATASTROFE",
        EmoteHolder = "Animasjon ID...",
        EmoteBtn = "SPILL AV",
        StatsBtn = "Vis FPS",
        SearchMusic = "Søk Lyd...",
        NowPlaying = "Spiller Ingenting",
        BtnPlayPause = "SPILL / PAUSE",
        BtnStop = "STOPP",
        BtnNext = "NESTE",
        BtnPrev = "FORRIGE",
        BtnStart = "START",
        BtnStopAC = "STOPP",
        PointsStr = "Poeng: ",
        SpeedStr = "Fart",
        AdvCrossTitle = "Sikte Innstillinger",
        SizeStr = "Størrelse",
        TransStr = "Gjennomsiktighet",
        ImgStr = "Bilde ID",
        TglSpin = "Roter",
        TglRain = "Regnbue",
        TglShape = "Form",
        RedStr = "Rød",
        CyanStr = "Cyan",
        AdvBoostTitle = "Boost Innstillinger",
        PlasMode = "Plast Modus",
        BitMode = "6-BIT",
        NoPart = "Ingen Partikler",
        AdvShadeTitle = "Skygger",
        TglShade = "Skygger På",
        TglBlur = "Uskarphet",
        HighCon = "Kontrast",
        NotifFound = "Funnet",
        NotifErr = "Feil",
        NotifExec = "Kjørt",
        NotifSucc = "Suksess",
        CloneSucc = "Klonet!",
        CloneFail = "Ikke Funnet!",
        HeadSucc = "Aktiv!",
        AnimFail = "Feilet!",
        DisasterT = "KATASTROFE",
        DisasterD = "Løp!"
    },
    EL = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "ΓΛΩΣΣΑ: ΕΛΛΗΝΙΚΑ",
        TabMain = "ΠΑΙΚΤΗΣ",
        TabVisual = "ΟΠΤΙΚΑ",
        TabTools = "ΕΡΓΑΛΕΙΑ",
        TabWorld = "ΚΟΣΜΟΣ",
        TabExec = "ΕΚΤΕΛΕΣΗ",
        TabUlt = "ΑΠΟΛΥΤΟ",
        TabMusic = "ΜΟΥΣΙΚΗ",
        Fly = "Πτήση",
        FlySpeed = "Ταχύτητα Πτήσης",
        InfJump = "Άπειρο Άλμα",
        DoubleJump = "Διπλό Άλμα",
        Wallhop = "Άλμα Τοίχου",
        AntiAfk = "Anti-AFK",
        EnableSpeed = "Ενεργ. Ταχύτητας",
        SetSpeed = "Ορισμός Ταχύτητας",
        EnableJump = "Ενεργ. Άλματος",
        SetJump = "Ορισμός Άλματος",
        EnableGrav = "Ενεργ. Βαρύτητας",
        SetGrav = "Ορισμός Βαρύτητας",
        Freeze = "Πάγωμα",
        GodMode = "Λειτουργία Θεού",
        Noclip = "Πέρασμα Τοίχων",
        Tornado = "Ανεμοστρόβιλος",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Πλήρης Φωτεινότητα",
        CapFPS = "Όριο 120 FPS",
        ACMobile = "Auto Clicker",
        Invis = "Αόρατος",
        ResetChar = "Επαναφορά",
        ExecEgor = "Εκτέλεση Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Στόχαστρο",
        TPName = "TP Σε (Όνομα)",
        TPBtn = "ΤΗΛΕΜΕΤΑΦΟΡΑ",
        ExecCode = "ΕΚΤΕΛΕΣΗ",
        ClearCode = "ΚΑΘΑΡΙΣΜΟΣ",
        CopyCode = "ΑΝΤΙΓΡΑΦΗ",
        CloneHolder = "Κλωνοποίηση (ID)",
        CloneBtn = "ΚΛΩΝΟΠΟΙΗΣΗ",
        HeadlessBtn = "ΧΩΡΙΣ ΚΕΦΑΛΙ",
        AntiFlingBtn = "Anti-Fling",
        NDSBtn = "ΤΕΣΤ ΚΑΤΑΣΤΡΟΦΗΣ",
        EmoteHolder = "ID Κίνησης...",
        EmoteBtn = "ΠΑΙΞΕ",
        StatsBtn = "Εμφάνιση FPS",
        SearchMusic = "Αναζήτηση Ήχου...",
        NowPlaying = "Δεν παίζει τίποτα",
        BtnPlayPause = "ΠΑΙΞΕ / ΠΑΥΣΗ",
        BtnStop = "ΣΤΟΠ",
        BtnNext = "ΕΠΟΜΕΝΟ",
        BtnPrev = "ΠΡΟΗΓΟΥΜΕΝΟ",
        BtnStart = "ΕΝΑΡΞΗ",
        BtnStopAC = "ΣΤΟΠ",
        PointsStr = "Πόντοι: ",
        SpeedStr = "Ταχύτητα",
        AdvCrossTitle = "Ρυθμίσεις Στόχου",
        SizeStr = "Μέγεθος",
        TransStr = "Διαφάνεια",
        ImgStr = "ID Εικόνας",
        TglSpin = "Περιστροφή",
        TglRain = "Ουράνιο Τόξο",
        TglShape = "Σχήμα",
        RedStr = "Κόκκινο",
        CyanStr = "Κυανό",
        AdvBoostTitle = "Ρυθμίσεις Boost",
        PlasMode = "Πλαστικό Μοντέλο",
        BitMode = "6-BIT",
        NoPart = "Χωρίς Σωματίδια",
        AdvShadeTitle = "Σκιές",
        TglShade = "Σκιές Ενεργές",
        TglBlur = "Θόλωμα",
        HighCon = "Αντίθεση",
        NotifFound = "Βρέθηκε",
        NotifErr = "Σφάλμα",
        NotifExec = "Εκτελέστηκε",
        NotifSucc = "Επιτυχία",
        CloneSucc = "Κλωνοποιήθηκε!",
        CloneFail = "Δεν Βρέθηκε!",
        HeadSucc = "Ενεργό!",
        AnimFail = "Απέτυχε!",
        DisasterT = "ΚΑΤΑΣΤΡΟΦΗ",
        DisasterD = "Τρέξε!"
    },
    BG = {
        Title = "🖥️ Xayz Panel Lite",
        LangBtn = "ЕЗИК: БЪЛГАРСКИ",
        TabMain = "ИГРАЧ",
        TabVisual = "ВИЗУАЛНИ",
        TabTools = "ИНСТРУМΕΝТИ",
        TabWorld = "СВЯТ",
        TabExec = "ИЗПЪЛНИ",
        TabUlt = "УЛТИМАТ",
        TabMusic = "МУЗИКА",
        Fly = "Летене",
        FlySpeed = "Скорост Летене",
        InfJump = "Безкр. Скок",
        DoubleJump = "Двоен Скок",
        Wallhop = "Скок от Стена",
        AntiAfk = "Анти-AFK",
        EnableSpeed = "Вкл. Скорост",
        SetSpeed = "Задай Скорост",
        EnableJump = "Вкл. Скок",
        SetJump = "Задай Скок",
        EnableGrav = "Вкл. Гравитация",
        SetGrav = "Задай Гравит.",
        Freeze = "Замръзване",
        GodMode = "Режим Бог",
        Noclip = "През Стени",
        Tornado = "Торнадо",
        Booster = "FPS Boost",
        Roshade = "Roshade (4K)",
        FullBright = "Макс. Светлина",
        CapFPS = "120 FPS Лимит",
        ACMobile = "Автокликер",
        Invis = "Невидим",
        ResetChar = "Ресет",
        ExecEgor = "Пусни Egor",
        ExecXayz = "Xayz ESP",
        UltCross = "Мерник",
        TPName = "TP към (Име)",
        TPBtn = "ТЕЛЕПОРТ",
        ExecCode = "ИЗПЪЛНИ",
        ClearCode = "ИЗЧИСТИ",
        CopyCode = "КОПИРАЙ",
        CloneHolder = "Клонирай (ID)",
        CloneBtn = "КЛОНИРАЙ",
        HeadlessBtn = "БЕЗ ГЛАВА",
        AntiFlingBtn = "Анти-Отхвърляне",
        NDSBtn = "ТЕСТ БЕДСТВИЕ",
        EmoteHolder = "ID Анимация...",
        EmoteBtn = "ПУСНИ",
        StatsBtn = "Покажи FPS",
        SearchMusic = "Търси Аудио...",
        NowPlaying = "Нищо не свири",
        BtnPlayPause = "ПЛЕЙ / ПАУЗА",
        BtnStop = "СТОП",
        BtnNext = "СЛЕДВАЩ",
        BtnPrev = "ПРЕДИШЕН",
        BtnStart = "СТАРТ",
        BtnStopAC = "СТОП",
        PointsStr = "Точки: ",
        SpeedStr = "Скорост",
        AdvCrossTitle = "Мерник Настройки",
        SizeStr = "Размер",
        TransStr = "Прозрачност",
        ImgStr = "ID Снимка",
        TglSpin = "Въртене",
        TglRain = "Дъга",
        TglShape = "Форма",
        RedStr = "Червено",
        CyanStr = "Циан",
        AdvBoostTitle = "Boost Настройки",
        PlasMode = "Пластмасов Мод",
        BitMode = "6-BIT",
        NoPart = "Без Частици",
        AdvShadeTitle = "Сенки",
        TglShade = "Вкл. Сенки",
        TglBlur = "Замъгляване",
        HighCon = "Контраст",
        NotifFound = "Намерено",
        NotifErr = "Грешка",
        NotifExec = "Изпълнено",
        NotifSucc = "Успех",
        CloneSucc = "Клониран!",
        CloneFail = "Не е Намерен!",
        HeadSucc = "Активен!",
        AnimFail = "Провал!",
        DisasterT = "БЕДСТВИЕ",
        DisasterD = "Бягай!"
    }
}

local LocalizedElements = {

}

for lang, data in pairs(Translations) do
    data["TglSuperFling"] = "Super Fling"
    data["TglFlingV2"] = "Fling V2"
    data["SetFlingPower"] = "Set Fling Power"
    data["TglDino"] = "Dino Animation"
    data["TglPunch"] = "Punch Animation"
end

local function RegisterLang(instance, key, isPlaceholder)
    local item = {
        Element = instance,
        Key = key,
        IsPlaceholder = isPlaceholder
    }
    table.insert(LocalizedElements, item)
    
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
ScreenGui.Name = "XayzExV3"

local successGui, errGui = pcall(function()
    ScreenGui.Parent = CoreGui
end)

if successGui then

else
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function MakeDraggable(frame)
    local dragging
    local dragInput
    local dragStart
    local startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        local finalPosX = startPos.X.Offset + delta.X
        local finalPosY = startPos.Y.Offset + delta.Y
        frame.Position = UDim2.new(
            startPos.X.Scale, 
            finalPosX, 
            startPos.Y.Scale, 
            finalPosY
        )
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false 
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

local function ShowNotification(title, msg)
    local NotifFrame = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TitleLabel = Instance.new("TextLabel")
    local DescLabel = Instance.new("TextLabel")
    
    NotifFrame.Name = "Notif"
    NotifFrame.Parent = ScreenGui
    NotifFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    NotifFrame.BorderColor3 = Color3.fromRGB(0, 255, 150)
    NotifFrame.BorderSizePixel = 1
    NotifFrame.Position = UDim2.new(0.5, -125, 0, -100)
    NotifFrame.Size = UDim2.new(0, 250, 0, 70)
    NotifFrame.ZIndex = 500
    
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = NotifFrame
    
    TitleLabel.Parent = NotifFrame
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 10, 0, 5)
    TitleLabel.Size = UDim2.new(1, -20, 0, 20)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = title
    TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    DescLabel.Parent = NotifFrame
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 10, 0, 25)
    DescLabel.Size = UDim2.new(1, -20, 0, 40)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = msg
    DescLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DescLabel.TextSize = 12
    DescLabel.TextWrapped = true
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local TweenInPos = UDim2.new(0.5, -125, 0, 60)
    NotifFrame:TweenPosition(TweenInPos, Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.5, true)
    
    task.delay(3, function()
        local TweenOutPos = UDim2.new(0.5, -125, 0, -150)
        NotifFrame:TweenPosition(TweenOutPos, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.5, true)
        task.wait(0.5)
        NotifFrame:Destroy()
    end)
end

local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local Header = Instance.new("Frame")
local Sidebar = Instance.new("Frame")
local ContentArea = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local MinimizeBtn = Instance.new("TextButton")
local MaximizeBtn = Instance.new("TextButton")

MainFrame.Name = "MainBox"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.Position = UDim2.new(0.5, -240, 0.5, -160)
MainFrame.Size = UDim2.new(0, 480, 0, 360)
MainFrame.ClipsDescendants = true
MakeDraggable(MainFrame)

MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Header.Size = UDim2.new(1, 0, 0, 40)
Header.ZIndex = 2

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

TitleLabel.Parent = Header
TitleLabel.BackgroundTransparency = 1
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 200)
TitleLabel.TextSize = 16
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 3
RegisterLang(TitleLabel, "Title", false)

MinimizeBtn.Parent = Header
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MinimizeBtn.Position = UDim2.new(1, -100, 0.5, -12)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 16
MinimizeBtn.ZIndex = 3

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeBtn

MaximizeBtn.Parent = Header
MaximizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MaximizeBtn.Position = UDim2.new(1, -65, 0.5, -12)
MaximizeBtn.Size = UDim2.new(0, 24, 0, 24)
MaximizeBtn.Font = Enum.Font.GothamBold
MaximizeBtn.Text = "□"
MaximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MaximizeBtn.TextSize = 18
MaximizeBtn.ZIndex = 3

local MaxCorner = Instance.new("UICorner")
MaxCorner.CornerRadius = UDim.new(0, 6)
MaxCorner.Parent = MaximizeBtn

local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Header
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -12)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 14
CloseBtn.ZIndex = 3

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 130, 1, -40)

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 10)
SidebarCorner.Parent = Sidebar

ContentArea.Name = "Content"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 140, 0, 50)
ContentArea.Size = UDim2.new(1, -150, 1, -60)

local Pages = {

}

local function SwitchPage(pageName)
    for name, page in pairs(Pages) do
        if name == pageName then
            page.Visible = true
        else
            page.Visible = false
        end
    end
end

local function CreateTabBtn(langKey, pageName, yPos)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Sidebar
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BackgroundTransparency = 1
    Btn.Position = UDim2.new(0, 0, 0, yPos)
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    Btn.TextSize = 12
    RegisterLang(Btn, langKey, false)
    
    Btn.MouseButton1Click:Connect(function()
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
        end
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        SwitchPage(pageName)
    end)
    return Btn
end

local function CreatePage(name)
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name
    Page.Parent = ContentArea
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0, 0, 0, 0) 
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Visible = false
    Pages[name] = Page
    
    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Page
    UIList.Padding = UDim.new(0, 8)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    
    return Page
end

local PageMain = CreatePage("Main")
local PageVisual = CreatePage("Visual")
local PageTools = CreatePage("Tools")
local PageWorld = CreatePage("World")
local PageExecutor = CreatePage("Executor")
local PageUltimate = CreatePage("Ultimate")
local PageMusic = CreatePage("Music")

local LangSwitcherBtn = Instance.new("TextButton")
LangSwitcherBtn.Parent = Sidebar
LangSwitcherBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
LangSwitcherBtn.Position = UDim2.new(0, 5, 0, 5)
LangSwitcherBtn.Size = UDim2.new(1, -10, 0, 30)
LangSwitcherBtn.Font = Enum.Font.GothamBold
LangSwitcherBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangSwitcherBtn.TextSize = 10
RegisterLang(LangSwitcherBtn, "LangBtn", false)

local LangCorner = Instance.new("UICorner")
LangCorner.CornerRadius = UDim.new(0, 6)
LangCorner.Parent = LangSwitcherBtn

LangSwitcherBtn.MouseButton1Click:Connect(function()
    CurrentLangIndex = CurrentLangIndex + 1
    if CurrentLangIndex > #Languages then
        CurrentLangIndex = 1
    end
    UpdateAllLanguage()
end)

SwitchPage("Main")
local T1 = CreateTabBtn("TabMain", "Main", 40)
T1.TextColor3 = Color3.fromRGB(255, 255, 255)
CreateTabBtn("TabVisual", "Visual", 80)
CreateTabBtn("TabTools", "Tools", 120)
CreateTabBtn("TabWorld", "World", 160)
CreateTabBtn("TabExec", "Executor", 200)
CreateTabBtn("TabUlt", "Ultimate", 240)
CreateTabBtn("TabMusic", "Music", 280)

MinimizeBtn.MouseButton1Click:Connect(function()
    local TweenMinPos = UDim2.new(0, 480, 0, 40)
    MainFrame:TweenSize(TweenMinPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    Sidebar.Visible = false
    ContentArea.Visible = false
end)

MaximizeBtn.MouseButton1Click:Connect(function()
    local TweenMaxPos = UDim2.new(0, 480, 0, 360)
    MainFrame:TweenSize(TweenMaxPos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
    task.wait(0.3)
    Sidebar.Visible = true
    ContentArea.Visible = true
end)

local function CreateToggle(page, langKey, callback)
    local Frame = Instance.new("Frame")
    local Button = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Label = Instance.new("TextLabel")
    local Status = Instance.new("Frame")
    local StatusCorner = Instance.new("UICorner")
    
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -5, 0, 35)
    
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame
    
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    RegisterLang(Label, langKey, false)
    
    Button.Parent = Frame
    Button.Position = UDim2.new(1, -50, 0.5, -8)
    Button.Size = UDim2.new(0, 40, 0, 16)
    Button.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Button.Text = ""
    
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Button
    
    Status.Parent = Button
    Status.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    Status.Position = UDim2.new(0, 2, 0.5, -6)
    Status.Size = UDim2.new(0, 12, 0, 12)
    
    StatusCorner.CornerRadius = UDim.new(1, 0)
    StatusCorner.Parent = Status
    
    local enabled = false
    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            local TweenOnInfo = TweenInfo.new(0.2)
            local TweenOnProp = {
                Position = UDim2.new(1, -14, 0.5, -6), 
                BackgroundColor3 = Color3.fromRGB(50, 255, 100)
            }
            TweenService:Create(Status, TweenOnInfo, TweenOnProp):Play()
        else
            local TweenOffInfo = TweenInfo.new(0.2)
            local TweenOffProp = {
                Position = UDim2.new(0, 2, 0.5, -6), 
                BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            }
            TweenService:Create(Status, TweenOffInfo, TweenOffProp):Play()
        end
        callback(enabled)
    end)
    return Frame
end

local function CreateInput(page, langKey, callback)
    local Box = Instance.new("TextBox")
    local Corner = Instance.new("UICorner")
    
    Box.Parent = page
    Box.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Box.Size = UDim2.new(1, -5, 0, 35)
    Box.Font = Enum.Font.Gotham
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 12
    Box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    RegisterLang(Box, langKey, true)
    
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Box
    
    Box.FocusLost:Connect(function()
        callback(Box.Text)
    end)
    return Box
end

local function CreateStepper(page, langKey, callback)
    local Frame = Instance.new("Frame")
    Frame.Parent = page
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -5, 0, 35)
    local FCorner = Instance.new("UICorner")
    FCorner.CornerRadius = UDim.new(0, 6)
    FCorner.Parent = Frame

    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.4, 0, 1, 0)
    Label.Font = Enum.Font.GothamSemibold
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    RegisterLang(Label, langKey, false)

    local MinusBtn = Instance.new("TextButton")
    MinusBtn.Parent = Frame
    MinusBtn.Position = UDim2.new(1, -100, 0.5, -12)
    MinusBtn.Size = UDim2.new(0, 24, 0, 24)
    MinusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinusBtn.Text = "-"
    MinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local MCorner = Instance.new("UICorner")
    MCorner.CornerRadius = UDim.new(0, 4)
    MCorner.Parent = MinusBtn

    local ValueBox = Instance.new("TextBox")
    ValueBox.Parent = Frame
    ValueBox.Position = UDim2.new(1, -70, 0.5, -12)
    ValueBox.Size = UDim2.new(0, 34, 0, 24)
    ValueBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ValueBox.Text = tostring(State.FlySpeed)
    ValueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    local VCorner = Instance.new("UICorner")
    VCorner.CornerRadius = UDim.new(0, 4)
    VCorner.Parent = ValueBox

    local PlusBtn = Instance.new("TextButton")
    PlusBtn.Parent = Frame
    PlusBtn.Position = UDim2.new(1, -30, 0.5, -12)
    PlusBtn.Size = UDim2.new(0, 24, 0, 24)
    PlusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    PlusBtn.Text = "+"
    PlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    local PCorner = Instance.new("UICorner")
    PCorner.CornerRadius = UDim.new(0, 4)
    PCorner.Parent = PlusBtn

    local function update(newVal)
        State.FlySpeed = newVal
        ValueBox.Text = tostring(State.FlySpeed)
        callback(State.FlySpeed)
    end

    MinusBtn.MouseButton1Click:Connect(function()
        if State.FlySpeed > 1 then
            update(State.FlySpeed - 1)
        end
    end)

    PlusBtn.MouseButton1Click:Connect(function()
        update(State.FlySpeed + 1)
    end)

    ValueBox.FocusLost:Connect(function()
        local num = tonumber(ValueBox.Text)
        if num and num >= 1 then
            update(num)
        else
            update(1)
        end
    end)

    return Frame
end

local function CreateButton(page, langKey, callback, color)
    local Btn = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    
    Btn.Parent = page
    Btn.BackgroundColor3 = color
    Btn.Size = UDim2.new(1, -5, 0, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    RegisterLang(Btn, langKey, false)
    
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn
    
    Btn.MouseButton1Click:Connect(callback)
    return Btn
end

local function CreateAdvancedMenu(parent, langKey, contentFunc)
    local MenuFrame = Instance.new("Frame")
    MenuFrame.Name = "AdvancedMenu"
    MenuFrame.Parent = parent
    MenuFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MenuFrame.Size = UDim2.new(0, 240, 0, 320)
    MenuFrame.Position = UDim2.new(0.5, -120, 0.5, -160)
    MenuFrame.Visible = false
    MenuFrame.ZIndex = 50
    MakeDraggable(MenuFrame)
    
    local MC = Instance.new("UICorner")
    MC.CornerRadius = UDim.new(0, 8)
    MC.Parent = MenuFrame
    
    local Title = Instance.new("TextLabel")
    Title.Parent = MenuFrame
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(0, 255, 200)
    Title.Font = Enum.Font.GothamBold
    Title.ZIndex = 52
    RegisterLang(Title, langKey, false)
    
    local Close = Instance.new("TextButton")
    Close.Parent = MenuFrame
    Close.Text = "X"
    Close.Size = UDim2.new(0, 30, 0, 30)
    Close.Position = UDim2.new(1, -30, 0, 0)
    Close.BackgroundTransparency = 1
    Close.TextColor3 = Color3.fromRGB(255, 50, 50)
    Close.ZIndex = 52
    
    Close.MouseButton1Click:Connect(function()
        MenuFrame.Visible = false
    end)

    local Container = Instance.new("ScrollingFrame")
    Container.Name = "Container"
    Container.Parent = MenuFrame
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 0, 0, 35)
    Container.Size = UDim2.new(1, 0, 1, -35)
    Container.ScrollBarThickness = 2
    Container.ZIndex = 51
    Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    local UIList = Instance.new("UIListLayout")
    UIList.Parent = Container
    UIList.SortOrder = Enum.SortOrder.LayoutOrder
    UIList.Padding = UDim.new(0, 5)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    
    local UIPad = Instance.new("UIPadding")
    UIPad.Parent = Container
    UIPad.PaddingTop = UDim.new(0, 5)
    UIPad.PaddingBottom = UDim.new(0, 5)

    contentFunc(Container)
    
    return MenuFrame
end

local FlyLoop = nil
local FlyBV = nil
local FlyBG = nil
local tpwalking = false

local function StartFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildWhichIsA("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end

    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    if not torso then return end

    if FlyBV then FlyBV:Destroy() end
    if FlyBG then FlyBG:Destroy() end
    tpwalking = true

    FlyBG = Instance.new("BodyGyro")
    FlyBG.P = 9e4
    FlyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    FlyBG.CFrame = torso.CFrame
    FlyBG.Parent = torso

    FlyBV = Instance.new("BodyVelocity")
    FlyBV.Velocity = Vector3.new(0, 0, 0)
    FlyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    FlyBV.Parent = torso

    hum.PlatformStand = true
    
    char.Animate.Disabled = true
    for _, v in next, hum:GetPlayingAnimationTracks() do v:Stop() end

    FlyLoop = RunService.RenderStepped:Connect(function()
        if FlyBV and FlyBG and char.Parent then
            FlyBG.CFrame = Camera.CFrame
            
            local moveDir = hum.MoveDirection
            if moveDir.Magnitude > 0 then
                local camLookFlat = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z).Unit
                local camRightFlat = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z).Unit
                
                local forwardMovement = moveDir:Dot(camLookFlat)
                local rightMovement = moveDir:Dot(camRightFlat)
                
                local flyDir = (Camera.CFrame.LookVector * forwardMovement) + (Camera.CFrame.RightVector * rightMovement)
                
                if flyDir.Magnitude > 0 then
                    flyDir = flyDir.Unit
                end
                
                FlyBV.Velocity = flyDir * (State.FlySpeed * 50)
            else
                FlyBV.Velocity = Vector3.new(0, 0, 0)
            end
        else
            if FlyLoop then FlyLoop:Disconnect() end
        end
    end)
end

local function EndFly()
    tpwalking = false
    if FlyLoop then FlyLoop:Disconnect() end
    if FlyBV then FlyBV:Destroy() end
    if FlyBG then FlyBG:Destroy() end
    
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            hum.PlatformStand = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
        if char:FindFirstChild("Animate") then
            char.Animate.Disabled = false
        end
    end
end

local function UpdateFlySpeed()
    if tpwalking then
        EndFly()
        task.wait(0.1)
        StartFly()
    end
end

local function ApplyStats()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        if State.SpeedEnabled then
            LocalPlayer.Character.Humanoid.WalkSpeed = State.WalkSpeed
        end
        if State.JumpEnabled then
            LocalPlayer.Character.Humanoid.JumpPower = State.JumpPower
        end
        if State.GravityEnabled then
            Workspace.Gravity = State.Gravity
        else
            Workspace.Gravity = 196.2
        end
    end
end

UserInputService.JumpRequest:Connect(function()
    if State.InfJump and LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then
            Hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
    
    if State.DoubleJump and LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum and State.JumpCount < 2 then
            State.JumpCount = State.JumpCount + 1
            Hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end

    if State.Wallhop and LocalPlayer.Character then
        local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            local rayOrigin = HRP.Position
            local multVector = HRP.CFrame.LookVector * 3
            local rayDirection = multVector
            
            local raycastParams = RaycastParams.new()
            local filterTable = {
                LocalPlayer.Character
            }
            raycastParams.FilterDescendantsInstances = filterTable
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            
            local result = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)
            if result then
                local vel = HRP.Velocity
                local newVel = Vector3.new(vel.X, 60, vel.Z)
                HRP.Velocity = newVel
            end
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    local Hum = char:WaitForChild("Humanoid")
    task.wait(0.5)
    ApplyStats()
    
    if State.Fly then
        StartFly()
    end
    
    if State.GodMode then
        Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
    end
    
    if State.Invisible then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1 
            end
            if v:IsA("BillboardGui") then
                v.Enabled = false
            end
        end
        Hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
    end
    
    Hum.StateChanged:Connect(function(old, new)
        if new == Enum.HumanoidStateType.Landed then
            State.JumpCount = 0
        end
    end)
end)

CreateToggle(PageMain, "Fly", function(val)
    State.Fly = val
    if val then
        StartFly() 
    else
        EndFly()
    end
end)

CreateStepper(PageMain, "FlySpeed", function(newSpeed)
    UpdateFlySpeed() 
end)

CreateToggle(PageMain, "InfJump", function(val)
    State.InfJump = val
end)

CreateToggle(PageMain, "DoubleJump", function(val)
    State.DoubleJump = val
end)

CreateToggle(PageMain, "Wallhop", function(val)
    State.Wallhop = val
end)

CreateToggle(PageMain, "AntiAfk", function(val)
    State.AntiAfk = val
end)

CreateToggle(PageMain, "EnableSpeed", function(val)
    State.SpeedEnabled = val
    ApplyStats()
end)

CreateInput(PageMain, "SetSpeed", function(txt)
    local num = tonumber(txt)
    if num then
        State.WalkSpeed = num
    else
        State.WalkSpeed = 16
    end
    ApplyStats()
end)

CreateToggle(PageMain, "EnableJump", function(val)
    State.JumpEnabled = val
    ApplyStats()
end)

CreateInput(PageMain, "SetJump", function(txt)
    local num = tonumber(txt)
    if num then
        State.JumpPower = num
    else
        State.JumpPower = 50
    end
    ApplyStats()
end)

CreateToggle(PageMain, "EnableGrav", function(val)
    State.GravityEnabled = val
    ApplyStats()
end)

CreateInput(PageMain, "SetGrav", function(txt)
    local num = tonumber(txt)
    if num then
        State.Gravity = num
    else
        State.Gravity = 196.2
    end
    ApplyStats()
end)

CreateToggle(PageMain, "Freeze", function(val)
    State.Freeze = val
end)

CreateToggle(PageMain, "GodMode", function(val)
    State.GodMode = val
    if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        ShowNotification(GetString("NotifSucc"), GetString("GodMode"))
    end
end)

CreateToggle(PageMain, "Noclip", function(val)
    State.Noclip = val
end)

CreateToggle(PageMain, "Tornado", function(val)
    State.Tornado = val
end)

local ACMenu = Instance.new("Frame")
ACMenu.Parent = ScreenGui
local ACSize = UDim2.new(0, 130, 0, 180)
ACMenu.Size = ACSize
local ACPos = UDim2.new(0.05, 0, 0.4, 0)
ACMenu.Position = ACPos
ACMenu.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ACMenu.Visible = false
ACMenu.ZIndex = 100
MakeDraggable(ACMenu)

local ACCorner = Instance.new("UICorner")
ACCorner.CornerRadius = UDim.new(0, 8)
ACCorner.Parent = ACMenu

local ACTitle = Instance.new("TextLabel")
ACTitle.Parent = ACMenu
ACTitle.Text = "CLICKER"
local ACTSize = UDim2.new(1,0,0,30)
ACTitle.Size = ACTSize
ACTitle.BackgroundTransparency = 1
ACTitle.TextColor3 = Color3.fromRGB(0, 255, 100)
ACTitle.Font = Enum.Font.GothamBold

local ACStart = Instance.new("TextButton")
ACStart.Parent = ACMenu
local ACSSize = UDim2.new(0.8, 0, 0, 30)
ACStart.Size = ACSSize
local ACSPos = UDim2.new(0.1, 0, 0, 35)
ACStart.Position = ACSPos
ACStart.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ACStart.TextColor3 = Color3.fromRGB(255, 255, 255)
ACStart.Font = Enum.Font.GothamBold
RegisterLang(ACStart, "BtnStart", false)

local ACStartCorner = Instance.new("UICorner")
ACStartCorner.CornerRadius = UDim.new(0, 6)
ACStartCorner.Parent = ACStart

ACStart.MouseButton1Click:Connect(function()
    State.AutoClickerPlaying = not State.AutoClickerPlaying
    if State.AutoClickerPlaying then
        ACStart.Text = GetString("BtnStopAC")
        ACStart.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    else
        ACStart.Text = GetString("BtnStart")
        ACStart.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    end
end)

local ACAdd = Instance.new("TextButton")
ACAdd.Parent = ACMenu
local ACAddSize = UDim2.new(0.35, 0, 0, 30)
ACAdd.Size = ACAddSize
local ACAddPos = UDim2.new(0.1, 0, 0, 70)
ACAdd.Position = ACAddPos
ACAdd.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ACAdd.Text = "+"
ACAdd.TextColor3 = Color3.fromRGB(0, 255, 0)
ACAdd.Font = Enum.Font.GothamBold

local ACAddCorner = Instance.new("UICorner")
ACAddCorner.CornerRadius = UDim.new(0, 6)
ACAddCorner.Parent = ACAdd

local ACRemove = Instance.new("TextButton")
ACRemove.Parent = ACMenu
local ACRemSize = UDim2.new(0.35, 0, 0, 30)
ACRemove.Size = ACRemSize
local ACRemPos = UDim2.new(0.55, 0, 0, 70)
ACRemove.Position = ACRemPos
ACRemove.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ACRemove.Text = "-"
ACRemove.TextColor3 = Color3.fromRGB(255, 0, 0)
ACRemove.Font = Enum.Font.GothamBold

local ACRemCorner = Instance.new("UICorner")
ACRemCorner.CornerRadius = UDim.new(0, 6)
ACRemCorner.Parent = ACRemove

local ACInfo = Instance.new("TextLabel")
ACInfo.Parent = ACMenu
local ACIInfoSize = UDim2.new(1, 0, 0, 20)
ACInfo.Size = ACIInfoSize
local ACIInfoPos = UDim2.new(0, 0, 0, 110)
ACInfo.Position = ACIInfoPos
ACInfo.BackgroundTransparency = 1
ACInfo.Text = "Points: 0"
ACInfo.TextColor3 = Color3.fromRGB(200, 200, 200)

local function UpdateACInfo()
    local combined = GetString("PointsStr") .. #ClickPoints
    ACInfo.Text = combined
end

local ACSpeed = Instance.new("TextBox")
ACSpeed.Parent = ACMenu
local ACSpeedSize = UDim2.new(0.8, 0, 0, 30)
ACSpeed.Size = ACSpeedSize
local ACSpeedPos = UDim2.new(0.1, 0, 0, 140)
ACSpeed.Position = ACSpeedPos
ACSpeed.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ACSpeed.Text = "0.5"
ACSpeed.TextColor3 = Color3.fromRGB(255, 255, 255)
RegisterLang(ACSpeed, "SpeedStr", true)

local ACSpeedCorner = Instance.new("UICorner")
ACSpeedCorner.CornerRadius = UDim.new(0, 6)
ACSpeedCorner.Parent = ACSpeed

ACSpeed.FocusLost:Connect(function()
    local num = tonumber(ACSpeed.Text)
    if num then
        State.AutoClickerSpeed = num
    else
        State.AutoClickerSpeed = 0.5
    end
end)

ACAdd.MouseButton1Click:Connect(function()
    local PointFrame = Instance.new("Frame")
    PointFrame.Parent = ScreenGui
    local PFSize = UDim2.new(0, 40, 0, 40)
    PointFrame.Size = PFSize
    local PFPos = UDim2.new(0.5, 0, 0.5, 0)
    PointFrame.Position = PFPos
    PointFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    PointFrame.BackgroundTransparency = 0.3
    PointFrame.ZIndex = 200
    MakeDraggable(PointFrame)
    
    local PFCorner = Instance.new("UICorner")
    PFCorner.CornerRadius = UDim.new(1, 0)
    PFCorner.Parent = PointFrame
    
    local PointCenter = Instance.new("Frame")
    PointCenter.Parent = PointFrame
    local PCSize = UDim2.new(0, 4, 0, 4)
    PointCenter.Size = PCSize
    local PCPos = UDim2.new(0.5, -2, 0.5, -2)
    PointCenter.Position = PCPos
    PointCenter.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
    local PCCorner = Instance.new("UICorner")
    PCCorner.CornerRadius = UDim.new(1, 0)
    PCCorner.Parent = PointCenter
    
    local Label = Instance.new("TextLabel")
    Label.Parent = PointFrame
    local LblSize = UDim2.new(1,0,1,0)
    Label.Size = LblSize
    Label.BackgroundTransparency = 1
    Label.Text = #ClickPoints + 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextStrokeTransparency = 0.5
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 20
    
    table.insert(ClickPoints, PointFrame)
    UpdateACInfo()
end)

ACRemove.MouseButton1Click:Connect(function()
    if #ClickPoints > 0 then
        local lastPoint = table.remove(ClickPoints)
        lastPoint:Destroy()
        UpdateACInfo()
    end
end)

task.spawn(function()
    while true do
        if State.AutoClickerPlaying and #ClickPoints > 0 then
            for i, point in ipairs(ClickPoints) do
                if point and point.Parent then
                    local absolutePos = point.AbsolutePosition
                    local addVec = Vector2.new(20, 20)
                    local finalPos = absolutePos + addVec
                    
                    VirtualInputManager:SendMouseButtonEvent(finalPos.X, finalPos.Y, 0, true, game, 1)
                    task.wait()
                    VirtualInputManager:SendMouseButtonEvent(finalPos.X, finalPos.Y, 0, false, game, 1)
                end
                task.wait(State.AutoClickerSpeed)
            end
        else
            task.wait(0.2)
        end
    end
end)

CreateToggle(PageTools, "ACMobile", function(val)
    ACMenu.Visible = val
end)

CreateToggle(PageTools, "Invis", function(val)
    State.Invisible = val
    if LocalPlayer.Character then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                if val then
                    v.Transparency = 1
                else
                    v.Transparency = 0
                end
            end
            if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                if val then
                    v.Enabled = false
                else
                    v.Enabled = true
                end
            end
        end
        if LocalPlayer.Character:FindFirstChild("Humanoid") then
            if val then
                LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            else
                LocalPlayer.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
            end
        end
    end
end)

local ColRed = Color3.fromRGB(200, 50, 50)
CreateButton(PageTools, "ResetChar", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end, ColRed)

local ColBlk = Color3.fromRGB(0, 0, 0)
CreateButton(PageTools, "ExecEgor", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xayztech/Script-HackerDeep-Roblox/refs/heads/main/Roblox-egor-ID.lua"))()
    end)
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xayztech/Script-HackerDeep-Roblox/refs/heads/main/Roblox-egor-IDV2.lua"))()
    end)
    ShowNotification(GetString("NotifExec"), "Egor Script")
end, ColBlk)

CreateButton(PageTools, "ExecXayz", function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Xayztech/Script-HackerDeep-Roblox/refs/heads/main/Xayz-EXV2.lua"))()
    end)
    ShowNotification(GetString("NotifExec"), "ESP + AIM")
end, ColBlk)

local Crosshair = Instance.new("Frame")
Crosshair.Name = "RealCrosshair"
Crosshair.Parent = ScreenGui
Crosshair.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
local CRPos = UDim2.new(0.5, 0, 0.5, 0)
Crosshair.Position = CRPos
local CRSize = UDim2.new(0, 4, 0, 4)
Crosshair.Size = CRSize
Crosshair.Visible = false
Crosshair.ZIndex = 300

local CRCorner = Instance.new("UICorner")
CRCorner.CornerRadius = UDim.new(1, 0)
CRCorner.Parent = Crosshair

CreateToggle(PageTools, "UltCross", function(val)
    Crosshair.Visible = val
    State.Crosshair = val
    if val then
        local Adv = CreateAdvancedMenu(ScreenGui, "AdvCrossTitle", function(container)
             
             local SizeInput = Instance.new("TextBox")
             SizeInput.Parent = container
             local SISize = UDim2.new(0.9, 0, 0, 30)
             SizeInput.Size = SISize
             SizeInput.Text = "4"
             SizeInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
             SizeInput.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(SizeInput, "SizeStr", true)
             
             local SICorner = Instance.new("UICorner")
             SICorner.CornerRadius = UDim.new(0,4)
             SICorner.Parent = SizeInput
             
             SizeInput.FocusLost:Connect(function()
                 local s = tonumber(SizeInput.Text)
                 if not s then
                     s = 4
                 end
                 local newSize = UDim2.new(0, s, 0, s)
                 Crosshair.Size = newSize
             end)
             
             local TransInput = Instance.new("TextBox")
             TransInput.Parent = container
             local TISize = UDim2.new(0.9, 0, 0, 30)
             TransInput.Size = TISize
             TransInput.Text = "0"
             TransInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
             TransInput.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(TransInput, "TransStr", true)
             
             local TICorner = Instance.new("UICorner")
             TICorner.CornerRadius = UDim.new(0,4)
             TICorner.Parent = TransInput
             
             TransInput.FocusLost:Connect(function()
                 local t = tonumber(TransInput.Text)
                 if not t then
                     t = 0
                 end
                 Crosshair.BackgroundTransparency = t
                 if Crosshair:FindFirstChild("ImageLabel") then
                    Crosshair.ImageLabel.ImageTransparency = t
                 end
             end)

             local ImageInput = Instance.new("TextBox")
             ImageInput.Parent = container
             local IISize = UDim2.new(0.9, 0, 0, 30)
             ImageInput.Size = IISize
             ImageInput.Text = ""
             ImageInput.BackgroundColor3 = Color3.fromRGB(40,40,40)
             ImageInput.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(ImageInput, "ImgStr", true)
             
             local IICorner = Instance.new("UICorner")
             IICorner.CornerRadius = UDim.new(0,4)
             IICorner.Parent = ImageInput
             
             ImageInput.FocusLost:Connect(function()
                 local id = ImageInput.Text
                 if id ~= "" then
                     if not Crosshair:FindFirstChild("ImageLabel") then
                         local Img = Instance.new("ImageLabel", Crosshair)
                         local ImgSize = UDim2.new(1,0,1,0)
                         Img.Size = ImgSize
                         Img.BackgroundTransparency = 1
                     end
                     local strMatch = id:match("%d+")
                     local finalID = "rbxassetid://" .. strMatch
                     Crosshair.ImageLabel.Image = finalID
                     Crosshair.BackgroundTransparency = 1
                 else
                     if Crosshair:FindFirstChild("ImageLabel") then
                         Crosshair.ImageLabel:Destroy()
                     end
                     Crosshair.BackgroundTransparency = 0
                 end
             end)

             local SpinBtn = Instance.new("TextButton")
             SpinBtn.Parent = container
             local SBSize = UDim2.new(0.9, 0, 0, 30)
             SpinBtn.Size = SBSize
             SpinBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
             SpinBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(SpinBtn, "TglSpin", false)
             
             local SBCorner = Instance.new("UICorner")
             SBCorner.CornerRadius = UDim.new(0,4)
             SBCorner.Parent = SpinBtn
             
             SpinBtn.MouseButton1Click:Connect(function()
                 State.CrosshairSpin = not State.CrosshairSpin
             end)
             
             local RainbowBtn = Instance.new("TextButton")
             RainbowBtn.Parent = container
             local RBSize = UDim2.new(0.9, 0, 0, 30)
             RainbowBtn.Size = RBSize
             RainbowBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
             RainbowBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(RainbowBtn, "TglRain", false)
             
             local RBCorner = Instance.new("UICorner")
             RBCorner.CornerRadius = UDim.new(0,4)
             RBCorner.Parent = RainbowBtn
             
             RainbowBtn.MouseButton1Click:Connect(function()
                 State.CrosshairRainbow = not State.CrosshairRainbow
             end)

             local ShapeBtn = Instance.new("TextButton")
             ShapeBtn.Parent = container
             local ShBSize = UDim2.new(0.9, 0, 0, 30)
             ShapeBtn.Size = ShBSize
             ShapeBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
             ShapeBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(ShapeBtn, "TglShape", false)
             
             local ShBCorner = Instance.new("UICorner")
             ShBCorner.CornerRadius = UDim.new(0,4)
             ShBCorner.Parent = ShapeBtn
             
             ShapeBtn.MouseButton1Click:Connect(function()
                 if Crosshair:FindFirstChild("UICorner") then
                     Crosshair.UICorner:Destroy()
                 else
                     local TmpC = Instance.new("UICorner", Crosshair)
                     TmpC.CornerRadius = UDim.new(1, 0)
                 end
             end)
             
             local RedBtn = Instance.new("TextButton")
             RedBtn.Parent = container
             local RBtnSize = UDim2.new(0.9, 0, 0, 30)
             RedBtn.Size = RBtnSize
             RedBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
             RegisterLang(RedBtn, "RedStr", false)
             
             local RBtnCorner = Instance.new("UICorner")
             RBtnCorner.CornerRadius = UDim.new(0,4)
             RBtnCorner.Parent = RedBtn
             
             RedBtn.MouseButton1Click:Connect(function()
                 Crosshair.BackgroundColor3 = Color3.fromRGB(255,0,0)
             end)
             
             local CyanBtn = Instance.new("TextButton")
             CyanBtn.Parent = container
             local CBtnSize = UDim2.new(0.9, 0, 0, 30)
             CyanBtn.Size = CBtnSize
             CyanBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
             RegisterLang(CyanBtn, "CyanStr", false)
             
             local CBtnCorner = Instance.new("UICorner")
             CBtnCorner.CornerRadius = UDim.new(0,4)
             CBtnCorner.Parent = CyanBtn
             
             CyanBtn.MouseButton1Click:Connect(function()
                 Crosshair.BackgroundColor3 = Color3.fromRGB(0,255,255)
             end)

        end)
        Adv.Visible = true
    end
end)

local function BoostFPS(mode)
    if mode == "Plastic" then
        for _, v in pairs(Workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            end
            if v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
    elseif mode == "6BIT" then
        Lighting.Technology = Enum.Technology.Legacy
        Lighting.Brightness = 0.5
        for _, v in pairs(Workspace:GetDescendants()) do
             if v:IsA("BasePart") then
                 v.Material = Enum.Material.SmoothPlastic
             end
        end
    end
end

CreateToggle(PageVisual, "Booster", function(val)
    if val then
        local Adv = CreateAdvancedMenu(ScreenGui, "AdvBoostTitle", function(container)
             local PlasticBtn = Instance.new("TextButton")
             PlasticBtn.Parent = container
             local PlBtnSize = UDim2.new(0.9, 0, 0, 30)
             PlasticBtn.Size = PlBtnSize
             PlasticBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
             PlasticBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(PlasticBtn, "PlasMode", false)
             
             local PlBtnCorner = Instance.new("UICorner")
             PlBtnCorner.CornerRadius = UDim.new(0,4)
             PlBtnCorner.Parent = PlasticBtn
             
             PlasticBtn.MouseButton1Click:Connect(function()
                 BoostFPS("Plastic")
             end)
             
             local BitBtn = Instance.new("TextButton")
             BitBtn.Parent = container
             local BiBtnSize = UDim2.new(0.9, 0, 0, 30)
             BitBtn.Size = BiBtnSize
             BitBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
             BitBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(BitBtn, "BitMode", false)
             
             local BiBtnCorner = Instance.new("UICorner")
             BiBtnCorner.CornerRadius = UDim.new(0,4)
             BiBtnCorner.Parent = BitBtn
             
             BitBtn.MouseButton1Click:Connect(function()
                 BoostFPS("6BIT")
             end)
             
             local NoPartBtn = Instance.new("TextButton")
             NoPartBtn.Parent = container
             local NpBtnSize = UDim2.new(0.9, 0, 0, 30)
             NoPartBtn.Size = NpBtnSize
             NoPartBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
             NoPartBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(NoPartBtn, "NoPart", false)
             
             local NpBtnCorner = Instance.new("UICorner")
             NpBtnCorner.CornerRadius = UDim.new(0,4)
             NpBtnCorner.Parent = NoPartBtn
             
             NoPartBtn.MouseButton1Click:Connect(function()
                 for _, v in pairs(Workspace:GetDescendants()) do
                     if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                         v:Destroy()
                     end
                 end
             end)
        end)
        Adv.Visible = true
    end
end)

CreateToggle(PageVisual, "Roshade", function(val)
    if val then
        local Bloom = Instance.new("BloomEffect", Lighting)
        Bloom.Name = "XayzBloom"
        Bloom.Intensity = 1
        Bloom.Size = 24
        Bloom.Threshold = 2
        
        local CC = Instance.new("ColorCorrectionEffect", Lighting)
        CC.Name = "XayzCC"
        CC.Saturation = 0.2
        CC.Contrast = 0.3
        CC.Brightness = 0.05
        
        local Sun = Instance.new("SunRaysEffect", Lighting)
        Sun.Name = "XayzSun"
        Sun.Intensity = 0.25
        Sun.Spread = 1
        
        local Blur = Instance.new("BlurEffect", Lighting)
        Blur.Name = "XayzBlur"
        Blur.Size = 2
        
        local DOF = Instance.new("DepthOfFieldEffect", Lighting)
        DOF.Name = "XayzDOF"
        DOF.FarIntensity = 0.1
        DOF.FocusDistance = 0.05
        DOF.InFocusRadius = 30
        DOF.NearIntensity = 0.1
        
        local Atmo = Instance.new("Atmosphere", Lighting)
        Atmo.Name = "XayzAtmo"
        Atmo.Density = 0.3
        Atmo.Offset = 0.25
        
        local Adv = CreateAdvancedMenu(ScreenGui, "AdvShadeTitle", function(container)
             
             local ToggleShadow = Instance.new("TextButton")
             ToggleShadow.Parent = container
             local TsSize = UDim2.new(0.9, 0, 0, 30)
             ToggleShadow.Size = TsSize
             ToggleShadow.BackgroundColor3 = Color3.fromRGB(40,40,40)
             ToggleShadow.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(ToggleShadow, "TglShade", false)
             
             local TsCorner = Instance.new("UICorner")
             TsCorner.CornerRadius = UDim.new(0,4)
             TsCorner.Parent = ToggleShadow
             
             ToggleShadow.MouseButton1Click:Connect(function()
                 Lighting.GlobalShadows = not Lighting.GlobalShadows
             end)
             
             local ToggleBlur = Instance.new("TextButton")
             ToggleBlur.Parent = container
             local TbSize = UDim2.new(0.9, 0, 0, 30)
             ToggleBlur.Size = TbSize
             ToggleBlur.BackgroundColor3 = Color3.fromRGB(40,40,40)
             ToggleBlur.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(ToggleBlur, "TglBlur", false)
             
             local TbCorner = Instance.new("UICorner")
             TbCorner.CornerRadius = UDim.new(0,4)
             TbCorner.Parent = ToggleBlur
             
             ToggleBlur.MouseButton1Click:Connect(function()
                 Blur.Enabled = not Blur.Enabled
             end)
             
             local HighConBtn = Instance.new("TextButton")
             HighConBtn.Parent = container
             local HcSize = UDim2.new(0.9, 0, 0, 30)
             HighConBtn.Size = HcSize
             HighConBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
             HighConBtn.TextColor3 = Color3.fromRGB(255,255,255)
             RegisterLang(HighConBtn, "HighCon", false)
             
             local HcCorner = Instance.new("UICorner")
             HcCorner.CornerRadius = UDim.new(0,4)
             HcCorner.Parent = HighConBtn
             
             HighConBtn.MouseButton1Click:Connect(function()
                 CC.Contrast = 0.5
                 CC.Saturation = 0.4
             end)
        end)
        Adv.Visible = true
    else
        for _, v in pairs(Lighting:GetChildren()) do
            local strName = v.Name
            local subName = strName:sub(1,4)
            if subName == "Xayz" then
                v:Destroy()
            end
        end
    end
end)

CreateToggle(PageVisual, "FullBright", function(val)
    State.FullBright = val
    if val then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        local grayCol = Color3.fromRGB(128, 128, 128)
        Lighting.OutdoorAmbient = grayCol
    else
        Lighting.Brightness = DefaultLighting.Brightness
        Lighting.ClockTime = DefaultLighting.ClockTime
        Lighting.FogEnd = DefaultLighting.FogEnd
        Lighting.GlobalShadows = DefaultLighting.GlobalShadows
        Lighting.OutdoorAmbient = DefaultLighting.OutdoorAmbient
    end
end)

CreateToggle(PageVisual, "CapFPS", function(val)
    if setfpscap then
        if val then
            setfpscap(120)
        else
            setfpscap(60)
        end
    end
end)

local TpTarget = ""
CreateInput(PageWorld, "TPName", function(txt)
    TpTarget = txt
end)

local ColBlue = Color3.fromRGB(0, 150, 255)
CreateButton(PageWorld, "TPBtn", function()
    local target = nil
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local strLowerName = string.lower(p.Name)
            local strLowerDis = string.lower(p.DisplayName)
            local strTarget = string.lower(TpTarget)
            
            local matchName = string.find(strLowerName, strTarget)
            local matchDis = string.find(strLowerDis, strTarget)
            
            if matchName or matchDis then
                target = p
                break
            end
        end
    end
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
        local TargetCFrame = target.Character.HumanoidRootPart.CFrame
        local OffsetCFrame = Vector3.new(0, 3, 0)
        LocalPlayer.Character.HumanoidRootPart.CFrame = TargetCFrame + OffsetCFrame
        ShowNotification(GetString("NotifSucc"), target.DisplayName)
    else
        ShowNotification(GetString("NotifErr"), GetString("CloneFail"))
    end
end, ColBlue)

local ExecTabsContainer = Instance.new("ScrollingFrame")
ExecTabsContainer.Parent = PageExecutor
local ETCSize = UDim2.new(1, 0, 0, 35)
ExecTabsContainer.Size = ETCSize
ExecTabsContainer.BackgroundTransparency = 1
ExecTabsContainer.ScrollBarThickness = 2
local ETCCanvas = UDim2.new(0, 0, 0, 0)
ExecTabsContainer.CanvasSize = ETCCanvas
ExecTabsContainer.AutomaticCanvasSize = Enum.AutomaticSize.X

local ExecList = Instance.new("UIListLayout")
ExecList.Parent = ExecTabsContainer
ExecList.FillDirection = Enum.FillDirection.Horizontal
ExecList.Padding = UDim.new(0, 5)

local CodeBox = Instance.new("TextBox")
CodeBox.Parent = PageExecutor
local CBPos = UDim2.new(0, 0, 0, 45)
CodeBox.Position = CBPos
local CBSize = UDim2.new(1, -5, 0, 160)
CodeBox.Size = CBSize
CodeBox.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
CodeBox.TextColor3 = Color3.fromRGB(0, 255, 100)
CodeBox.Font = Enum.Font.Code
CodeBox.TextSize = 12
CodeBox.TextXAlignment = Enum.TextXAlignment.Left
CodeBox.TextYAlignment = Enum.TextYAlignment.Top
CodeBox.Text = "print('Xayz Mobile V5')"
CodeBox.ClearTextOnFocus = false
CodeBox.MultiLine = true

local BoxCorner = Instance.new("UICorner")
BoxCorner.Parent = CodeBox

local ScriptStorage = {
    ["Tab 1"] = "print('Xayz Mobile V5')"
}
local CurrentScriptTab = "Tab 1"

local function RefreshTabs()
    for _, v in pairs(ExecTabsContainer:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
    
    for name, _ in pairs(ScriptStorage) do
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = ExecTabsContainer
        local TBSize = UDim2.new(0, 80, 1, 0)
        TabBtn.Size = TBSize
        
        if name == CurrentScriptTab then
            TabBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        else
            TabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
        
        TabBtn.Text = name
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        
        local TC = Instance.new("UICorner")
        TC.Parent = TabBtn
        
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Parent = TabBtn
        CloseBtn.BackgroundTransparency = 1
        local ClsPos = UDim2.new(1, -20, 0, 0)
        CloseBtn.Position = ClsPos
        local ClsSize = UDim2.new(0, 20, 1, 0)
        CloseBtn.Size = ClsSize
        CloseBtn.Text = "X"
        CloseBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        TabBtn.MouseButton1Click:Connect(function()
            ScriptStorage[CurrentScriptTab] = CodeBox.Text
            CurrentScriptTab = name
            local newText = ScriptStorage[name]
            if not newText then
                newText = ""
            end
            CodeBox.Text = newText
            RefreshTabs()
        end)
        
        CloseBtn.MouseButton1Click:Connect(function()
            local count = 0
            for _ in pairs(ScriptStorage) do
                count = count + 1
            end
            
            if count > 1 then 
                 ScriptStorage[name] = nil
                 local nextKey, nextVal = next(ScriptStorage)
                 if nextKey then
                     CurrentScriptTab = nextKey
                     CodeBox.Text = nextVal
                 end
                 RefreshTabs()
            end
        end)
    end
    
    local AddTabBtn = Instance.new("TextButton")
    AddTabBtn.Parent = ExecTabsContainer
    local AddTSize = UDim2.new(0, 30, 1, 0)
    AddTabBtn.Size = AddTSize
    AddTabBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    AddTabBtn.Text = "+"
    AddTabBtn.LayoutOrder = 999
    
    local ATC = Instance.new("UICorner")
    ATC.Parent = AddTabBtn
    
    AddTabBtn.MouseButton1Click:Connect(function()
        local count = 0
        for _ in pairs(ScriptStorage) do
            count = count + 1
        end
        local newName = "Tab " .. (count + 1)
        ScriptStorage[newName] = ""
        CurrentScriptTab = newName
        CodeBox.Text = ""
        RefreshTabs()
    end)
end

RefreshTabs()

local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Parent = PageExecutor
local ExeBPos = UDim2.new(0, 0, 1, -40)
ExecuteBtn.Position = ExeBPos
local ExeBSize = UDim2.new(0.3, 0, 0, 35)
ExecuteBtn.Size = ExeBSize
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RegisterLang(ExecuteBtn, "ExecCode", false)

local ExeBCorner = Instance.new("UICorner")
ExeBCorner.CornerRadius = UDim.new(0, 6)
ExeBCorner.Parent = ExecuteBtn

ExecuteBtn.MouseButton1Click:Connect(function()
    local code = CodeBox.Text
    local success, err = pcall(function()
        local loadFunc = loadstring
        if not loadFunc then
            local getGen = getgenv
            if getGen then
                loadFunc = getGen().loadstring
            end
        end
        
        if loadFunc then
            local func = loadFunc(code)
            if func then
                task.spawn(func)
            else
                error("Compile Error")
            end
        else
            error("Executor Not Supported")
        end
    end)
    
    if success then
        ShowNotification(GetString("TabExec"), GetString("NotifExec"))
    else
        ShowNotification(GetString("NotifErr"), "Check Console")
    end
end)

local ClearBtn = Instance.new("TextButton")
ClearBtn.Parent = PageExecutor
local ClrBPos = UDim2.new(0.35, 0, 1, -40)
ClearBtn.Position = ClrBPos
local ClrBSize = UDim2.new(0.3, 0, 0, 35)
ClearBtn.Size = ClrBSize
ClearBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ClearBtn.Font = Enum.Font.GothamBold
ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RegisterLang(ClearBtn, "ClearCode", false)

local ClrBCorner = Instance.new("UICorner")
ClrBCorner.CornerRadius = UDim.new(0, 6)
ClrBCorner.Parent = ClearBtn

ClearBtn.MouseButton1Click:Connect(function()
    CodeBox.Text = ""
end)

local UploadBtn = Instance.new("TextButton")
UploadBtn.Parent = PageExecutor
local UplBPos = UDim2.new(0.7, 0, 1, -40)
UploadBtn.Position = UplBPos
local UplBSize = UDim2.new(0.3, 0, 0, 35)
UploadBtn.Size = UplBSize
UploadBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)
UploadBtn.Font = Enum.Font.GothamBold
UploadBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RegisterLang(UploadBtn, "CopyCode", false)

local UplBCorner = Instance.new("UICorner")
UplBCorner.CornerRadius = UDim.new(0, 6)
UplBCorner.Parent = UploadBtn

UploadBtn.MouseButton1Click:Connect(function() 
    if setclipboard then
        setclipboard(CodeBox.Text)
    end
    ShowNotification(GetString("TabExec"), GetString("NotifSucc"))
end)


local cloneTarget = ""
local emoteIDTarget = ""

local CloneTextBox = CreateInput(PageUltimate, "CloneHolder", function(txt)
    cloneTarget = txt
end)

local ColBlueUlt = Color3.fromRGB(0, 150, 255)

CreateButton(PageUltimate, "CloneBtn", function()
    local currentTarget = cloneTarget 
    
    if currentTarget == "" then
        ShowNotification(GetString("NotifErr"), GetString("CloneFail"))
        return
    end
    
    ShowNotification("Searching...", "Searching for data " .. currentTarget)
    
    task.spawn(function()
        local success, userId = pcall(function()
            local tonum = tonumber(currentTarget)
            if tonum then
                return tonum 
            else
                return Players:GetUserIdFromNameAsync(currentTarget) 
            end
        end)
        
        if success and userId then
            local char = LocalPlayer.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    local desc = Players:GetHumanoidDescriptionFromUserId(userId)
                    
                    if desc then
                        humanoid:ApplyDescription(desc)
                        ShowNotification(GetString("NotifSucc"), GetString("CloneSucc"))
                    else
                        ShowNotification(GetString("NotifErr"), "Gagal memuat avatar")
                    end
                end
            end
        else
            ShowNotification(GetString("NotifErr"), GetString("CloneFail"))
        end
    end)
end, ColBlueUlt)

local ColPurp = Color3.fromRGB(150, 50, 255)
CreateButton(PageUltimate, "HeadlessBtn", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Head") then
        local head = char.Head
        head.Transparency = 1
        
        local face = head:FindFirstChild("face")
        if face then
            face:Destroy()
        end
        
        local spMesh = head:FindFirstChildOfClass("SpecialMesh")
        if spMesh then
            spMesh:Destroy()
        end
        
        ShowNotification(GetString("NotifSucc"), GetString("HeadSucc"))
    end
end, ColPurp)

CreateToggle(PageUltimate, "AntiFlingBtn", function(val)
    State.AntiFling = val
end)

local ColOrng = Color3.fromRGB(255, 150, 0)
CreateButton(PageUltimate, "NDSBtn", function()
    ShowNotification(GetString("DisasterT"), GetString("DisasterD"))
end, ColOrng)

CreateInput(PageUltimate, "EmoteHolder", function(txt)
    emoteIDTarget = txt
end)

local currentAnimTrack = nil
local ColGrn = Color3.fromRGB(0, 200, 100)
CreateButton(PageUltimate, "EmoteBtn", function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("Humanoid") or emoteIDTarget == "" then
        ShowNotification(GetString("NotifErr"), GetString("AnimFail"))
        return
    end
    
    local numericId = string.match(emoteIDTarget, "%d+")
    if not numericId then
        ShowNotification(GetString("NotifErr"), GetString("AnimFail"))
        return
    end
    
    local anim = Instance.new("Animation")
    local FullID = "rbxassetid://" .. numericId
    anim.AnimationId = FullID
    local humanoid = char:FindFirstChild("Humanoid")
    
    if currentAnimTrack then
        currentAnimTrack:Stop()
    end
    
    local success, err = pcall(function()
        local animator = humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            animator = Instance.new("Animator", humanoid)
        end
        currentAnimTrack = animator:LoadAnimation(anim)
        currentAnimTrack:Play()
    end)
    
    if not success then
        ShowNotification(GetString("NotifErr"), GetString("AnimFail"))
    end
end, ColGrn)

local dinoAnim = Instance.new("Animation")
local punchAnim = Instance.new("Animation")
punchAnim.AnimationId = "rbxassetid://84674780"
local dinoTrack = nil
local punchTrack = nil

CreateToggle(PageUltimate, "TglDino", function(val)
    State.DinoAnim = val
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if val and hum then
        if hum.RigType == Enum.HumanoidRigType.R15 then
            dinoAnim.AnimationId = "rbxassetid://204062532"
        else
            dinoAnim.AnimationId = "rbxassetid://20432871"
        end
        dinoTrack = hum:LoadAnimation(dinoAnim)
        dinoTrack:Play()
    else
        if dinoTrack then dinoTrack:Stop() end
    end
end)

CreateToggle(PageUltimate, "TglPunch", function(val)
    State.PunchAnim = val
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if val and hum then
        punchTrack = hum:LoadAnimation(punchAnim)
        punchTrack:Play()
    else
        if punchTrack then punchTrack:Stop() end
    end
end)

CreateToggle(PageUltimate, "TglSuperFling", function(val)
    State.SuperFling = val
end)

CreateToggle(PageUltimate, "TglFlingV2", function(val)
    State.FlingV2 = val
end)

CreateInput(PageUltimate, "SetFlingPower", function(txt)
    local num = tonumber(txt)
    if num then
        State.FlingPower = num
    else
        State.FlingPower = 50
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

local function CreateStatLabel(posY, color)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 25)
    lbl.Position = UDim2.new(0, 10, 0, posY)
    lbl.BackgroundTransparency = 1
    lbl.Text = "..."
    lbl.TextColor3 = color
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = StatsHUD
    return lbl
end

local FPSText = CreateStatLabel(5, Color3.fromRGB(0, 255, 100))
local PingText = CreateStatLabel(32, Color3.fromRGB(255, 200, 0))
local CPSText = CreateStatLabel(59, Color3.fromRGB(0, 200, 255))

CreateToggle(PageUltimate, "StatsBtn", function(val)
    State.StatsHUD = val
    StatsHUD.Visible = val
end)

local StatClicks = {

}

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
        local t = tick()
        table.insert(StatClicks, t)
    end
end)

local AudioPlayer = Instance.new("Sound")
AudioPlayer.Parent = CoreGui

local PlayerContainer = Instance.new("Frame")
PlayerContainer.Parent = PageMusic
local PCSize = UDim2.new(1, -5, 0, 140)
PlayerContainer.Size = PCSize
PlayerContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

local PCCorner = Instance.new("UICorner")
PCCorner.CornerRadius = UDim.new(0, 8)
PCCorner.Parent = PlayerContainer

local AlbumArt = Instance.new("ImageLabel")
AlbumArt.Parent = PlayerContainer
local ArtSize = UDim2.new(0, 80, 0, 80)
AlbumArt.Size = ArtSize
local ArtPos = UDim2.new(0, 10, 0, 10)
AlbumArt.Position = ArtPos
AlbumArt.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
AlbumArt.Image = "rbxassetid://6031097225"

local ArtCorner = Instance.new("UICorner")
ArtCorner.CornerRadius = UDim.new(0, 8)
ArtCorner.Parent = AlbumArt

local NowPlayingTitle = Instance.new("TextLabel")
NowPlayingTitle.Parent = PlayerContainer
local NPSize = UDim2.new(1, -110, 0, 30)
NowPlayingTitle.Size = NPSize
local NPPos = UDim2.new(0, 100, 0, 15)
NowPlayingTitle.Position = NPPos
NowPlayingTitle.BackgroundTransparency = 1
NowPlayingTitle.TextColor3 = Color3.fromRGB(0, 255, 200)
NowPlayingTitle.Font = Enum.Font.GothamBold
NowPlayingTitle.TextSize = 12
NowPlayingTitle.TextXAlignment = Enum.TextXAlignment.Left
NowPlayingTitle.TextWrapped = true
RegisterLang(NowPlayingTitle, "NowPlaying", false)

local ProgressBg = Instance.new("Frame")
ProgressBg.Parent = PlayerContainer
local PBgSize = UDim2.new(1, -110, 0, 4)
ProgressBg.Size = PBgSize
local PBgPos = UDim2.new(0, 100, 0, 60)
ProgressBg.Position = PBgPos
ProgressBg.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
ProgressBg.BorderSizePixel = 0

local ProgressFill = Instance.new("Frame")
ProgressFill.Parent = ProgressBg
local PFillSize = UDim2.new(0, 0, 1, 0)
ProgressFill.Size = PFillSize
ProgressFill.BackgroundColor3 = Color3.fromRGB(30, 215, 96) -- Hijau Spotify
ProgressFill.BorderSizePixel = 0

local ProgressBall = Instance.new("Frame")
ProgressBall.Parent = ProgressFill
local PBallSize = UDim2.new(0, 10, 0, 10)
ProgressBall.Size = PBallSize
local PBallPos = UDim2.new(1, -5, 0.5, -5)
ProgressBall.Position = PBallPos
ProgressBall.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

local PBallCorner = Instance.new("UICorner")
PBallCorner.CornerRadius = UDim.new(1, 0)
PBallCorner.Parent = ProgressBall

local ControlsFrame = Instance.new("Frame")
ControlsFrame.Parent = PlayerContainer
local CFSize = UDim2.new(1, -110, 0, 30)
ControlsFrame.Size = CFSize
local CFPos = UDim2.new(0, 100, 0, 80)
ControlsFrame.Position = CFPos
ControlsFrame.BackgroundTransparency = 1

local CFLayout = Instance.new("UIListLayout")
CFLayout.Parent = ControlsFrame
CFLayout.FillDirection = Enum.FillDirection.Horizontal
CFLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
CFLayout.Padding = UDim.new(0, 5)

local PrevBtn = Instance.new("TextButton")
PrevBtn.Parent = ControlsFrame
local PrevBSize = UDim2.new(0, 30, 0, 30)
PrevBtn.Size = PrevBSize
PrevBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
PrevBtn.Font = Enum.Font.GothamBold
PrevBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
PrevBtn.Text = "⏮"

local PrevBCorner = Instance.new("UICorner")
PrevBCorner.CornerRadius = UDim.new(0, 6)
PrevBCorner.Parent = PrevBtn

local PlayPauseBtn = Instance.new("TextButton")
PlayPauseBtn.Parent = ControlsFrame
local PlPaBSize = UDim2.new(0, 50, 0, 30)
PlayPauseBtn.Size = PlPaBSize
PlayPauseBtn.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
PlayPauseBtn.Font = Enum.Font.GothamBold
PlayPauseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
PlayPauseBtn.Text = "||"

local PlPaBCorner = Instance.new("UICorner")
PlPaBCorner.CornerRadius = UDim.new(0, 6)
PlPaBCorner.Parent = PlayPauseBtn

local NextBtn = Instance.new("TextButton")
NextBtn.Parent = ControlsFrame
local NextBSize = UDim2.new(0, 30, 0, 30)
NextBtn.Size = NextBSize
NextBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
NextBtn.Font = Enum.Font.GothamBold
NextBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NextBtn.Text = "⏭"

local NextBCorner = Instance.new("UICorner")
NextBCorner.CornerRadius = UDim.new(0, 6)
NextBCorner.Parent = NextBtn

local StopMusicBtn = Instance.new("TextButton")
StopMusicBtn.Parent = ControlsFrame
local StopBSize = UDim2.new(0, 30, 0, 30)
StopMusicBtn.Size = StopBSize
StopMusicBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
StopMusicBtn.Font = Enum.Font.GothamBold
StopMusicBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopMusicBtn.Text = "■"

local StopBCorner = Instance.new("UICorner")
StopBCorner.CornerRadius = UDim.new(0, 6)
StopBCorner.Parent = StopMusicBtn

local RepeatBtn = Instance.new("TextButton")
RepeatBtn.Parent = ControlsFrame
local RepBSize = UDim2.new(0, 30, 0, 30)
RepeatBtn.Size = RepBSize
RepeatBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
RepeatBtn.Font = Enum.Font.GothamBold
RepeatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RepeatBtn.Text = "↻"

local RepBCorner = Instance.new("UICorner")
RepBCorner.CornerRadius = UDim.new(0, 6)
RepBCorner.Parent = RepeatBtn

local SearchContainer = Instance.new("Frame")
SearchContainer.Parent = PageMusic
SearchContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
local SCS = UDim2.new(1, -5, 0, 35)
SearchContainer.Size = SCS

local SCC = Instance.new("UICorner")
SCC.CornerRadius = UDim.new(0, 6)
SCC.Parent = SearchContainer

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Parent = SearchContainer
SearchIcon.BackgroundTransparency = 1
local SIPos = UDim2.new(0, 10, 0, 0)
SearchIcon.Position = SIPos
local SISize = UDim2.new(0, 20, 1, 0)
SearchIcon.Size = SISize
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Color3.fromRGB(200, 200, 200)
SearchIcon.TextSize = 14

local MusicSearchBox = Instance.new("TextBox")
MusicSearchBox.Parent = SearchContainer
MusicSearchBox.BackgroundTransparency = 1
local MSBPos = UDim2.new(0, 35, 0, 0)
MusicSearchBox.Position = MSBPos
local MSBSize = UDim2.new(1, -40, 1, 0)
MusicSearchBox.Size = MSBSize
MusicSearchBox.Font = Enum.Font.Gotham
MusicSearchBox.Text = ""
MusicSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MusicSearchBox.TextSize = 12
MusicSearchBox.TextXAlignment = Enum.TextXAlignment.Left
RegisterLang(MusicSearchBox, "SearchMusic", true)

local MusicListScroll = Instance.new("ScrollingFrame")
MusicListScroll.Parent = PageMusic
local MLSize = UDim2.new(1, -5, 0, 180)
MusicListScroll.Size = MLSize
MusicListScroll.BackgroundTransparency = 1
MusicListScroll.ScrollBarThickness = 2
local MLCanv = UDim2.new(0, 0, 0, 0)
MusicListScroll.CanvasSize = MLCanv

local MusicListLayout = Instance.new("UIListLayout")
MusicListLayout.Parent = MusicListScroll
MusicListLayout.Padding = UDim.new(0, 5)

local CurrentSongIndex = 1
local isRepeat = false

local function PlayIndex(index)
    local totalAudio = #AudioLibrary
    if totalAudio == 0 then
        return
    end
    
    if index > totalAudio then
        index = 1
    elseif index < 1 then
        index = totalAudio
    end
    
    CurrentSongIndex = index
    local song = AudioLibrary[index]
    local combinedID = "rbxassetid://" .. song.ID
    AudioPlayer.SoundId = combinedID
    AudioPlayer:Play()
    
    local combineTitle = song.Name
    NowPlayingTitle.Text = combineTitle
    
    PlayPauseBtn.Text = "||"
end

local function LoadMusicList(filter)
    for _, child in pairs(MusicListScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local count = 0
    for index, song in pairs(AudioLibrary) do
        local strLowerS = string.lower(song.Name)
        local strLowerF = string.lower(filter)
        local isMatch = string.find(strLowerS, strLowerF)
        
        if filter == "" or isMatch then
            local btn = Instance.new("TextButton")
            local btnSSize = UDim2.new(1, 0, 0, 30)
            btn.Size = btnSSize
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            
            local combinedName = "  ♪ " .. song.Name
            btn.Text = combinedName
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Parent = MusicListScroll
            
            local btnC = Instance.new("UICorner")
            btnC.CornerRadius = UDim.new(0, 4)
            btnC.Parent = btn
            
            btn.MouseButton1Click:Connect(function()
                PlayIndex(index)
            end)
            count = count + 1
        end
    end
    local calcY = count * 35
    local newCanvas = UDim2.new(0, 0, 0, calcY)
    MusicListScroll.CanvasSize = newCanvas
end

LoadMusicList("")

MusicSearchBox.Changed:Connect(function(prop)
    if prop == "Text" then
        local bxTxt = MusicSearchBox.Text
        LoadMusicList(bxTxt)
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

StopMusicBtn.MouseButton1Click:Connect(function()
    AudioPlayer:Stop()
    PlayPauseBtn.Text = "▶︎"
end)

NextBtn.MouseButton1Click:Connect(function()
    local calcNx = CurrentSongIndex + 1
    PlayIndex(calcNx)
end)

PrevBtn.MouseButton1Click:Connect(function()
    local calcPv = CurrentSongIndex - 1
    PlayIndex(calcPv)
end)

RepeatBtn.MouseButton1Click:Connect(function()
    isRepeat = not isRepeat
    AudioPlayer.Looped = isRepeat
    
    if isRepeat then
        RepeatBtn.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
    else
        RepeatBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end
end)

AudioPlayer.Ended:Connect(function()
    if not isRepeat then
        local calcNx = CurrentSongIndex + 1
        PlayIndex(calcNx)
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    if AudioPlayer.IsLoaded and AudioPlayer.TimeLength > 0 then
        local progress = AudioPlayer.TimePosition / AudioPlayer.TimeLength
        local newSize = UDim2.new(progress, 0, 1, 0)
        ProgressFill.Size = newSize
    else
        local zeroSize = UDim2.new(0, 0, 1, 0)
        ProgressFill.Size = zeroSize
    end

    if State.Tornado and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = LocalPlayer.Character.HumanoidRootPart
        for _, part in pairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored and part.Parent ~= LocalPlayer.Character then
                local dist = (part.Position - HRP.Position).Magnitude
                if dist < 50 then
                     part.CanCollide = false
                     local ang = CFrame.Angles(0, tick() * 10, 0)
                     local offst = CFrame.new(0, 0, 15)
                     part.CFrame = HRP.CFrame * ang * offst
                     
                     local pVelZero = Vector3.new(0, 0, 0)
                     part.Velocity = pVelZero
                     
                     local pRotVel = Vector3.new(0, 100, 0)
                     part.RotVelocity = pRotVel
                end
            end
        end
    end
    
    if State.Freeze and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Anchored = true
    elseif not State.Freeze and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end
    
    if State.Crosshair and State.CrosshairSpin then
        State.CrosshairRotation = State.CrosshairRotation + 2
        local CrosshairFrame = ScreenGui:FindFirstChild("RealCrosshair")
        if CrosshairFrame then
            CrosshairFrame.Rotation = State.CrosshairRotation
        end
    end
    
    if State.Crosshair and State.CrosshairRainbow then
        local clcTick = tick() % 5
        local hue = clcTick / 5
        local color = Color3.fromHSV(hue, 1, 1)
        local CrosshairFrame = ScreenGui:FindFirstChild("RealCrosshair")
        if CrosshairFrame then
            CrosshairFrame.BackgroundColor3 = color
            CrosshairFrame.BorderColor3 = color
            if CrosshairFrame:FindFirstChild("ImageLabel") then
                CrosshairFrame.ImageLabel.ImageColor3 = color
            end
        end
    end
    
    if State.StatsHUD then
        local calcFPS = math.floor(1 / deltaTime)
        local strFPS = "FPS: " .. tostring(calcFPS)
        FPSText.Text = strFPS
        
        local ping = 0
        pcall(function()
            local sitem = Stats.Network.ServerStatsItem["Data Ping"]
            local sval = sitem:GetValue()
            ping = math.floor(sval)
        end)
        local strPing = "PING: " .. tostring(ping) .. " ms"
        PingText.Text = strPing
        
        local currentTick = tick()
        for i = #StatClicks, 1, -1 do
            local diff = currentTick - StatClicks[i]
            if diff > 1 then
                table.remove(StatClicks, i)
            end
        end
        local strCPS = "CPS: " .. tostring(#StatClicks)
        CPSText.Text = strCPS
    end
end)

RunService.Heartbeat:Connect(function()
    if State.GodMode and LocalPlayer.Character then
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then
            if Hum.Health < Hum.MaxHealth then
                Hum.Health = Hum.MaxHealth
            end
            Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        end
    end
end)

RunService.Stepped:Connect(function()
    if State.AntiFling and LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end

        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        part.Velocity = Vector3.new(0, 0, 0)
                        part.RotVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end

        local overlapParams = OverlapParams.new()
        overlapParams.FilterDescendantsInstances = {LocalPlayer.Character}
        overlapParams.FilterType = Enum.RaycastFilterType.Exclude

        local nearbyParts = Workspace:GetPartBoundsInRadius(rootPart.Position, 15, overlapParams)
        
        for _, part in pairs(nearbyParts) do
            if part:IsA("BasePart") and not part.Anchored then
                if part.Velocity.Magnitude > 50 or part.RotVelocity.Magnitude > 50 then
                    part.CanCollide = false
                    part.Velocity = Vector3.new(0, 0, 0)
                    part.RotVelocity = Vector3.new(0, 0, 0)
                end
            end
        end
    end
end)

UpdateAllLanguage()

RunService.Heartbeat:Connect(function()
    if State.FlingV2 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.Velocity = Vector3.new(0, 0, 0)
        hrp.RotVelocity = Vector3.new(0, State.FlingPower * 100, 0)
    end
end)

RunService.Stepped:Connect(function()
    if State.SuperFling and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        hrp.RotVelocity = Vector3.new(50000, 50000, 50000)
    end
end)

RunService.RenderStepped:Connect(function()
    if (State.SuperFling or State.FlingV2) and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(0, 0, 0)
    end
end)