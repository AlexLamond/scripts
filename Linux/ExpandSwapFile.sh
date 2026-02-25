# This will get the swap location, you must replace `/swapfile` with whatever is output here
swapon -s
sudo swapoff /swapfile
sudo fallocate -l 2G /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
free -h
