using BlackBoxOptim
import Juno
function hjbsolver(;
    NRe,
    β,
    FR,
    pR,
    End,
    End1,
    Δx,
    r_max,
    SearchRanges,
    MaxEvals = false,
    MaxSteps = 10000,
)
    xv = 0:Δx:End
    n = length(xv)
    v = zeros(n + 1)
    vhat = zeros(n)
    v[1] = 1.0
    Re = zeros(n, NRe)

    function H0(r)
        r = r + 100.0 * (r .> r_max)
        pRR = pR(r)
        if pRR > 0
            s = v[1] * FR(r, Δx)
            return (β * v[1] - β * s) / pRR
        else
            return Inf
        end
    end
    MIN = bboptimize(
        H0;
        SearchRange = SearchRanges,
        TraceMode = :silent,
        MaxSteps = MaxSteps,
    )

    vhat[1] = best_fitness(MIN)
    v[2] = v[1] + Δx * vhat[1]
    Re[1, :] = best_candidate(MIN)

    l = n
    n1 = floor(Int, End1 / Δx + 1)
    Juno.@progress for i in 2:n1
        function H(r)
            r = r + 100.0 * (r .> r_max)
            pRR = pR(r)
            if pRR > 0
                FRΔ = FR(r, 0.0)
                FRΔ1 = FR(r, Δx)
                s = 0.0
                for j in 1:(i - 1)
                    s += (v[i - j + 1] + v[i - j]) * (FRΔ1 - FRΔ)
                    FRΔ = FRΔ1
                    FRΔ1 = FR(r, (j + 1) * Δx)
                end
                return β * (v[i] - 0.5 * s) / pRR
            else
                return Inf
            end
        end

        MIN = bboptimize(
            H;
            SearchRange = SearchRanges,
            MaxFuncEvals = MaxEvals,
            TraceMode = :silent,
            MaxSteps = MaxSteps,
        )
        vhat[i] = best_fitness(MIN)
        Re[i, :] = best_candidate(MIN)
        HMIN1 = H(Re[i - 1, :])
        if HMIN1 < vhat[i]
            vhat[i] = HMIN1
            Re[i, :] = Re[i - 1, :]
        end
        # while (vhat[i] > vhat[i - 1])
        #     MIN = bboptimize(
        #         H;
        #         SearchRange = SearchRanges,
        #         MaxFuncEvals = MaxEvals,
        #         TraceMode = :silent,
        #         MaxSteps = MaxSteps,
        #     )
        #     vhat[i] = best_fitness(MIN)
        #     Re[i, :] = best_candidate(MIN)
        # end
        v[i + 1] = v[i] + Δx * vhat[i]

        for k in 1:length(r_max)
            if Re[i, k] > r_max[k]
                Re[i, k] = 100.0
            end
        end
    end
    for i in (n1 + 1):n
        function H(r)
            pRR = pR(r)
            if pRR > 0
                FRΔ = FR(r, 0.0)
                FRΔ1 = FR(r, Δx)
                s = 0.0
                for j in 1:(i - 1)
                    s += (v[i - j + 1] + v[i - j]) * (FRΔ1 - FRΔ)
                    FRΔ = FRΔ1
                    FRΔ1 = FR(r, (j + 1) * Δx)
                end
                return β * (v[i] - 0.5 * s) / pRR
            else
                return Inf
            end
        end
        Re[i, :] = Re[i - 1, :]
        vhat[i] = H(Re[i, :])
        v[i + 1] = v[i] + Δx * vhat[i]
    end

    return collect(xv[1:l]), v[1:l] ./ v[l], vhat[1:l] ./ v[l], Re[1:l, :]
end
