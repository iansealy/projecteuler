#!/usr/bin/env node

// XOR decryption

var CIPHER_URL = 'https://projecteuler.net/project/resources/p059_cipher.txt';

var request = require('request');
request(CIPHER_URL, function(error, response, body) {
    if (!error && response.statusCode == 200) {
        decrypt(body.split(","));
    }
});

function decrypt(cipher) {
    for (var key1 = 97; key1 < 123; key1++) {
        for (var key2 = 97; key2 < 123; key2++) {
            for (var key3 = 97; key3 < 123; key3++) {
                var key = [key1, key2, key3];
                var plain = '';
                var sum = 0;
                for (var i = 0; i < cipher.length; i++) {
                    var xor = parseInt(cipher[i]) ^ key[i % 3];
                    plain += String.fromCharCode(xor);
                    sum += xor;
                }
                if (plain.indexOf(' the ') >= 0) {
                    console.log(sum);
                    return;
                }
            }
        }
    }
}
