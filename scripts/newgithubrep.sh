#! /bin/sh

repoName=$1

while [ -z "$repoName" ]
do 
	echo 'Provide a repo name'
	read -r -p $'Repository name:' repoName
done

echo "# $repoName" >> README.md
git init
git add .
git commit -m 'initial commit'

curl -u forrestberry https://api.github.com/user/repos -d '{"name":"'"$repoName"'", "private":true}'

git remote add origin https://github.com/forrestberry/${repoName}.git
git push -u origin main
