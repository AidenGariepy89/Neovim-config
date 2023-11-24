local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node

-- ls.add_snippets("all", {
--     s("ternary", {
--         i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else"), t(";")
--     }),
--     s({ trig = "trigger", name = "Testing" }, {
--         sn(1, {
--             i(1, ""), t("fn "), i(2, ""), t("("), i(3, ""), t(") -> "), i(4, ""), t({" {", ""})
--         }),
--         sn(2, {
--             t("\t"), i(1, ""), t({"", "", "\ttodo!();", "}"})
--         }),
--     }),
-- })

ls.add_snippets("python", {
    s({ trig = "doc", name = "Docstring" }, {
        t("\"\"\""), i(1, ""), t("\"\"\"")
    }),
})

ls.add_snippets("rust", {
    s({ trig = "upr", name = "Use Prelude" }, {
        t("use crate::prelude::*;")
    }),
    s({ trig = "fnn", name = "Rust Function" }, {
        sn(1, {
            i(1, ""), t("fn "), i(2, ""), t("("), i(3, ""), t(") -> "), i(4, ""), t({" {", ""})
        }),
        sn(2, {
            t("\t"), i(1, "todo!()"), t({"", "}"})
        }),
    }),
})
