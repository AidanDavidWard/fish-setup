function d
	docker $argv
end
function d_ent_exec
	d exec -it enterprise_php_1 bash
end
function d_hyp_exec
	d exec -it hyperion_php_1 bash
end
function dc-node-grunt
	docker-compose run node grunt
end
function dng
	dc-node-grunt
end
function spd
	./stop.sh
end
function std
	./start.sh
end
function dc
	docker-compose $argv
end
function dcb
	dc build $argv
end
function dcd
	dc down $argv
end
function dcu
	dc up $argv
end
