using GeneralizedMetropolisHastings
using PyPlot

# define the data object
t = -1.0:0.05:1.0;
d = data(:function, t, sin, 2.0*pi*t);

# generate a new set of data values
GeneralizedMetropolisHastings.generate!(d)

# retrieve data index and values and plot
plot(dataindex(d), datavalues(d))
title("Data with $(numvars(d)) variable and $(numvalues(d)) values")
xlabel("Time")
ylabel("Values")
xlim(-1.0,1.0)
show()
