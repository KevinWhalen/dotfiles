# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

alias calendar='calcurse'
alias generate-pass="openssl rand -base64 48 | sed -e 's/[^A-Za-z0-9]//g'"
alias git-log-search='git log -i --perl-regexp --grep'
alias show-ports='sudo netstat -tulpn | grep "LISTEN"'

function files_with()
{
	[[ "$#" -lt 2 && "$#" -gt 0 ]] || { echo "1 argument required, $# provided."; return 1; }
	pattern=$1
	grep -iHnrP "${pattern}" . | \
		grep -vP "^(Binary file)" | \
		awk '{ print $1; }' | \
		perl -p -e 's/:\d+:.*//' | \
		uniq
}
alias files-with='files_with'

function docker_rm() {
	[[ "$#" -lt 2 && "$#" -gt 0 ]] || { echo "1 argument required, $# provided."; return 1; }
	docker stop $1 && docker wait $1 && docker rm $1
}
alias docker-rm="docker_rm"

alias docker-bridge-cidr='docker network inspect bridge --format "{{ (index .IPAM.Config 0).Subnet }}"'

alias run='docker container run --rm --interactive --tty'
alias run-device='docker container run --rm --interactive --tty --privileged --device /dev/dri:/dev/dri'
alias build='docker image build'
alias compose='docker-compose'
alias compose-project='docker-compose --project-directory'
