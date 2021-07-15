function notify_nvmrc --on-variable="PWD"
  set -l nvmrc_path (nvm_find_nvmrc)
  if test -n "$nvmrc_path"
    echo "this directory use .nvmrc:"
    cat "$nvmrc_path"
    echo "nvm current version:"
    nvm current
  end
end
