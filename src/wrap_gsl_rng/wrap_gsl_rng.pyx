cimport cgsl_rng

cdef class wrap_gsl_rng:
    cdef cgsl_rng.gsl_rng_type* _c_T
    cdef cgsl_rng.gsl_rng* _c_r


    cdef public int seed

    def __cinit__(self, seed=None, type='mt19937'):
        cgsl_rng.gsl_rng_env_setup()

        if type == 'mt19937':
            self._c_T = cgsl_rng.gsl_rng_mt19937
        elif type == 'rand48':
            self._c_T = cgsl_rng.gsl_rng_rand48
        else:
            raise RuntimeError('rng type not implemented')
        
        self._c_r = cgsl_rng.gsl_rng_alloc(self._c_T)

        if seed:
            self.seed = seed
        else:
            import time
            self.seed = int(time.time())
        cgsl_rng.gsl_rng_set(self._c_r, self.seed)


    def next(self, distribution='uniform', n=1, parameters=[], mask_local=None):
        if mask_local:
            raise RuntimeError("not implemented")
        # ugly, but reflection doesnt work and function refs in dict fail too
        if distribution == 'uniform':
            return [ cgsl_rng.gsl_ran_flat(self._c_r, parameters[0], parameters[1]) for i in xrange(0, n) ]
        elif distribution == 'beta':
            return [ cgsl_rng.gsl_ran_beta(self._c_r, parameters[0], parameters[1]) for i in xrange(0, n) ]
        else:
            raise RuntimeError('distribution %s not implemented' % distribution)
