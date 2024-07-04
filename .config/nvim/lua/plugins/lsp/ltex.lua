local M = {}

M.opts = {
	settings = {
		ltex = {
			disabledRules = {
				["en"] = { "MORFOLOGIK_RULE_EN", "UPPERCASE_SENTENCE_START" },
				["en-AU"] = { "MORFOLOGIK_RULE_EN_AU", "UPPERCASE_SENTENCE_START" },
				["en-CA"] = { "MORFOLOGIK_RULE_EN_CA", "UPPERCASE_SENTENCE_START" },
				["en-GB"] = { "MORFOLOGIK_RULE_EN_GB", "UPPERCASE_SENTENCE_START" },
				["en-NZ"] = { "MORFOLOGIK_RULE_EN_NZ", "UPPERCASE_SENTENCE_START" },
				["en-US"] = { "MORFOLOGIK_RULE_EN_US", "UPPERCASE_SENTENCE_START" },
				["en-ZA"] = { "MORFOLOGIK_RULE_EN_ZA", "UPPERCASE_SENTENCE_START" },
			},
		},
	},
}

return M
