
# add https://gitlab.com/mo_julia/tikz.git
using Plots
include("HJB_Solver_Ruin.jl");
include("FR_pR.jl");
Path = "/home/khaled/Dropbox/Khaled-Mohammad/RevisedPaper/new_code_julia/";
RE = ["P", "XL"];

RES = Array{Any}(undef, 2, 2, 2);

#################################
#############XLXLXL##############
#################################
begin
    L1 = 2  ## XL
    L2 = 2  ## XL
    L3 = 2  ## XL
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3) ##XLXLXL
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 20.0,
        End1 = 2.0,
        Δx = 0.01,
        r_max = [1.5, 1.5, 1.5],
        SearchRanges = [(0.0, 1.8), (0.0, 1.8), (0.0, 1.8)],
        MaxEvals = false,
        MaxSteps = 20000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")

#################################
#############PPP#################
#################################
begin
    L1 = 1  ## P
    L2 = 1  ## P
    L3 = 1  ## P
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 10.0,
        Δx = 0.01,
        r_max = [1.0, 1.0, 1.0],
        SearchRanges = [(0.0, 1.0), (0.0, 1.0), (0.0, 1.0)],
        MaxEvals = false,
        MaxSteps = 2000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")

#################################
#############XLPP#################
#################################
begin
    L1 = 2
    L2 = 1
    L3 = 1
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 5.0,
        Δx = 0.01,
        r_max = [1.5, 1.0, 1.0],
        SearchRanges = [(0.0, 1.8), (0.0, 1.0), (0.0, 1.0)],
        MaxEvals = false,
        MaxSteps = 5000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")

#################################
#############PXLP#################
#################################
begin
    L1 = 1
    L2 = 2
    L3 = 1
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 5.0,
        Δx = 0.01,
        r_max = [1.0, 2.5, 1.0],
        SearchRanges = [(0.0, 1.0), (0.0, 1.8), (0.0, 1.0)],
        MaxEvals = false,
        MaxSteps = 5000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")

#################################
#############PPXL#################
#################################
begin
    L1 = 1
    L2 = 1
    L3 = 2
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 5.0,
        Δx = 0.01,
        r_max = [1.0, 1.0, 2.0],
        SearchRanges = [(0.0, 1.0), (0.0, 1.0), (0.0, 2.0)],
        MaxEvals = false,
        MaxSteps = 5000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")

#################################
#############PXLXL#################
#################################
begin
    L1 = 1
    L2 = 2
    L3 = 2
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 5.0,
        Δx = 0.01,
        r_max = [1.0, 2.0, 2.0],
        SearchRanges = [(0.0, 1.0), (0.0, 2.0), (0.0, 2.0)],
        MaxEvals = false,
        MaxSteps = 5000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")

#################################
#############XLPXL#################
#################################
begin
    L1 = 2
    L2 = 1
    L3 = 2
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 5.0,
        Δx = 0.01,
        r_max = [2.0, 1.0, 2.0],
        SearchRanges = [(0.0, 2.0), (0.0, 1.0), (0.0, 2.0)],
        MaxEvals = false,
        MaxSteps = 5000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")
#################################
#############XLXLP#################
#################################
begin
    L1 = 2
    L2 = 2
    L3 = 1
    NAME = RE[L1] * RE[L2] * RE[L3]
    FR, pR, β = FR_pR(L1, L2, L3)
    @time RES[L1, L2, L3] = hjbsolver(;
        NRe = 3,
        β = β,
        FR = FR,
        pR = pR,
        End = 40.0,
        End1 = 5.0,
        Δx = 0.01,
        r_max = [1.5, 1.5, 1.0],
        SearchRanges = [(0.0, 1.8), (0.0, 1.8), (0.0, 1.0)],
        MaxEvals = false,
        MaxSteps = 5000,
    )
end;
x = RES[L1, L2, L3][1];
delta = RES[L1, L2, L3][2];
R1 = RES[L1, L2, L3][4][:, 1];
R2 = RES[L1, L2, L3][4][:, 2];
R3 = RES[L1, L2, L3][4][:, 3];
Plot_delta = plot(x, delta, ylims = (0, 1), legend = false)
savefig(Plot_delta, Path * "Plots/" * NAME * "_delta.pdf")
begin
    Plot_R = plot(x, R1, label = "Line 1")
    plot!(x, R2, label = "Line 2")
    plot!(x, R3, label = "Line 3")
    plot!(xlims = (0, 10), ylims = (0, 1.65))
end
savefig(Plot_R, Path * "Plots/" * NAME * "_R.pdf")
##3#################################
#SurvivalFunction
x112 = RES[1, 1, 2][1];
delta112 = RES[1, 1, 2][2];
x121 = RES[1, 2, 1][1];
delta121 = RES[1, 2, 1][2];
x211 = RES[2, 1, 1][1];
delta211 = RES[2, 1, 1][2];
x122 = RES[1, 2, 2][1];
delta122 = RES[1, 2, 2][2];
x212 = RES[2, 1, 2][1];
delta212 = RES[2, 1, 2][2];
x221 = RES[2, 2, 1][1];
delta221 = RES[2, 2, 1][2];
x111 = RES[1, 1, 1][1];
delta111 = RES[1, 1, 1][2];
x222 = RES[2, 2, 2][1];
delta222 = RES[2, 2, 2][2];
#using UnicodePlots
begin
    #unicodeplots()
    Plot_delta = plot(
        x111,
        delta111,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, P, P",
    )
    plot!(
        x112,
        delta112,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, P, XL",
    )
    plot!(
        x121,
        delta121,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, XL, P",
    )
    plot!(
        x211,
        delta211,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, P, P",
    )
    plot!(
        x212,
        delta212,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, P, XL",
    )
    plot!(
        x221,
        delta221,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, XL, P",
    )
    plot!(
        x222,
        delta222,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, XL, XL",
    )
    plot!(
        x122,
        delta122,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, XL, XL",
    )
end
savefig(Plot_delta, Path * "Plots/AllSurvival_R.pdf")
begin
    Plot_deltaOneXL = plot(
        x112,
        delta112,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, P, XL",
    )
    plot!(
        x121,
        delta121,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, XL, P",
    )
    plot!(
        x211,
        delta211,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, P, P",
    )
end
savefig(Plot_deltaOneXL, Path * "Plots/OneXL_R.pdf")
begin
    Plot_deltaTwoXL = plot(
        x212,
        delta212,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, P, XL",
    )
    plot!(
        x221,
        delta221,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "XL, XL, P",
    )
    plot!(
        x122,
        delta122,
        ylims = (0.25, 1),
        xlims = (0, 20),
        label = "P, XL, P",
    )
end
savefig(Plot_deltaTwoXL, Path * "Plots/TwoXL_R.pdf")
###########################################
############Python Plot####################
###########################################
#Path = "/home/mohammad/Dropbox/Khaled-Mohammad/RevisedPaper/new_code_julia/";
using PyPlot
rc("text", usetex = true)
rc("font", family = "serif")

begin
    L1 = 2  ## XL
    L2 = 2  ## XL
    L3 = 2  ## XL
    NAME = RE[L1] * RE[L2] * RE[L3]
    x = RES[L1, L2, L3][1]
    delta = RES[L1, L2, L3][2]
    R1 = RES[L1, L2, L3][4][:, 1]
    R2 = RES[L1, L2, L3][4][:, 2]
    R3 = RES[L1, L2, L3][4][:, 3]
    ##Plot of delta
    PyPlot.figure(figsize = (12, 6))
    PyPlot.plot(x, delta, color = "black", label = raw"$a(x)$", alpha = 0.7)
    PyPlot.xlabel(raw"$x$", fontsize = 25)
    PyPlot.axhline(y = 0, color = "k")
    PyPlot.axvline(x = 0, color = "k")
    PyPlot.grid(color = "0.7", linestyle = "--")
    #PyPlot.legend(fontsize = 16)
    PyPlot.savefig(
        Path * "Python_Plots/" * NAME * "_delta.pdf",
        bbox_inches = "tight",
    )
    ##Plot of R
    PyPlot.figure(figsize = (12, 6))
    PyPlot.plot(x, R1, label = "Line 1", color = "black")
    PyPlot.plot(x, R2, label = "Line 2", linestyle = "dashed", color = "black")
    PyPlot.plot(x, R3, label = "Line 3", linestyle = "dashdot", color = "black")
    PyPlot.xlim(0, 10)
    PyPlot.ylim(0, 1.65)
    PyPlot.legend(fontsize = 16)
    PyPlot.grid(color = "0.7", linestyle = "--")
    PyPlot.savefig(
        Path * "Python_Plots/" * NAME * "_R.pdf",
        bbox_inches = "tight",
    )
end
