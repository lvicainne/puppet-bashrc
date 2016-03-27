# THIS FILE IS MANAGED BY PUPPET
# <%= file %>

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#Machine specific aliases
<% @aliases.each do |myalias| -%>
alias <%= myalias %>
<% end -%>

