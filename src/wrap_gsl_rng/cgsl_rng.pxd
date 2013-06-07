cdef extern from "gsl/gsl_randist.h":
    ctypedef struct gsl_rng_type:
        pass
    ctypedef struct gsl_rng:
        pass


    gsl_rng_type* gsl_rng_env_setup ()
    gsl_rng* gsl_rng_alloc (gsl_rng_type* T)
    void gsl_rng_set (gsl_rng* r, unsigned long int seed)

    extern gsl_rng_type* gsl_rng_default
    extern gsl_rng_type *gsl_rng_borosh13
    extern gsl_rng_type *gsl_rng_coveyou
    extern gsl_rng_type *gsl_rng_cmrg
    extern gsl_rng_type *gsl_rng_fishman18
    extern gsl_rng_type *gsl_rng_fishman20
    extern gsl_rng_type *gsl_rng_fishman2x
    extern gsl_rng_type *gsl_rng_gfsr4
    extern gsl_rng_type *gsl_rng_knuthran
    extern gsl_rng_type *gsl_rng_knuthran2
    extern gsl_rng_type *gsl_rng_knuthran2002
    extern gsl_rng_type *gsl_rng_lecuyer21
    extern gsl_rng_type *gsl_rng_minstd
    extern gsl_rng_type *gsl_rng_mrg
    extern gsl_rng_type *gsl_rng_mt19937
    extern gsl_rng_type *gsl_rng_mt19937_1999
    extern gsl_rng_type *gsl_rng_mt19937_1998
    extern gsl_rng_type *gsl_rng_r250
    extern gsl_rng_type *gsl_rng_ran0
    extern gsl_rng_type *gsl_rng_ran1
    extern gsl_rng_type *gsl_rng_ran2
    extern gsl_rng_type *gsl_rng_ran3
    extern gsl_rng_type *gsl_rng_rand
    extern gsl_rng_type *gsl_rng_rand48
    extern gsl_rng_type *gsl_rng_random128_bsd
    extern gsl_rng_type *gsl_rng_random128_glibc2
    extern gsl_rng_type *gsl_rng_random128_libc5
    extern gsl_rng_type *gsl_rng_random256_bsd
    extern gsl_rng_type *gsl_rng_random256_glibc2
    extern gsl_rng_type *gsl_rng_random256_libc5
    extern gsl_rng_type *gsl_rng_random32_bsd
    extern gsl_rng_type *gsl_rng_random32_glibc2
    extern gsl_rng_type *gsl_rng_random32_libc5
    extern gsl_rng_type *gsl_rng_random64_bsd
    extern gsl_rng_type *gsl_rng_random64_glibc2
    extern gsl_rng_type *gsl_rng_random64_libc5
    extern gsl_rng_type *gsl_rng_random8_bsd
    extern gsl_rng_type *gsl_rng_random8_glibc2
    extern gsl_rng_type *gsl_rng_random8_libc5
    extern gsl_rng_type *gsl_rng_random_bsd
    extern gsl_rng_type *gsl_rng_random_glibc2
    extern gsl_rng_type *gsl_rng_random_libc5
    extern gsl_rng_type *gsl_rng_randu
    extern gsl_rng_type *gsl_rng_ranf
    extern gsl_rng_type *gsl_rng_ranlux
    extern gsl_rng_type *gsl_rng_ranlux389
    extern gsl_rng_type *gsl_rng_ranlxd1
    extern gsl_rng_type *gsl_rng_ranlxd2
    extern gsl_rng_type *gsl_rng_ranlxs0
    extern gsl_rng_type *gsl_rng_ranlxs1
    extern gsl_rng_type *gsl_rng_ranlxs2
    extern gsl_rng_type *gsl_rng_ranmar
    extern gsl_rng_type *gsl_rng_slatec
    extern gsl_rng_type *gsl_rng_taus
    extern gsl_rng_type *gsl_rng_taus2
    extern gsl_rng_type *gsl_rng_taus113
    extern gsl_rng_type *gsl_rng_transputer
    extern gsl_rng_type *gsl_rng_tt800
    extern gsl_rng_type *gsl_rng_uni
    extern gsl_rng_type *gsl_rng_uni32
    extern gsl_rng_type *gsl_rng_vax
    extern gsl_rng_type *gsl_rng_waterman14
    extern gsl_rng_type *gsl_rng_zuf

    double gsl_rng_uniform (gsl_rng* r)
    double gsl_ran_beta (gsl_rng * r, double a, double b)
    double gsl_ran_exponential (gsl_rng * r, double mu)
    double gsl_ran_exppow (gsl_rng * r, double a, double b)
    double gsl_ran_chisq (gsl_rng * r, double nu)
    double gsl_ran_flat (gsl_rng * r, double a, double b)
    double gsl_ran_gamma (gsl_rng * r, double a, double b)
    double gsl_ran_gaussian (gsl_rng * r, double sigma)
