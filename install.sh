uri="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
plugLocation=".local/share/nvim/site/autoload/plug.vim"
os=$OSTYPE
echo $destination
if [[os == "linux"*]]; then
  destination="/Users/$USER/$plugLocation"
  $(curl -fLo $destination --create-dirs $uri)
elif [[os == "darwin"*]]; then
  destination="/home/$USER/$plugLocation"
  $(curl -fLo $destination --create-dirs $uri)
elif [[os == "win"*]]; then
  echo "Windows is not supported yet"
fi
