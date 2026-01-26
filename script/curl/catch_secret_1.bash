# 暴力提取

perl -MLWP::UserAgent -e '$ua=LWP::UserAgent->new; $ua->agent("Mozilla/5.0"); print $ua->get("http://link.com/secret_base64.txt")->decoded_content'
