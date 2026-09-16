#!/bin/bash
# Shifts all crossing_time timestamps in sample_analytics.sql so the newest one equals now.

SQL_FILE="$(dirname "$0")/timescaledb-data/sample_analytics.sql"

if [ ! -f "$SQL_FILE" ]; then
  echo "File not found: $SQL_FILE"
  exit 1
fi

PERL_TMP=$(mktemp /tmp/shift_ts_XXXXXX.pl)

cat > "$PERL_TMP" <<'PERLEOF'
use Time::Local qw(timegm);

my $file = $ARGV[0];

open(my $fh, '<', $file) or die "Cannot open $file: $!";
my @lines = <$fh>;
close($fh);

# Find the newest timestamp (stored as UTC with +00)
my $newest_epoch = 0;
for my $line (@lines) {
    while ($line =~ /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})(\.\d+)?\+00/) {
        my $epoch = timegm($6,$5,$4,$3,$2-1,$1-1900);
        $newest_epoch = $epoch if $epoch > $newest_epoch;
        last;
    }
}

my $now = time();
my $offset = $now - $newest_epoch;
print "Offset: $offset seconds\n";

for my $line (@lines) {
    while ($line =~ /(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})(\.\d+)?\+00/) {
        my ($dt, $frac) = ($1, defined $2 ? $2 : "");
        my ($y,$mo,$d,$h,$mi,$s) = ($dt =~ /(\d+)-(\d+)-(\d+) (\d+):(\d+):(\d+)/);
        my $epoch = timegm($s,$mi,$h,$d,$mo-1,$y-1900) + $offset;
        my @t = localtime($epoch);
        my $new = sprintf("%04d-%02d-%02d %02d:%02d:%02d%s", $t[5]+1900,$t[4]+1,$t[3],$t[2],$t[1],$t[0],$frac);
        $line =~ s/\Q$dt\E\Q$frac\E\+00/$new/;
        last;
    }
}

open(my $out, '>', $file) or die "Cannot write $file: $!";
print $out @lines;
close($out);
PERLEOF

perl "$PERL_TMP" "$SQL_FILE"
rm -f "$PERL_TMP"

echo "Done."
