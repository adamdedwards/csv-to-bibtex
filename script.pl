#!/usr/bin/perl
use warnings;
use strict;

use Text::CSV;
my $csv = Text::CSV->new({ sep_char => ',' });

my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
open (my $data, "<", $file) or die "Could not open '$file' $!\n";
open (BIB,">","example.bib") or die $!;

my $headers = <$data>;
$csv->parse($headers);
my @hr = $csv->fields();

while (my $line = <$data>) {
  chomp $line;
  print $line."\n";

  if ($csv->parse($line)) {
    my @fields = $csv->fields();

    my @author_names = split(/\s|,/,$fields[2]);
    my $first_author = $author_names[0];
    my $bib_id = $first_author.$fields[3];

    print $bib_id."\n";

    print BIB "@".$fields[1]."{".$bib_id."\n\t".$hr[0]." = {".$fields[0]."},\n\t"
    .$hr[2]." = {".$fields[2]."},\n\t"
    .$hr[3]." = {".$fields[3]."},\n\t"
    .$hr[4]." = {".$fields[4]."},\n\t"
    .$hr[5]." = {".$fields[5]."},\n\t"
    .$hr[6]." = {".$fields[6]."},\n\t"
    .$hr[7]." = {".$fields[7]."}\n"
    ."}\n\n";

  }
}
