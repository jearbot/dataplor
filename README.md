## DataPlor Note:

#### The routes they gave were not RESTful, so I translated them to RESTful routes. My thoughts behind this was that we have to recurse through to the root node at least once, therefore I can cut the recursion for at least one of the nodes since from the common ancestor the path to the root should be the same length. I am querying based off an indexed column so that it is more performant. For the birds endpoint, I kept track of which children I had looked at already so I wouldn't add duplicate ids to the list. 
