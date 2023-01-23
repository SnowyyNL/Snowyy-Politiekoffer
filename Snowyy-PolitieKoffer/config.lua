Config                 = {}

Config.ESXSharedObject = "esx:getSharedObject"

Config.Locales = {
    -- Menu text 
    ["Title"] = "Politie kleedkamer",
    ["HelpNotification"] = "Druk ~INPUT_CONTEXT~ om je ~r~Kleren~w~ te veranderen",  
    -- Kleren Menu
    ["BlackMask"] = "Zwarte masker",
    ["Bulletproof"] = "Kogelvrij vest",
    ["BulletproofHelmet"] = "Kogelvrije helm"
}
-- Welke Kleren 
Config.Kleren = {
    BlackMask = { ["mask_1"] = 77, ["mask_2"] = 0 },
    Bulletproof = { ["bproof_1"] = 26, ["bproof_2"] = 0 },
    BulletproofHelmet = { ["helmet_1"] = 81, ["helmet_2"] = 0 }
}
-- Welke Jobs die kleren kan pakken in kofferbak,
Config.Jobs = {
    "police",
    "kmar"
}
-- Welke Politie Auto's
Config.Autos = {
    "modelauto",
    "modelauto",
    "modelauto"
}