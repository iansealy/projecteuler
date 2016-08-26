# Square remainders

a <- seq.int(3, 1000)

cat(sum(a * (a - 2 + a %% 2)), fill=TRUE)
