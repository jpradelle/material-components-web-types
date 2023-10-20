#!/bin/bash

cssBuild=""
mdCssValues=$(grep -rhE "^(\| )?\`\-\-.*\|.*\|" --include="README.md" ../material-web/)
IFS=$'\n'
for cssValue in $mdCssValues
do
  #echo "$cssValue"
  parsed=$(
    echo "$cssValue" \
        | sed -E 's/  / /g' \
        | sed -E 's/!\[\]\(images\/color_([0-9a-f]{6,8}|([0-9]{1,3},){2,3}[0-9]{1,3})\.png\) //g' \
        | sed -E 's/((^\| )?`)(--[^`]+)` *\| ([^\|]*) *\| (.*)/\3\n\4\n\5/'
  )
  if [[ $(echo "$parsed" | wc -l) == 3 ]]
  then
    name=$(echo "$parsed" | head -n 1)
    value=$(echo "$parsed" | head -n 2 | tail -n 1 | sed -E 's/ *$//' | sed -E 's/`//g')
    description=$(echo "$parsed" | tail -n 1)
    echo "$name ; $value ; $description"
    join=""
    if [[ "$cssBuild" != "" ]]
    then
      join=","
    fi
    entry=$(jq -n --arg name "$name" --arg value "$value" --arg description "$description" '{name: $name, description: $description}')
    cssBuild="$cssBuild$join$entry"
  else
    echo "Not parsed value $cssValue"
  fi
done

json=$(cat <<-__EOF
{
  "\$schema": "http://json.schemastore.org/web-types",
  "name": "material-components-css-web-types",
  "version": "0.0.0",
  "default-icon": "icon/material.png",
  "description-markup": "markdown",
  "contributions": {
    "css": {
      "properties": [$cssBuild]
    }
  }
}
__EOF
)
echo "$json" | jq > ../src/gen/material-components-gen-css-web-types.json
