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
    cd (ghq root)/(printf '%s\n' (ghq list) (various) | peco)
end

function various
    cd (ghq root)
    ls -1d github.com/macinjoke/various/*/ | xargs -I{} bash -c "ls -1d {}*/ 2>/dev/null"
    cd - >/dev/null
end

function hb
    hub browse (ghq list | peco | cut -d "/" -f 2,3)
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
