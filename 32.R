# Pandigital products

get_products <- function(low_multiplicand, high_multiplicand, low_multiplier,
                         high_multiplier) {

    multiplicand <- rep(low_multiplicand:high_multiplicand,
                        each=high_multiplier-low_multiplier+1)
    multiplier <- rep(low_multiplier:high_multiplier,
                      high_multiplicand-low_multiplicand+1)
    product <- multiplicand * multiplier
    digits <- paste(as.character(multiplicand), as.character(multiplier),
                    as.character(product), sep="")

    df <- data.frame(multiplicand, multiplier, product, digits,
                     stringsAsFactors=FALSE)

    candidates <- product < 10000 & !grepl('0', multiplicand) &
        !grepl('0', multiplier) & !grepl('0', product)

    df <- df[candidates,]

    pandigital <- sapply(df$digits, function(i) {
        length(unique(as.integer(strsplit(i, split=NULL)[[1]]))) == 9
    })
    return(df$product[pandigital])
}

products <- vector()
products <- c(products, get_products(1, 9, 1234, 9876))
products <- c(products, get_products(12, 98, 123, 987))

cat(sum(unique(products)), fill=TRUE)
