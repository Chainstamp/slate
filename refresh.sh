curl --insecure https://localhost:8443/v2/api-docs  > source/chainstamp.json 
perl -pi -e 's/localhost/api\.chainstamp\.io/g' source/chainstamp.json
npx widdershins source/chainstamp.json -o source/chainstamp_api.html.md
bundle exec middleman build --clean

