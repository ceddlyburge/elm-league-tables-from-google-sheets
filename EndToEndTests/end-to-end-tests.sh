err=0
trap 'err=1' ERR

elm-spec ResultsAndFixtures.elm
elm-spec LeagueWithDataEntryIssues.elm
elm-spec LeagueList.elm
elm-spec LeagueWithOneUnplayedGame.elm
elm-spec LeagueWithOneGame.elm

test $err = 0 # Return non-zero if any command failed