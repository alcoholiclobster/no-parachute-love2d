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
        currentLanguage = require("config.localization."..name)
    end
}