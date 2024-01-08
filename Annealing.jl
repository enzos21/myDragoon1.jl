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

T = collect(range(100; length=2001,stop=0))

trace = simulatedAnnealing(booster,hist,freqs,
                            T,100e-6,
                            ObjAnalytical,
                            UnstuckDont;
                            maxiter=Int(1e5),
                            nreset=50,
                            nresetterm=2,
                            showtrace=true,
                            showevery=100,
                            unstuckisiter=true,
                            traceevery=1,
                            resettimer=true)


pltt = analyse(hist,trace[1:end-1],freqsplot; freqs=freqs,div=20,scale=1e9,ylim=[-0.05e4,3e4])
    


