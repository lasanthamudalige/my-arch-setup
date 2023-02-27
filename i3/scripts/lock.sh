img=/tmp/i3lock.png

# Get a screenshot and save it image location
scrot -o $img
# Scale the image
convert $img -scale 10% -scale 1000% $img

# pass image as -i and -f to show times password was wrong  
i3lock -i $img -f
