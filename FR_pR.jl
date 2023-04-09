function FR_pR(L1, L2, L3) ## 1 = P, 2 = XL
    β1 = 8.0
    β2 = 4.0
    β3 = 5.0

    η0_1 = 0.3
    η1_1 = 0.35

    η0_2 = 0.2
    η1_2 = 0.25

    η0_3 = 0.25
    η1_3 = 0.3

    β = β1 + β2 + β3
    βn1 = β1 / β
    βn2 = β2 / β
    βn3 = β3 / β
    ###############Line 1
    λ1 = 0.5
    λ1i = 1 / λ1
    μ1 = λ1i
    function FR1(b1, x)
        if L1 == 1
            return 1 - exp(-λ1 * x / b1)
        else
            if x >= b1
                return 1.0
            else
                return 1 - exp(-λ1 * x)
            end
        end
    end
    function ER1(b1)
        if L1 == 1
            return b1 * μ1
        else
            return (1 - exp(-λ1 * b1)) * λ1i
        end
    end

    ##############Line 2
    λ2 = 3.0
    k = 3.0
    μ2 = (k / (λ2 - 1))
    function FR2(b2, x)
        if L2 == 1
            return 1 - ((b2 * k) / (b2 * k + x))^λ2
        else
            if x >= b2
                return 1.0
            else
                return 1 - (k / (k + x))^λ2
            end
        end
    end
    function ER2(b2)
        if L2 == 1
            return b2 * μ2
        else
            return (1 / (λ2 - 1)) * (k - (k^λ2) / ((k + b2)^(λ2 - 1)))
        end
    end

    ###############Line 3
    p1 = 0.7
    F3(x) = p1 * (1 - exp(-λ1 * x)) + (1 - p1) * (1 - (k / (k + x))^λ2)
    μ3 = p1 * μ1 + (1 - p1) * μ2
    function FR3(b3, x)
        if L3 == 1
            return F3(x / b3)
        else
            if x >= b3
                return 1.0
            else
                return F3(x)
            end
        end
    end

    function ER3(b3)
        if L3 == 1
            return b3 * μ3
        else
            return p1 * ((1 - exp(-λ1 * b3)) * λ1i) +
                   (1 - p1) *
                   ((1 / (λ2 - 1)) * (k - (k^λ2) / ((k + b3)^(λ2 - 1))))
        end
    end
    ################
    FR(r, x) = βn1 * FR1(r[1], x) + βn2 * FR2(r[2], x) + βn3 * FR3(r[3], x)
    ################
    pR(r) =
        ((1 + η0_1) * μ1 - (1 + η1_1) * (μ1 - ER1(r[1]))) * β1 +
        ((1 + η0_2) * μ2 - (1 + η1_2) * (μ2 - ER2(r[2]))) * β2 +
        ((1 + η0_3) * μ3 - (1 + η1_3) * (μ3 - ER3(r[3]))) * β3
    return FR, pR, β
end;
