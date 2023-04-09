function FR_pR()
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
    ###############exp
    #P
    λ1 = 0.5
    λ1i = 1 / λ1
    function FR1P(b1, x)
        if b1 > 0.0
            return 1-exp(-λ1*x*λ1i)
        else
            return 1.0
        end
    end
    ER1P(b1) = b1 * λ1i

    #XL
    function FR1(b1, x)
        if x >= b1
            return 1.0
        else
            return 1 - exp(-λ1 * x)
        end
    end
    ER1(b1) = (1 - exp(-λ1 * b1)) * λ1i
    ##############Pareto
    #-P
    λ2 = 3.0
    k = 3.0
    function FR2P(b2, x)
        if b2 > 0.0
            return 1 - ((b2*k) / (b2*k + x))^λ2
        else
            return 1.0
        end
    end
    ER2P(b2) = b2*(k/(λ2-1))
    #-XL
    λ2 = 3.0
    k = 3.0
    function FR2(b2, x)
        if x >= b2
            return 1.0
        else
            return 1 - ((k) / (k + x))^λ2
        end
    end
    ER2(b2) = (1 / (λ2 - 1)) * (k - (k^λ2) / ((k + b2)^(λ2 - 1)))
    ###############Line 3
    p1 = 0.7
    FR3(a1, x) = p1 * FR1P(a1, x) + (1 - p1) * FR2P(a1, x)
    ER3(a1) = p1 * ER1P(a1) + (1 - p1) * ER2P(a1)
    #####################
    FR(r, x) = βn1 * FR1(r[1], x) + βn2 * FR2P(r[2], x) + βn3 * FR3(r[3], x)
    ################pR
    μ1 = ER1P(Inf)
    μ2 = ER2P(1.0)
    μ3 = ER3(1.0)
    pR(r) =
        ((1 + η0_1) * μ1 - (1 + η1_1) * (μ1 - ER1(r[1]))) * β1 +
        ((1 + η0_2) * μ2 - (1 + η1_2) * (μ2 - ER2P(r[2]))) * β2 +
        ((1 + η0_3) * μ3 - (1 + η1_3) * (μ3 - ER3(r[3]))) * β3
    return FR, pR, β
end;
