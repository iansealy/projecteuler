#!/usr/bin/env perl

# PODNAME: 97.pl
# ABSTRACT: Large non-Mersenne prime

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-04-22

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $POWER      => 7_830_457;
Readonly our $MULTIPLIER => 28_433;
Readonly our $DIGITS     => 10;

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my $num = 1;

foreach ( 1 .. $POWER ) {
    $num *= 2;
    if ( length $num > $DIGITS ) {
        $num =~ s/\A \d+ (\d{$DIGITS}) \z/$1/xms;
    }
}

$num *= $MULTIPLIER;
$num++;
$num =~ s/\A \d+ (\d{$DIGITS}) \z/$1/xms;

printf "%d\n", $num;

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

97.pl

Large non-Mersenne prime

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Large non-Mersenne prime". The
problem is: Find the last ten digits of this prime number.

=head1 EXAMPLES

    perl 97.pl

=head1 USAGE

    97.pl
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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
