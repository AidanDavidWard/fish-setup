#!/bin/bash

arraytest[0]='test' || (echo 'Error: Arrays are not supported in this version of
bash.' && exit 2)

# Detect the packager.
#if [ -x /usr/local/bin/brew ]; then
  #detectedpackager=homebrew
#elif command -v port >/dev/null; then
  #detectedpackager=macports
#else
  #detectedpackager=none
#fi

# Get the command line options
opt_nocolor=f
opt_force_color=f
opt_offline=f
for arg in "$@"
do
  case "${arg}" in
    -p|--packager)
      packager=$detectedpackager
      ;;
    -m|--macports)
      packager=macports
      ;;
    -b|--nocolor)
      opt_nocolor=t
      ;;
    -c|--color)
      opt_nocolor=f
      opt_force_color=t
      ;;
    -o|--offline)
        opt_offline=t
      ;;
    -h|--help)
      echo "Archey OS X 1.5.2"
      echo
      echo "Usage: $0 [options]"
      echo
      echo "  -p --packager  Use auto detected package system (default packager: ${detectedpackager})."
      echo "  -m --macports  Force use MacPorts as package system."
      echo "  -b --nocolor   Turn color off."
      echo "  -c --color     Force the color on (overrides --nocolor)."
      echo "  -o --offline Disable the IP address check."
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" 1>&2
      echo "For help, use: $0 --help" 1>&2
      exit 1
      ;;
  esac
done

# System Variables
user=$(whoami)
hostname=$(hostname | sed 's/.local//g')

# if [[ "${opt_offline}" = f ]]; then
#     ipfile="${HOME}/.archey-ip"
#     if [ -a "$ipfile" ] && test `find "$ipfile" -mmin -360`; then
#         while read -r line; do
#             ip="$line"
#         done < "$ipfile"
#     else
#         ip=$(dig +short myip.opendns.com @resolver1.opendns.com)
#         echo $ip > "$ipfile"
#     fi
# fi

distro="OS X $(sw_vers -productVersion)"
kernel=$(uname)
uptime=$(uptime | sed 's/.*up \([^,]*\), .*/\1/')
shell="$SHELL"
terminal="$TERM ${TERM_PROGRAM//_/ }"
cpu=$(sysctl -n machdep.cpu.brand_string)
battery=$(pmset -g batt | xargs | egrep "\d+%" -o)
cpu=$(echo "$cpu" | awk '$1=$1' | sed 's/([A-Z]\{1,2\})//g')
ram="$(( $(sysctl -n hw.memsize) / 1024 ** 3  )) GB"
disk=$(df | head -2 | tail -1 | awk '{print $5}')
fish=$(fish -v | awk '$1=$1' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
ruby=$(ruby -v | awk '$1=$1' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')
rails=$(rails -v | awk '$1=$1' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/')


# Set up colors if:
# * stdout is a tty
# * the user hasn't turned it off
# * or if we're forcing color
if [[ ( -t 1  && "${opt_nocolor}" = f) || "${opt_force_color}" = t ]]
then
  RED=$(tput       setaf 1 2>/dev/null)
  GREEN=$(tput     setaf 2 2>/dev/null)
  YELLOW=$(tput    setaf 3 2>/dev/null)
  BLUE=$(tput      setaf 4 2>/dev/null)
  PURPLE=$(tput    setaf 5 2>/dev/null)
  textColor=$(tput setaf 6 2>/dev/null)
  normal=$(tput    sgr0 2>/dev/null)
fi

fieldlist[${#fieldlist[@]}]="${textColor}User:${normal} ${user}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Hostname:${normal} ${hostname}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Distro:${normal} ${distro}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Kernel:${normal} ${kernel}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Uptime:${normal} ${uptime}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Shell:${normal} ${shell}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Terminal:${normal} ${terminal}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Terminal Size:${normal} $(tput lines) x $(tput cols)"
fieldlist[${#fieldlist[@]}]="${textColor}CPU:${normal} ${cpu}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Memory:${normal} ${ram}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Disk:${normal} ${disk}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Battery:${normal} ${battery}${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Date:${normal} $(date)${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Fish:${normal} $fish${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Ruby:${normal} $ruby${normal}"
fieldlist[${#fieldlist[@]}]="${textColor}Rails:${normal} $rails${normal}"

for i in "${fieldlist[@]}"
do
  echo "$i"
done
