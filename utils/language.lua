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
        local languageName = "en"

        local langString = os.getenv("LANG")
        if langString then
            local osLocale = string.sub(langString, 0, 5)

            if osLocale == "ru_RU" then
                return "ru"
            end
        end

        return languageName
    end,
}