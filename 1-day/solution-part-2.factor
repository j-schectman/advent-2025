USING: io io.files kernel math math.parser sequences accessors ;
IN: 1-day

TUPLE: dial revolutions resting ;
C: <dial> dial
: get-turn-amount ( line -- number )
    ! Only last 2 numbers matter, 100 == complete rotation, back
    ! at start
    dup length 2 > [ 2 tail* ] [ 1 tail* ] if
    string>number 
    ;

: total-turns ( line -- number )
    1 tail string>number 100 /i
    ;

: parse-direction ( line -- turns ) 
    [ get-turn-amount ] [ 1 head ]  bi
    "L" = [ -1 ] [ 1 ] if
    *
    ;

: moves-past ( index move -- num )
    swap dup
    0 = [ 2drop 0 ] 
    [ 
        +
        { [ 0 < ] [ 100 > ] } 1|| [ 1 ] [ 0 ] if 
    ] 
        if
    ;

: turn ( index move -- new-index )
    +
        dup 0 < [ 100 + ] when
        dup 99 > [ 100 - ] when
    ;

: solve ( -- )
    "./input.txt" utf8 file-lines  
    0 50 <dial>
    [
        [ parse-direction ] [ total-turns ] bi
        rot
        resting>>
        rot
        [ moves-past ] [ turn ]  2bi
        rot rot
        + swap
        <dial>
    ] 
     accumulate
     swap suffix
    [
        [ revolutions>> ] [ resting>> ] bi
        0 = [ 1 ] [ 0 ] if
        +
    ] map
    sum
    .
    ;

MAIN: solve
