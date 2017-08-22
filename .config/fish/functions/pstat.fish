# Defined in - @ line 0
function pstat --description 'alias pstat netstat -plten'
	netstat -plten $argv;
end
