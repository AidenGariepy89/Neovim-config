local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
local t = ls.text_node
local i = ls.insert_node

-- ls.add_snippets("all", {
--     s("ternary", {
--         i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else"), t(";")
--     }),
--     s({ trig = "trigger", name = "Testing" }, {
--         t("testing"),
--     }),
-- })

ls.add_snippets("rust", {
    s({ trig = "upr", name = "Use Prelude" }, {
        t("use crate::prelude::*;")
    })
})
