#!/usr/bin/env perl

# PODNAME: 84.pl
# ABSTRACT: Monopoly odds

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-11-01

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;

# Constants
Readonly our $SQUARES  => 40;
Readonly our $CC_CARDS => 16;
Readonly our $CH_CARDS => 16;
Readonly our $GO       => 0;
Readonly our $A1       => 1;
Readonly our $CC1      => 2;
Readonly our $A2       => 3;
Readonly our $T1       => 4;
Readonly our $R1       => 5;
Readonly our $B1       => 6;
Readonly our $CH1      => 7;
Readonly our $B2       => 8;
Readonly our $B3       => 9;
Readonly our $JAIL     => 10;
Readonly our $C1       => 11;
Readonly our $U1       => 12;
Readonly our $C2       => 13;
Readonly our $C3       => 14;
Readonly our $R2       => 15;
Readonly our $D1       => 16;
Readonly our $CC2      => 17;
Readonly our $D2       => 18;
Readonly our $D3       => 19;
Readonly our $FP       => 20;
Readonly our $E1       => 21;
Readonly our $CH2      => 22;
Readonly our $E2       => 23;
Readonly our $E3       => 24;
Readonly our $R3       => 25;
Readonly our $F1       => 26;
Readonly our $F2       => 27;
Readonly our $U2       => 28;
Readonly our $F3       => 29;
Readonly our $G2J      => 30;
Readonly our $G1       => 31;
Readonly our $G2       => 32;
Readonly our $CC3      => 33;
Readonly our $G3       => 34;
Readonly our $R4       => 35;
Readonly our $CH3      => 36;
Readonly our $H1       => 37;
Readonly our $T2       => 38;
Readonly our $H2       => 39;

# Default options
my $sides = 4;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my @count = (0) x $SQUARES;

my $current    = $GO;
my $double_run = 0;

foreach ( 1 .. 1e7 ) {    ## no critic (ProhibitMagicNumbers)
    my $die1 = int( rand $sides ) + 1;
    my $die2 = int( rand $sides ) + 1;
    if ( $die1 == $die2 ) {
        $double_run++;
    }
    else {
        $double_run = 0;
    }
    $current = ( $current + $die1 + $die2 ) % $SQUARES;

    if ( $double_run == 3 ) {    ## no critic (ProhibitMagicNumbers)
        $current    = $JAIL;
        $double_run = 0;
    }

    if ( $current == $G2J ) {
        $current = $JAIL;
    }

    if ( $current == $CC1 || $current == $CC2 || $current == $CC3 ) {
        $current = chance($current);
    }

    if ( $current == $CH1 || $current == $CH2 || $current == $CH3 ) {
        $current = chest($current);
    }

    $count[$current]++;
}

my @top =
  ( reverse sort { $count[$a] <=> $count[$b] } 0 .. $SQUARES - 1 )[ 0 .. 2 ];
printf "%02d%02d%02d\n", @top;

sub chance {
    my ($current) = @_;    ## no critic (ProhibitReusedNames)

    my $cc = int( rand $CC_CARDS ) + 1;
    $current =
        $cc == 1 ? $GO
      : $cc == 2 ? $JAIL
      :            $current
      ;

    return $current;
}

sub chest {                ## no critic (ProhibitExcessComplexity)
    my ($current) = @_;    ## no critic (ProhibitReusedNames)

    my $ch = int( rand $CH_CARDS ) + 1;
    ## no critic (ProhibitMagicNumbers)
    my $back3 = ( $current - 3 ) % $SQUARES;
    $current =
        $ch == 1                                     ? $GO
      : $ch == 2                                     ? $JAIL
      : $ch == 3                                     ? $C1
      : $ch == 4                                     ? $E3
      : $ch == 5                                     ? $H2
      : $ch == 6                                     ? $R1
      : ( $ch == 7 || $ch == 8 ) && $current == $CH1 ? $R2
      : ( $ch == 7 || $ch == 8 ) && $current == $CH2 ? $R3
      : ( $ch == 7 || $ch == 8 ) && $current == $CH3 ? $R1
      : $ch == 9 && $current == $CH1                 ? $U1
      : $ch == 9 && $current == $CH2                 ? $U2
      : $ch == 9 && $current == $CH3                 ? $U1
      : $ch == 10                                    ? $back3
      :                                                $current
      ;
    ## use critic

    return $current;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'sides=i' => \$sides,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

84.pl

Monopoly odds

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Monopoly odds". The problem is:
If, instead of using two 6-sided dice, two 4-sided dice are used, find the
six-digit modal string.

=head1 EXAMPLES

    perl 84.pl

=head1 USAGE

    84.pl
        [--sides INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--limit INT>

Number of die sides.

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
