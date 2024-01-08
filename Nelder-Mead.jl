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



freqs = genFreqs(f*1e9,b*1e6; length=150) 
freqsplot = genFreqs(f*1e9,b*1e6; length=1000)
initdist = findpeak(f*1e9, n)


booster = AnalyticalBooster(initdist; ndisk=n)
booster.tand = 0.
hist = initHist(booster,10000,freqs,ObjAnalytical)

trace = nelderMead(booster,hist,freqs,
                1.,1+2/n,0.75-1/2n,1-1/n,0.,
                ObjAnalytical,
                InitSimplexCoord(1e-4),
                DefaultSimplexSampler,
                UnstuckRandom(1e-4, -7000);
                maxiter=Int(1e3),
                showtrace=true,
                showevery=100,
                unstuckisiter=true);

pltt = analyse(hist,trace,freqsplot; freqs=freqs,div=10)
    
