function glog
    git log --graph --decorate --all $argv
end

function g
    git $argv
end

function tiga
    tig --all $argv
end

function tigs
    tig status $argv
end

function gl
    cd (ghq root)/(printf '%s\n' (ghq list) (various) | fzf)
end

function various
    cd (ghq root)
    ls -1d github.com/macinjoke/various/*/ | xargs -I{} bash -c "ls -1d {}*/ 2>/dev/null"
    cd - >/dev/null
end

function hb
    hub browse (ghq list | fzf | cut -d "/" -f 2,3)
end

function hn
    open https://github.com/new
end

function allstatus
    ls -1 $MACINJOKE | xargs -t -I{} git -C $MACINJOKE/{} status --short
end

function dotstatus
    cat $MACINJOKE/setting_files/dotfiles | xargs -t -I{} git -C (ghq root)/github.com/{} status --short
end

function alldrypull
    ls -1 $MACINJOKE | xargs -t -I{} git -C $MACINJOKE/{} pull --dry-run
end

function dotdrypull
    cat $MACINJOKE/setting_files/dotfiles | xargs -t -I{} git -C (ghq root)/github.com/{} pull --dry-run
end

function ghinit
    git init && git commit --allow-empty -m "first empty commit" && hub create && git push -u origin master && hub browse
end

function y
    yarn $argv
end

function C
    pbcopy $argv
end 

function N
    terminal-notifier -message "コマンド完了" -sound Glass -activate "com.googlecode.iterm2" $argv
end

# start ------------ peco utility --------------------------------------
function pecofind # find コマンドの出力結果をpeco する
    if test (count $argv) -eq 0
        find . | peco
    else
        find $argv[1] | peco
    end
end

function pecofindd # find コマンドの出力結果をpeco する。 ファイルが選ばれたら1つ手前のディレクトリを返す
    if test (count $argv) -eq 0
        set finded (find . | peco)
    else
        set finded (find $argv[1] | peco)
    end
    if test -f $finded
        echo $finded | string replace -r '\/[^\/]*$' ''
    else
        echo $finded
    end
end

function cdp
    set dir (pecofindd $argv[1])
    set_color brblue
    echo "cd $dir"
    cd $dir
end

function lsp
    set file (pecofind $argv[1])
    set_color brblue
    echo "ls $file"
    ls $file
end

function rmp
    set file (pecofind $argv[1])
    set_color brblue
    echo "rm $file"
    rm $file
end

function treep
    set file (pecofindd $argv[1])
    set_color brblue
    echo "tree $file"
    tree $file
end

function catp
    set file (pecofind $argv[1])
    set_color brblue
    echo "cat $file"
    cat $file
end

function vimp
    set file (pecofind $argv[1])
    set_color brblue
    echo "vim $file"
    vim $file
end
# end ------------ peco utility --------------------------------------

# start ------------ fzf utility --------------------------------------
function fzffind # find コマンドの出力結果をfzf する
    if test (count $argv) -eq 0
        find . | fzf
    else
        find $argv[1] | fzf
    end
end

function fzffindd # find コマンドの出力結果をfzf する。 ファイルが選ばれたら1つ手前のディレクトリを返す
    if test (count $argv) -eq 0
        set finded (find . | fzf)
    else
        set finded (find $argv[1] | fzf)
    end
    if test -f $finded
        echo $finded | string replace -r '\/[^\/]*$' ''
    else
        echo $finded
    end
end

function cdf
    set dir (fzffindd $argv[1])
    set_color brblue
    echo "cd $dir"
    cd $dir
end

function lsf
    set file (fzffind $argv[1])
    set_color brblue
    echo "ls $file"
    ls $file
end

function rmf
    set file (fzffind $argv[1])
    set_color brblue
    echo "rm $file"
    rm $file
end

function treef
    set file (fzffindd $argv[1])
    set_color brblue
    echo "tree $file"
    tree $file
end

function catf
    set file (fzffind $argv[1])
    set_color brblue
    echo "cat $file"
    cat $file
end

function vimf
    set file (fzffind $argv[1])
    set_color brblue
    echo "vim $file"
    vim $file
end
# end ------------ peco utility --------------------------------------
