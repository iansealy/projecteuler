#!/usr/bin/env perl

# PODNAME: 119.pl
# ABSTRACT: Digit power sum

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-08-20

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Math::BigInt;
use List::Util qw(sum);

# Default options
my $ordinal = 30;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @sequence;
my $sum = 1;
while ( scalar @sequence < 2 * $ordinal ) {
    $sum++;
    my $power = Math::BigInt->new($sum);
    while ( length $power < $sum ) {
        $power *= $sum;
        next if $power < 10;    ## no critic (ProhibitMagicNumbers)
        if ( sum( split //xms, $power ) == $sum ) {
            push @sequence, $power;
        }
    }
}

printf "%s\n", ( sort { $a <=> $b } @sequence )[ $ordinal - 1 ];

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'ordinal=i' => \$ordinal,
        'debug'     => \$debug,
        'help'      => \$help,
        'man'       => \$man,
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

119.pl

Digit power sum

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Digit power sum". The problem is:
Find a30.

=head1 EXAMPLES

    perl 119.pl --ordinal 10

=head1 USAGE

    119.pl
        [--ordinal INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--ordinal INT>

The required ordinal of the sequence.

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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
