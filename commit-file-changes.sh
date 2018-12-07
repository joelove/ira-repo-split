git remote remove origin
git remote add origin git@gitlab.internal.iraservices.io:ira/employee-portal.git
git add --all
git commit -m "Repo split"
git push --set-upstream origin development
