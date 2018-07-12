elms-spec seems to be best at testing components through the UI, it doesn't seem to be that good at testing the entire app.

I think that the init function used with elm-spec must be `() -> Model`, which means that we probably can't test our actual init functions. There is an un merged pull request that addresses this.

If elm-spec can't find a file it will just say that no tests were run (instead of saying it couldn't find the file).

