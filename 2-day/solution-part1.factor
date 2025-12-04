USING: io splitting math.parser sequences kernel math sets
splitting io.encodings.utf8 io.files prettyprint ;
IN: 2-day

: get-ranges ( line -- seq-ranges ) 
    "," split
    [ "-" split ] map
    ;

: is-dup ( num -- doubled )
    dup
    dup length 2 /i
    head
    dup append
    =
    ;

: update-h ( dup? val hash -- hash ) 
    [ over adjoin ] [ drop ] if
    ;

: get-invalid ( range the-set -- seq-ranges )
    [ first string>number ] [ second string>number ] bi
    [a..b] swap [ dup number>string is-dup update-h ] reduce
    ;

: solve ( -- )
    "./input.txt" utf8 file-lines first get-ranges
    dup .
    HS{ } clone [ get-invalid ] reduce members sum
    .
    ;

MAIN: solve
