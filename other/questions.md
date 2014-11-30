* no of men/women in preference list
  * n -> existing gale-shapley algorithm
  * const, <n -> modify existing algorithm
  * varying -> modify existing algorithm
* how to find elements in preference list
  * random permutation of all n men
  * plane algorithm with visibility radius
    * size [0,1]x[0,1]
    * torus
    * radius (constant, depending on n, increasing)
  * how to determine preference order in visibility field
    * random
    * node has attractivity, e.g. value in [0,1]
    * matching index, node prefers other nodes with index close to its own
* preference changes
  * random changes
    * frequency?
    * just switch two nodes, or more
    * how far away can nodes be to be switched?
  * move nodes in plane and recalculate preferences
* what to do when preference list is empty?
  * random partner
  * no partner
* what to to if someone unknown proposes?
  * decline
  * accept with probability p
  * use match index and compare it to known nodes
* relevant input parameters
  * input size n
  * visibility radius
  * frequency of preference changes
* relevant output data
  * no of unstable couples
  * no of nodes having no partner
  * no of partners that were dumped during the process
  * optimality index: sum over all ranks of actual partners
