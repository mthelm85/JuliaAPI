using Genie
using Genie.Router
import Genie.Router: route
import Genie.Renderer: json

function addxy(x::Int64, y::Int64)
    return sum([x,y])
end

function launch_server(port)
    Genie.config.run_as_server = true
    Genie.config.server_host = "0.0.0.0"
    Genie.config.server_port = port
    Genie.config.cors_allowed_origins = ["*"]

    route("/addxy") do
        x = parse(Int, get(@params, :x, "0"))
        y = parse(Int, get(@params, :y, "0"))
        (:answer => addxy(x,y)) |> json
    end

    Genie.startup()
end

launch_server(parse(Int, ARGS[1]))
