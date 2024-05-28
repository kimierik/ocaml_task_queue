# task pool queue in ocaml

a demo for solving many tasks that are in a queue in paralell.  

in bin/main.ml you can change these variables.
```ocaml
let array_size = 50;;

let num=45;;

let num_of_domains=10;;
```
In this demo we have a list of len {array_size} filled with int {num}, then it runs a function that calculates the fibbonachi sequence of every number in the array.
{num_of_domains} means how many domains (os threads) that start executing a fibonachi sequence on the {num}.  
Make sure that you have more cores in your system than {num_of_domains}.
  
  
you migth need to run this if there are build errors
```sh
opam install domainslib
```


To time the execution of this demo run
```sh
time dune exec task_pool_demo
```
