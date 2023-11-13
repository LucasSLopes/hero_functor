functor
import
   Portas at 'portas.ozf'
export
   aEqualB: AEqualB
   demux: Demux
   mux: Mux 
define
% Retorna 1 se A == B
   fun {AEqualB A B}
      local Xor0 Xor1 Xor2 Xor3 And0 And1 And2
      in
        Xor0 = {Portas.notGate {Portas.xorG A.2.2.2.1|nil B.2.2.2.1|nil}}
        Xor1 = {Portas.notGate {Portas.xorG A.2.2.1|nil B.2.2.1|nil}}
        Xor2 = {Portas.notGate {Portas.xorG A.2.1|nil B.2.1|nil}}
        Xor3 = {Portas.notGate {Portas.xorG A.1|nil B.1|nil}}
      
        And0 = {Portas.andG Xor0 Xor1}
        And1 = {Portas.andG Xor2 Xor3}
        And2 = {Portas.andG And0 And1}
	 if And2.1 == 1 then
	    true
	 else 
	    false
	 end
      end
   end

   fun {Demux S X}
      local X0 X1 X2 X3
      in
        X0 = {Portas.andG X {Portas.andG {Portas.notGate S.1|nil} {Portas.notGate S.2.1|nil}}}
        X1 = {Portas.andG X {Portas.andG {Portas.notGate S.1|nil} S.2.1|nil}}
        X2 = {Portas.andG X {Portas.andG S.1|nil {Portas.notGate S.2.1|nil}}}
        X3 = {Portas.andG X {Portas.andG S.1|nil S.2.1|nil}}

	    X3.1|X2.1|X1.1|X0.1|nil
      end
   end   

   fun {Mux S X}
      local S00 S01 S10 S11
      in
        S00 =  {Portas.andG X.2.2.2.1|nil {Portas.andG {Portas.notGate S.1|nil} {Portas.notGate S.2.1|nil}}}
        S01 =  {Portas.andG X.2.2.1|nil {Portas.andG {Portas.notGate S.1|nil} S.2.1|nil}}
        S10 =  {Portas.andG X.2.1|nil {Portas.andG S.1|nil {Portas.notGate S.2.1|nil}}}
        S11 =  {Portas.andG X.1|nil {Portas.andG S.1|nil S.2.1|nil}}
      
	    {Portas.orG {Portas.orG S00 S01} {Portas.orG S10 S11}}
      end 
   end
end