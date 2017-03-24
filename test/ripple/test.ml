let suites :  Bs_mocha.pair_suites ref  = ref []

let test_id = ref 0

let eq loc (x, y) =
  incr test_id ;
  suites :=
    (loc ^" id " ^ (string_of_int !test_id), (fun () -> Bs_mocha.Eq(x,y))) :: !suites

let ()  =
  begin
    eq __LOC__ ("hello", "hello")
  end


let () =
  Bs_mocha.from_pair_suites __FILE__ !suites
