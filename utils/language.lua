local currentLanguageName = nil
local currentLanguage = {}

return {
    localize = function (label, ...)
        local text = currentLanguage[label]
        if not text then
            return label
        end

        return string.format(text, ...)
    end,

    loadLanguage = function (name)
        if not name then
            name = "en"
        end
        currentLanguage = require("config.localization."..name)
        currentLanguageName = name
    end,

    getCurrentLanguage = function ()
        return currentLanguageName
    end,

    getSystemLanguage = function ()
        local osLocale = string.sub(os.getenv("LANG"), 0, 5)
        local languageName = "en"

        if osLocale == "ru_RU" then
            return "ru"
        end

        return languageName
    end,
}