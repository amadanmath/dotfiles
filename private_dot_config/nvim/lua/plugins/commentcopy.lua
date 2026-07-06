return {
    "amadanmath/commentcopy.nvim",
    keys = {
        { "gC", function() require("commentcopy").comment_copy_range(false) end, mode = "n", desc = "Comment copy" },
        { "gC", function() require("commentcopy").comment_copy_range(true) end, mode = "x", desc = "Comment copy range" },
    },
    -- opts = {} can be passed here or config = true, without key collisions!
}
