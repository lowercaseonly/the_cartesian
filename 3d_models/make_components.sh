for filename in components/*.scad; do
	echo "Creating STL for ${filename}..."
	openscad ${filename} -o ${filename:0:-4}STL
done

