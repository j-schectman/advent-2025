USING: io io.files kernel math math.parser sequences ;
IN: 3-day

TUPLE: walker arr index acc ;
C: <walker>  walker

: get-end ( walk -- rez )
    [ arr>> length ] [ acc>> length 12 swap - ] bi -
    ;

: get-red ( arr elt index -- tup )
    [ string>number ] dip
    3array dup
    [ first first dup . ] [ second dup . ] bi
    > [ [ second ] [ third ] bi 2array ] [ first ]  if
    ;
    
: add-acc-val ( walk new-val -- walk )
    swap dup acc>> rot suffix >>acc 
    ;

: do-thing ( walk -- rez )
    dup [ index>> ] [ get-end ] [ arr>> ] tri subseq
    { } [ 
        rot dup length 0 = [ 
            drop [ string>number ] dip 2array 
        ] 
        [ rot rot get-red ] if
    ] reduce-index
    [ first ] [ second ] bi -rot
    add-acc-val
    swap 1 + >>index
    ;

: solve ( -- )
    "./example.txt" utf8 file-lines [
        [ 1string ] { } map-as 
        0 { } <walker> do-thing dup .
    ] map
    drop
    ;

MAIN: solve

