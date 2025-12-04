USING: io io.files kernel math math.parser sequences ;
IN: 3-day

TUPLE: walker arr index acc ;
C: <walker>  walker

: get-end ( walk -- rez )
    [ arr>> length ] [ acc>> length 11 swap - ] bi -
    ;

: check-bigger ( arr -- bool ) 
    ! is new number bigger
     [ second ] [ first first ] bi 
    >
    ;

: get-red ( arr elt index -- tup )
    [ string>number ] dip
    3array dup
    check-bigger
     [ [ second ] [ third ] bi 2array ] [ first ]  if
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
    dup index>> 1 + rot + >>index
    dup acc>> length 12 = [ ] [ do-thing ] if
    ;

: solve ( -- )
    "./input.txt" utf8 file-lines [
        [ 1string ] { } map-as 
        0 { } <walker> do-thing
    ] map
    ! [ [ acc>> ] [ index>> ] bi 2array ] map .
    [ acc>> [ number>string ] map "" join string>number ] map
    sum .
    ;

MAIN: solve

