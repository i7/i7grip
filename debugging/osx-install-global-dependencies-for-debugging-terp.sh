#! /bin/bash

sudo port install libksba

curl https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer --output rvm-installer
./rvm-installer stable
alias less="tee"
source ~/.rvm/scripts/rvm
rvm install 1.9.3

sudo gem install yajl-ruby || gem install yajl-ruby
sudo gem install rake-compiler || gem install rake-compiler

git clone git://github.com/eventmachine/eventmachine.git
pushd eventmachine
rake
gem build eventmachine.gemspec
sudo gem install --local eventmachine || gem install --local eventmachine
popd
