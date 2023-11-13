declare
fun {NotGate Xs}
   case Xs of X|Xr then (1-X)|{NotGate Xr}
   else nil
   end
end

fun {GateMaker F}
   fun {$ Xs Ys}
      fun {GateLoop Xs Ys}
	 case Xs#Ys of (X|Xr)#(Y|Yr) then
	    {F X Y}|{GateLoop Xr Yr}
	 else
	    nil
	 end
      end
   in
      thread {GateLoop Xs Ys} end
   end
end


%Portas =================================
declare
NotG = NotGate
AndG ={GateMaker fun {$ X Y} X*Y end}
OrG ={GateMaker fun {$ X Y} X+Y-X*Y end}
NandG={GateMaker fun {$ X Y} 1-X*Y end}
NorG ={GateMaker fun {$ X Y} 1-X-Y+X*Y end}
XorG ={GateMaker fun {$ X Y} X+Y-2*X*Y end}


%Circuitos =================================
declare
% Retorna 1 se A == B
fun {AEqualB A B}
   local Xor0 Xor1 Xor2 Xor3 And0 And1 And2
   in
      Xor0 = {NotG {XorG A.2.2.2.1|nil B.2.2.2.1|nil}}
      Xor1 = {NotG {XorG A.2.2.1|nil B.2.2.1|nil}}
      Xor2 = {NotG {XorG A.2.1|nil B.2.1|nil}}
      Xor3 = {NotG {XorG A.1|nil B.1|nil}}
      
      And0 = {AndG Xor0 Xor1}
      And1 = {AndG Xor2  Xor3}
      And2 = {AndG And0 And1}
      And2.1 
   end
end

{Browse {AEqualB [1 0 0 1] [1 0 0 1]}}

fun {Demux4 S X}
   local X0 X1 X2 X3 Result
   in
      X0 = {AndG X {AndG {NotGate S.1|nil} {NotGate S.2.1|nil}}}
      X1 = {AndG X {AndG {NotGate S.1|nil} S.2.1|nil}}
      X2 = {AndG X {AndG S.1|nil {NotGate S.2.1|nil}}}
      X3 = {AndG X {AndG S.1|nil S.2.1|nil}}

      Result = X3.1|X2.1|X1.1|X0.1|nil
   end
end   

fun {Mux4 S X}
   local S00 S01 S10 S11 Result
   in
      S00 =  {AndG X.2.2.2.1|nil {AndG {NotGate S.1|nil} {NotGate S.2.1|nil}}}
      S01 =  {AndG X.2.2.1|nil {AndG {NotGate S.1|nil} S.2.1|nil}}
      S10 =  {AndG X.2.1|nil {AndG S.1|nil {NotGate S.2.1|nil}}}
      S11 =  {AndG X.1|nil {AndG S.1|nil S.2.1|nil}}
      
      Result = {OrG {OrG S00 S01} {OrG S10 S11}}
    end 
end

declare
S = [0 0]
X = [1 1 1 1]
Mux = {Mux4 S X}
Demux = {Demux4 S Mux}

{Browse Mux}
{Browse Demux}
