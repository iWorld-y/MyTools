alias ll='ls -alFh'
alias lt='ll -t'
alias myact='mamba activate'

function mygit() {
    if [ -z "$1" ]; then
        echo "Please provide a commit message."
        return 1
    fi

    git pull origin main

    if [[ -n $(git status -s) ]]; then
        git add .
        git commit -m "$1"
        git push origin main
    else
        echo "No changes to commit."
    fi
}
