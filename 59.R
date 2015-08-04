# XOR decryption

# Constants
CIPHER_URL <- 'https://projecteuler.net/project/resources/p059_cipher.txt'

decrypt <- function(cipher) {
    for ( key1 in seq.int(97, 122) ) {
        for ( key2 in seq.int(97, 122) ) {
            for ( key3 in seq.int(97, 122) ) {
                key <- c(key1, key2, key3)
                plain_ascii <- bitwXor(cipher, key)
                plain <- rawToChar(as.raw(plain_ascii))
                if ( grepl(' the ', plain) ) {
                    return(sum(plain_ascii))
                }
            }
        }    
    }
}

cipher <- suppressWarnings(read.csv(sub('https', 'http', CIPHER_URL),
                                    header=FALSE, colClasses='character',
                                    na.strings=""))
cipher <- as.integer(cipher[1,])

cat(decrypt(cipher), fill=TRUE)
