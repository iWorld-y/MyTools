alias ll='ls -alFh'
alias lt='ll -t'
alias myact='mamba activate'

function mygit() {
    # 检查是否提供了提交信息
    if [ -z "$1" ]; then
        echo "Please provide a commit message."
        return 1
    fi

    # 获取最新代码并合并到本地仓库
    git pull origin main

    # 检查是否有未提交的更改
    if [[ -n $(git status -s) ]]; then
        # 如果有未提交的更改，则将它们添加到暂存区
        git add .
        # 提交更改并添加提交信息
        git commit -m "$1"
        # 推送更改到远程仓库
        git push origin main
    else
        # 如果没有未提交的更改，则显示提示信息
        echo "No changes to commit."
    fi
}

