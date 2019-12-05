using Genie
using Genie.Router
import Genie.Router: route
import Genie.Renderer: json

function addxy(x::Int64, y::Int64)
    return sum([x,y])
end

Genie.config.run_as_server = true

route("/addxy") do
    x = parse(Int, get(@params, :x, "0"))
    y = parse(Int, get(@params, :y, "0"))
    (:answer => addxy(x,y)) |> json
end

Genie.startup(async=false)
