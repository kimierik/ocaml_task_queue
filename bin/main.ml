


let array_size = 50;;

let num=45;;

let num_of_domains=10;;


let main()= 
    
    let que = ref (Array.make array_size num)   in
    let queue_mutex = Mutex.create() in

    let result_array = ref (Array.make array_size 0)   in
    let result_mutex = Mutex.create() in


    let index_mutex= Mutex.create() in
    let current_index = ref 0 in



    let solve_queue ()= 

        let rec fib i = 
            match i with 
            | x when x < 3 -> 1
            | x when x > 0 -> (fib (x-1) + fib (x-2))
            | _ -> raise ( Invalid_argument "fibonachi invalid arg")
        in


        let rec loop()=
            Mutex.lock index_mutex;

            match !current_index with
            | n when n >= (Array.length !que) -> Mutex.unlock index_mutex;()
            | _ ->

            let index= !current_index in


            Mutex.lock queue_mutex;

            let item = Array.get !que !current_index in
            current_index:=!current_index + 1;

            Mutex.unlock index_mutex;
            Mutex.unlock queue_mutex;

            let res = fib item in

            Mutex.lock result_mutex;
            Array.set !result_array index res;
            Mutex.unlock result_mutex;

            loop();
        in
        loop()
    in



    let rec make_domain_list n = 
        match n with 
        | 0-> []
        | _ -> Domain.spawn solve_queue :: make_domain_list (n-1)  
    in


    let dlist = make_domain_list num_of_domains in


    (*wait for all threads to finnish*)
    for i=0 to (List.length dlist)-1 do
        Domain.join (List.nth dlist i)
    done;
    
    
    (*print all fib numbers*)
    for i=0 to (Array.length !result_array) -1 do 
        Printf.printf "%i:%i\n" i (Array.get !result_array i);
    done






let ()=main();
