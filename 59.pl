#!/usr/bin/env perl

# PODNAME: 59.pl
# ABSTRACT: XOR decryption

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-08-02

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use LWP::Simple;

# Constants
Readonly our $CIPHER_URL =>
  'https://projecteuler.net/project/resources/p059_cipher.txt';

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $cipher = get($CIPHER_URL);
my @cipher = split /,/xms, $cipher;

my $plain_sum = 0;

KEY: foreach my $key1 ( q{a} .. q{z} ) {
    foreach my $key2 ( q{a} .. q{z} ) {
        foreach my $key3 ( q{a} .. q{z} ) {
            my @key   = ( $key1, $key2, $key3 );
            my $plain = q{};
            my $sum   = 0;
            foreach my $i ( 0 .. ( scalar @cipher ) - 1 ) {
                ## no critic (ProhibitMagicNumbers)
                my $xor = $cipher[$i] ^ ord( $key[ $i % 3 ] );
                ## use critic
                $plain .= chr $xor;
                $sum += $xor;
            }
            if ( $plain =~ m/\s the \s/xms ) {
                $plain_sum = $sum;
                last KEY;
            }
        }
    }
}

printf "%d\n", $plain_sum;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'debug' => \$debug,
        'help'  => \$help,
        'man'   => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

59.pl

XOR decryption

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "XOR decryption". The problem is:
Using cipher.txt, a file containing the encrypted ASCII codes, and the knowledge
that the plain text must contain common English words, decrypt the message and
find the sum of the ASCII values in the original text.

=head1 EXAMPLES

    perl 59.pl

=head1 USAGE

    59.pl
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy <ian.sealy@sanger.ac.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
