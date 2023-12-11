ZSHHOME="${HOME}/.zsh.d"

if [ -d $ZSHHOME ] && [ -r $ZSHHOME ] && [ -x $ZSHHOME ]; then
    for file in $ZSHHOME/**/*.zsh(D); do
        [ -r $file ] && source $file
    done
fi

# Created by `pipx` on 2023-12-11 04:44:01
export PATH="$PATH:/home/mtaku3/.local/bin"
