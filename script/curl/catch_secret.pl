use strict;
use warnings;
use LWP::UserAgent;

my $url = 'http://link.com/secret.txt';
my $ua  = LWP::UserAgent->new;

# 設定 timeout 與 UA
$ua->timeout(10);
$ua->agent("Mozilla/5.0 (Perl LWP)");

my $response = $ua->get($url);

if ($response->is_success) {
    print $response->decoded_content;
} else {
    die "HTTP GET error: " . $response->status_line;
}

# 使用方法：
#1 terminal輸入 sudo apt-get update && sudo apt-get install -y libwww-perl
#2 執行腳本 perl perl/script.pl