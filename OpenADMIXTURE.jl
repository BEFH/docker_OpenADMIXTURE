#!/usr/bin/env julia

using Random
using OpenADMIXTURE
using CSV, Tables, Printf
using ArgParse

function format_output(mat)
    tmat = transpose(mat)
    ftmat = map((x) -> @sprintf("%0.8f", x), tmat)
    Tables.table(ftmat)
end

function main()
    s = ArgParseSettings();
    @add_arg_table s begin
        "--seed"
            help = "Mersenne Twister Seed"
            arg_type = Int
        "--clusters", "-k"
            help = "number of population clusters"
            arg_type = Int
            required = true
        "--sparsity"
            help = "number of AIMs to be utilized by . "
            arg_type = Int
        "--single-precision"
            help = "Use 32 bit floats instead of 64 bit"
            action = :store_true
        "--use-cuda"
            help = "Use 32 bit floats instead of 64 bit"
            action = :store_true
        "filename"
            help = "Path to PLINK .bed file"
            required = true
        "--admix-n-iter"
            help = "Maximum number of Admixture iterations"
            arg_type = Int
            default = 1000
        "--admix-rtol"
            help = "Relative tolerance for Admixture termination"
            arg_type = Float64
            default = 1e-7
        "--admix-n-em-iters"
            help = "Number of iterations for EM initialization"
            arg_type = Int
            default = 5
        "--admix-quasi-newton-steps", "-q"
            help = "Number of steps used for quasi-Newton acceleration"
            arg_type = Int
            default = 3
        "--out"
            help = "Stem for output files"
    end
    parsed_args = parse_args(s)
    #parsed_args = parse_args(["-k=4", "filename"], s);

    println("Parsed args:")
    for (arg,val) in parsed_args
        println("  $arg  =>  $val")
    end
  
    if parsed_args["single-precision"]
       precision = Float32;
    else
       precision = Float64;
    end
  
    if !isnothing(parsed_args["out"])
        out_stem = parsed_args["out"];
    else
        out_stem = parsed_args["filename"][1:end-4];
    end
  
    out_p = string(out_stem, ".", parsed_args["clusters"], ".P");
    out_q = string(out_stem, ".", parsed_args["clusters"], ".Q");
  
    d, clusters, aims = OpenADMIXTURE.run_admixture(
        parsed_args["filename"],
        parsed_args["clusters"],
        rng=MersenneTwister(parsed_args["seed"]),
        sparsity=parsed_args["sparsity"],
        prefix=out_stem,
        admix_n_iter=parsed_args["admix-n-iter"],
        admix_rtol=parsed_args["admix-rtol"],
        admix_n_em_iters=parsed_args["admix-n-em-iters"],
        T=precision,
        Q=parsed_args["admix-quasi-newton-steps"],
        use_gpu=parsed_args["use-cuda"]);
        #skfr_tries=parsed_args[""],
        #skfr_max_inner_iter=parsed_args[""],
    println("\n\nGenerated admixture props for $(d.I) samples with $(d.J) variants.");
    println("$(d.K) clusters were used.")
    println("Final LogLikelihood was $(d.ll_new).")
    
    CSV.write(out_p, format_output(d.p), delim=" ", writeheader=false)
    CSV.write(out_q, format_output(d.q), delim=" ", writeheader=false)
end

main()

