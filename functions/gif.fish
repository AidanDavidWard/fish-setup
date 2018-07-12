function gif_d
	gif_download $argv[1] $argv[2]
end
function gif_download
	curl -o ~/gifs/$argv[1] -k $argv[2]
end
