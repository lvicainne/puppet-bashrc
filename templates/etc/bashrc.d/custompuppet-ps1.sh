# THIS FILE IS MANAGED BY PUPPET
# <%= file %>

#if [ -z "$SSH_TTY" ]; then
    #Compute DNS extension
    DOMDNS=$(grep "^search " /etc/resolv.conf | cut -d" " -f2)
#fi



# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

#Customize PS1 with http://bashrcgenerator.com/
if [ "$color_prompt" = yes ]; then

    if [ "$TERM" = "screen" ]; then
        export PS1="<%= @ps1_screen %>"
    else
        export PS1="<%= @ps1_colored %>"
        #export PS1=${VERT}'\u@\h.'${DOMDNS}${BLANC}':'${BLEU}'\w'${BLANC}'\n\$ '
    fi

else
    #There is no color available
    PS1="<%= @ps1_default %>"
fi
unset color_prompt force_color_prompt
