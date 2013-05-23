app = angular.module("Raffler", ["ngResource"])

app.factory "Entry", ["$resource", ($resource) ->
	$resource("entries/:id", {id: "@id"}, {update: {method: "PUT"}})
]

@RaffleCtrl = ["$scope", "Entry", ($scope, Entry) ->
	$scope.entries = Entry.query()

	$scope.addEntry = ->
		entry = Entry.save($scope.newEntry)
		$scope.entries.push(entry)
		$scope.newEntry = {}

	$scope.drawWinner = ->
		pool = []
		angular.forEach $scope.entries, (entry) ->
	    	pool.push(entry) if !entry.winner
	    if pool.length > 0
	    	entry = pool[Math.floor(Math.random()*pool.length)]
	    	entry.winner = true
	    	entry.$update()
	    	$scope.lastWinner = entry
	    	console.log("Winner is " + entry.name)

	$scope.resetWinners = ->
		angular.forEach $scope.entries, (entry) ->
			entry.winner = false
			entry.$update()
		console.log("Winners Reset")

	$scope.clearEntries = ->
		angular.forEach $scope.entries, (entry) ->
			entry.$remove()
		$scope.entries = []
		console.log("Entries Cleared")

	$scope.deleteEntry = (idx) ->
		$scope.entries[idx].$remove()
		$scope.entries.splice( idx, 1 );
		console.log("Entry Deleted")
		
]