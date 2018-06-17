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
<%   if myalias.is_a?(Hash) -%>
<%     if myalias['value'] == nil -%>
unalias <%= myalias['name'] %>
<%     else -%>
alias <%= myalias['name'] %>='<%= myalias['value'] %>'
<%     end -%>
<%   else -%>
alias <%= name %>
<%   end -%>
<% end -%>

