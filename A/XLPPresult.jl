# add https://gitlab.com/mo_julia/tikz.git
using TikZ
include("HJB_Solver_Ruin.jl");
include("PPP.jl");
FR, pR, β = FR_pR();

res = hjbsolver(;
    NRe = 3,
    β = β,
    FR = FR,
    pR = pR,
    End = 10.0,
    End1 = 2.0,
    Δx = 0.05,
    r_max = [2.8, 1.0, 1.0],
    SearchRanges = [(0.0, 1.9), (0.0, 1.0), (0.0, 1.0)],
    MaxEvals = false,
);

####Plot
TikZ.plot(
    res[1],
    res[2],
    O = (0, 0),
    xtick = 0:10,
    ytick = [0.2, 0.4, 0.6, 0.8, 1.0],
    Plot_name = "XLXLXL_delta",
    Address = "/home/khaled/",
)

let
    xmax = 12
    ymax = 3.6

    Ind =
        (res[1] .< xmax) .& (res[4][:, 1] .< ymax) .& (res[4][:, 2] .< ymax) .&
        (res[4][:, 3] .< ymax)
    X = [res[1][Ind] res[1][Ind] res[1][Ind]]
    Y = [res[4][Ind, 1] res[4][Ind, 2] res[4][Ind, 3]]

    TikZ.plot(
        X,
        Y,
        O = (0, 0),
        xtick = 0.5:0.5:2,
        ytick = [0.1, 0.2, 0.3, 0.4, 0.5],
        Plot_name = "XLXLXL_R",
        Address = "/home/khaled/",
    )
end
