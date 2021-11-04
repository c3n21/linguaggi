module Coda :
    sig
        type coda 
        val empty: coda
        val push: int -> coda -> coda
        val pop: coda -> coda
        val length: coda -> int
        val top: coda -> int
    end
