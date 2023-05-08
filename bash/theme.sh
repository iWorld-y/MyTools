fg_color() {
    case "$1" in
        black)          echo 30;;
        red)            echo 31;;
        green)          echo 32;;
        yellow)         echo 33;;
        blue)           echo 34;;
        magenta)        echo 35;;
        cyan)           echo 36;;
        white)          echo 37;;
        lightBlack)     echo 90;;
        lightRed)       echo 91;;
        lightGreen)     echo 92;;
        lightYellow)    echo 93;;
        lightBlue)      echo 94;;
        lightMagenta)   echo 95;;
        lightCyan)      echo 96;;
        lightWhite)     echo 97;;
        orange)         echo 38\;5\;166;;
        *)              echo $1;;
    esac
}

bg_color() {
    case "$1" in
        black)          echo 40;;
        red)            echo 41;;
        green)          echo 42;;
        yellow)         echo 43;;
        blue)           echo 44;;
        magenta)        echo 45;;
        cyan)           echo 46;;
        white)          echo 47;;
        orange)         echo 48\;5\;166;;
        lightBlack)     echo 100;;
        lightRed)       echo 101;;
        lightGreen)     echo 102;;
        lightYellow)    echo 103;;
        lightBlue)      echo 104;;
        lightMagenta)   echo 105;;
        lightCyan)      echo 106;;
        lightWhite)     echo 107;;
        *)              echo $1;;
    esac;
}

text_effect() {
    case "$1" in
        reset)      echo 0;;
        bold)       echo 1;;
        weak)       echo 2;;
        italic)     echo 3;;
        underline)  echo 4;;
        blink)      echo 5;;
        quickBlink) echo 6;;
        reverse)    echo 7;;
        hide)       echo 8;;
        del)        echo 9;;
        *)          echo $1
    esac
}

color() {
    font=$(text_effect $1)
    fg=$(fg_color $2)
    bg=$(bg_color $3)

    code=""
    first=0
    for c in $font $fg $bg
    do
        if [[ $c -ne "" ]]; then
            if [[ $first -ne 0 ]]; then
                code+=";"
            fi
            code+="$c"
            first=1
        fi
    done


    text=$4

    echo "\[\e[${code}m\]${text}\[\e[0m\]"
}


# export PS1='`a=$?; if [ $a -eq 0 ]; then echo -ne "\[\e[32;1m\]\$\[\e[0m\]"; else echo -ne "\[\e[31;1m\]\$\[\e[0m\]"; fi` \[\e[35;1m\]\t\[\e[0m\] \[\e[1;41m\]▶\[\e[0m\] \[\e[1;41m\]\u@\H:\w\[\e[0m\]  \[\e[1;41m\]▶\[\e[0m\]\$?'

prefix_ok="$(color bold green "" \$)"
prefix_fail="$(color bold red "" \$)"

prefix='$(if [ $? -eq 0 ]; then echo -ne '"\"${prefix_ok}\""'; else echo -ne '"\"${prefix_fail}\""'; fi)'
tm="$(color "" lightMagenta "" \\t)"
host="$(color "" lightCyan "" \\H)"
user="$(color "" yellow "" \\u)"
dir="$(color "" cyan "" \\w)"

git='$(branch=$(git status 2>/dev/null | head -n 1 | cut -d " " -f 3 2>/dev/null);if [[ -n ${branch} ]]; then echo -ne "@\[\e[1;91m\]${branch}\[\e[0m\]";fi)'

P="${prefix} ${tm} ${user}@${host}:${dir}${git} $(color bold white "" \>) "

export PS1=$P
bind "set completion-ignore-case on"
