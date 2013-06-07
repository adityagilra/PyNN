#!/usr/bin/python
import unittest, inspect, os, re, numpy, base64, subprocess

# TODO: parametrize this
node_cnts = (1, 2, 4, 8)
max_memory = 16000 # MB
sim = 'nest'

# find all benchmarks in this directory by name
benchmarks = []
for fname in os.listdir('.'):
    if fname.startswith("Benchmark") and fname.endswith(".py"):
        benchmarks.append(fname)


# Eric's decoration helper for parameterized unittests
def _parameterized_test(*params):
    def deco(method, params=params):
        for p in params:
            pname = re.sub('[^-_a-zA-Z0-9]', '', str(p))
            new_foo_name = method.__name__ + '_' + str(pname)
            def new_foo(self, method=method, parameter=p):
                method(self, parameter)
            new_foo.__name__ = new_foo_name # nose...
            frame = inspect.stack()[1][0]
            frame.f_locals[new_foo_name] = new_foo
        return None
    return deco


def create_slurm_job_file(script):
    content = "#!/bin/bash\n" + "time mpirun -np $SLURM_NTASKS -- python %s %s" % (script, sim)
    fname = 'job_%s.sh' % base64.urlsafe_b64encode(script)
    with open(fname, 'w') as fd:
        print >>fd, content
    return fname


def queue_slurm_job(fname):
    for n in node_cnts:
        options = "-o {job}_timing{cnt:05d}.log -- salloc -N{cnt}  --exclusive --mem={mem} -- bash {job}".format(cnt=n, job=fname, mem=max_memory)
        cmd = '/usr/bin/time -f%e ' + options
        subprocess.call(cmd, shell=True)


class Benchmarks(unittest.TestCase):
    @_parameterized_test(*benchmarks)
    def test_scaling(self, script):
        job_file = create_slurm_job_file(script)
        queue_slurm_job(job_file)
        corecnts = []
        runtimes = []

        for n in node_cnts:
            fname = str(job_file) + '_timing%05d' % n + ".log"
            runtime = None
            with open(fname, 'r') as fd:
                runtime = float(fd.readlines()[0].rstrip())
            try:
                os.unlink(fname)
            except OSError, e:
                if e.errno != errno.ENOENT:
                    raise
            corecnts.append(n)
            runtimes.append(runtime)

        if not corecnts:
            self.fail("No timing information found for %s" % script)

        X = numpy.array([ corecnts, numpy.ones(len(corecnts))])
        Y = numpy.array(runtimes)

        b, a = numpy.linalg.lstsq(X.T, Y)[0]

        base = Y[X[:,0].argmin(axis=0)]
        slope = b/min(runtimes)

        # slope < 5% => okay
        self.assertLess(slope, 0.05)
