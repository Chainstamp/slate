curl --insecure https://localhost:8443/v2/api-docs  > source/chainstamp_api.json 
perl -pi -e 's/localhost/api\.chainstamp\.io/g' source/chainstamp_api.json
npx widdershins source/chainstamp_api.json -o source/index.html.md
bundle exec middleman build --clean

