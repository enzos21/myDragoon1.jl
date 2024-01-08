using Dragoon
using Plots


n = 20
f = 22
b = 30

freqs = genFreqs(f*1e9,b*1e6; length=150) 
freqsplot = genFreqs(f*1e9,b*1e6; length=1000)
initdist = findpeak(f*1e9, n)

#number of discs in the booster
n = 20


booster = AnalyticalBooster(initdist; ndisk=n)
booster.tand = 0.
hist = initHist(booster,10000,freqs,ObjAnalytical)

trace = linesearch(booster,hist,freqs,10e-6, 
                    ObjAnalytical,
                    SolverHybrid("inv", 0.,10e-6, 1),
                    Derivator2(5e-5,10e-6,"double"),
                    StepNorm("unit"),
                    SearchExtendedSteps(200),
                    UnstuckRandom(-1e-3,-5000);
                    ϵgrad=0.,maxiter=Int(1e2),showtrace=true);

pltt = analyse(hist,trace,freqsplot; freqs=freqs,div=10)

