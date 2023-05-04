# fgColor(): 获取前景色代码
fgColor() {
    case "$1" in
        # 黑色
        black)      echo "30";;
        # 红色
        red)        echo "31";;
        # 绿色
        green)      echo "32";;
        # 黄色
        yellow)     echo "33";;
        # 蓝色
        blue)       echo "34";;
        # 洋红色
        magenta)    echo "35";;
        # 青色
        cyan)       echo "36";;
        # 白色
        white)      echo "37";;
        # 浅黑色
        lightBlack) echo "90";;
        # 浅红色
        lightRed)   echo "91";;
        # 浅绿色
        lightGreen) echo "92";;
        # 浅黄色
        lightYellow)echo "93";;
        # 浅蓝色
        lightBlue)  echo "94";;
        # 浅洋红色
        lightMagenta)echo "95";;
        # 浅青色
        lightCyan)  echo "96";;
        # 浅白色
        lightWhite) echo "97";;
        # 橙色
        orange)     echo "38;5;166";;
        # 其他颜色
        *)          echo $1;;
    esac
}

# bgColor(): 获取背景色代码
bgColor() {
    case "$1" in
        # 黑色
        black)      echo "40";;
        # 红色
        red)        echo "41";;
        # 绿色
        green)      echo "42";;
        # 黄色
        yellow)     echo "43";;
        # 蓝色
        blue)       echo "44";;
        # 洋红色
        magenta)    echo "45";;
        # 青色
        cyan)       echo "46";;
        # 白色
        white)      echo "47";;
        # 橙色
        orange)     echo "48;5;166";;
        # 浅黑色
        lightBlack) echo "100";;
        # 浅红色
        lightRed)   echo "101";;
        # 浅绿色
        lightGreen) echo "102";;
        # 浅黄色
        lightYellow)echo "103";;
        # 浅蓝色
        lightBlue)  echo "104";;
        # 浅洋红色
        lightMagenta)echo "105";;
        # 浅青色
        lightCyan)  echo "106";;
        # 浅白色
        lightWhite) echo "107";;
        # 其他颜色
        *)          echo $1;;
    esac
}

# textEffect(): 获取文本效果代码
textEffect() {
    case "$1" in
        # 重置所有效果
        reset)      echo "0";;
        # 粗体
        bold)       echo "1";;
        # 弱粗体
        weak)       echo "2";;
        # 斜体
        italic)     echo "3";;
        # 下划线
        underline)  echo "4";;
        # 闪烁
        blink)      echo "5";;
        # 快速闪烁
        quickBlink) echo "6";;
        # 颜色反转
        reverse)    echo "7";;
        # 隐藏文本
        hide)       echo "8";;
        # 删除线
        del)        echo "9";;
        # 其他效果
        *)          echo $1;;
    esac
}

# color(): 获取颜色代码
color() {
    local font=$(textEffect $1)
    local fg=$(fgColor $2)
    local bg=$(bgColor $3)
    local code="$font;$fg;$bg"  # 组合效果、前景色和背景色
    local text="$4"
    echo "\\[\e[${code}m\\]${text}\\[\e[0m\\]"  # 输出含颜色的文本
}

# 定义颜色前缀
prefixOk="$(color bold green "" \$)"  # 绿色 "✔" 符号
prefixFail="$(color bold red "" \$)"  # 红色 "✖" 符号

# 定义时间、主机名、用户名和当前目录的颜色
tm="$(color "" lightMagenta "" \\t)"   # 浅洋红色的时间戳
host="$(color "" lightCyan "" \\H)"    # 浅青色的主机名
user="$(color "" yellow "" \\u)"       # 黄色的用户名
dir="$(color "" cyan "" \\w)"          # 青色的当前目录路径

# 获取 Git 分支并设置颜色
git='$(branch=$(git status 2>/dev/null | head -n 1 | cut -d " " -f 3 2>/dev/null);if [[ -n ${branch} ]]; then echo -ne "@\[\e[1;91m\]${branch}\[\e[0m\]";fi)'

# 组合成最终的命令行提示符格式
P="${prefix} ${tm} ${user}@${host}:${dir}${git} $(color bold white "" \>) "

# 导出为 PS1 环境变量，使其生效
export PS1=$P
bind "set completion-ignore-case on"
