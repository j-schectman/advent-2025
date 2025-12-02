USING: io io.files kernel math math.parser sequences ;
IN: 1-day

: get-turn-amount ( line -- number )
    ! Only last 2 numbers matter, 100 == complete rotation, back
    ! at start
    dup length 2 > [ 2 tail* ] [ 1 tail* ] if
    string>number 
    ;

: parse-direction ( line -- number ) 
    [ get-turn-amount ] [ 1 head ]  bi
    "L" = [ -1 ] [ 1 ] if
    *
    ;

: turn ( index move -- new-index )
    +
        dup 0 < [ 100 + ] when
        dup 99 > [ 100 - ] when
    ;

: solve ( -- )
    "./input.txt" utf8 file-lines 50 [
        parse-direction
        turn
    ] accumulate
    swap suffix
    [ 0 = ] count .

    ;

MAIN: solve
