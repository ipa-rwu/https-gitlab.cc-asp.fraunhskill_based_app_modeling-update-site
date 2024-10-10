#!/bin/bash

# Directory where feature files are located
FEATURE_DIR="features"

# Check if features directory exists
if [ ! -d "$FEATURE_DIR" ]; then
    echo "Directory $FEATURE_DIR does not exist."
    exit 1
fi

# Start creating the site.xml file
echo '<?xml version="1.0" encoding="UTF-8"?>' >site.xml
echo '<site>' >>site.xml

# Loop through all jar files in the features folder
for jar_file in "$FEATURE_DIR"/*.jar; do
    if [[ -f $jar_file ]]; then
        # Extract the base filename (without path)
        base_file=$(basename "$jar_file")

        # Extract ID and version from the file name (assuming the pattern is consistent)
        # Example filename: de.fraunhofer.ipa.ros.feature_3.0.0.202410102339.jar
        id=$(echo "$base_file" | cut -d'_' -f1)
        version=$(echo "$base_file" | cut -d'_' -f2 | sed 's/.jar//')

        # Write the feature entry to site.xml
        echo "   <feature url=\"features/$base_file\" id=\"$id\" version=\"$version\"/>" >>site.xml
    fi
done

# Close the site.xml structure
echo '</site>' >>site.xml

echo "site.xml generated successfully."
