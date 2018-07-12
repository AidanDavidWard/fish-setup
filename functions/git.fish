function g
	git $argv
end
function gl
	g log $argv
end
function gs
	g stash $argv
end
function ga
	g add $argv
end
function gb
	g branch $argv
end
function gbd
	gb -D $argv
end
function gbda
	gb --merged | grep -v \* | xargs gbd
end
function gbda
	gb | grep -v master | xargs git branch -D
end
function gc
	g commit --verbose $argv
end
function gca
	gc --all
end
function gco
	g checkout $argv
end
function gd
	g diff $argv
end
function gpl
	g pull $argv
end
function gpp
	gpl
gpu
end
function gpu
	g push $argv
end
function gsp
	gs pop $argv
end
function gst
	g status $argv
end
function gcp
	g cherry-pick $argv
end
