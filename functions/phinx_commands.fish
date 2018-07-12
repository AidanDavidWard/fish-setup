function phinx
	vendor/bin/phinx $argv
end
function p
	phinx $argv
end
function pc
	p create $argv
end
function pm
	p migrate $argv
end
function pr
	p rollback $argv
end
function ps
	p status $argv
end
