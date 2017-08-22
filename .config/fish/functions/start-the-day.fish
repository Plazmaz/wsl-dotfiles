# Defined in - @ line 0
function start-the-day --description 'alias start-the-day git fetch origin +master:master +production:production +canary:canary; git stash -u; git checkout master; pip-sync dev-requirements.txt requirements.txt; yarn; pym migrate; git fetch --prune; git sb'
	git fetch origin +master:master +production:production +canary:canary; git stash -u; git checkout master; pip-sync dev-requirements.txt requirements.txt; yarn; pym migrate; git fetch --prune; git sb $argv;
end
