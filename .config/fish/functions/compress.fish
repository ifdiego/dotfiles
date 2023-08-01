function compress --description "compress a video using ffmpeg"
    ffmpeg -i $argv -vcodec libx265 -crf 28 compressed_$argv
end
