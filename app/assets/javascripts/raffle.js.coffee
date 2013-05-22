@RaffleCtrl = ($scope) ->
	$scope.entries = [
		{name: "Larry"}
		{name: "Curly"}
		{name: "Moe"}
	]

	$scope.addEntry = ->
		$scope.entries.push($scope.newEntry)
		$scope.newEntry = {}

	$scope.drawWinner = ->
		pool = []
		angular.forEach $scope.entries, (entry) ->
	    	pool.push(entry) if !entry.winner
	    if pool.length > 0
	    	entry = pool[Math.floor(Math.random()*pool.length)]
	    	entry.winner = true
	    	$scope.lastWinner = entry