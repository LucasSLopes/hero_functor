functor
import 
    Circuitos at 'circuitos.ozf'
    Browser
define
    A = [1 1 0 1]
    B = [1 0 1 0]
    S = [1 0]

    MuxAResult = {Circuitos.mux S A}
    MuxBResult = {Circuitos.mux S B}

    {Browser.browse 'A:'}
    {Browser.browse A}
    {Browser.browse 'B:'}
    {Browser.browse B}

    {Browser.browse 'A igual B?'}
    {Browser.browse {Circuitos.aEqualB A B}}

    {Browser.browse 'Mux A & B | S = 1 0'}
    {Browser.browse MuxAResult}
    {Browser.browse MuxBResult}

    {Browser.browse 'Demux A & B| S = 1 0'}
    {Browser.browse {Circuitos.demux S MuxAResult}}
    {Browser.browse {Circuitos.demux S MuxBResult}}
end
    