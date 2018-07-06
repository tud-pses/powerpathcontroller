function [Uov, Uovh, Uuv, Uuvh] = ...
				LTC4417_getOVUVthresholds(Rt, Rm, Rb, Ru, Ro, ...
											Ihys, Ucomp, Iovleak, Iuvleak)
	
	Io = Iovleak;
	Iu = Iuvleak;
	
	Rges = Rt + Rm + Rb;
	
	Uuv = Rges / (Rm + Rb) * Ucomp ...
			- (Rt + Ru * Rges / (Rm + Rb)) * Iu ...
			- Rt * Rb / (Rm + Rb) * Io;

	Uov = Rges / Rb * Ucomp ...
			- Rt * Iu ...
			- (Rm + Rt + Ro * Rges / Rb) * Io;

	Io = Iovleak;
	Iu = Iuvleak - Ihys;

	Uuvh = Rges / (Rm + Rb) * Ucomp ...
			- (Rt + Ru * Rges / (Rm + Rb)) * Iu ...
			- Rt * Rb / (Rm + Rb) * Io;
	
	Io = Iovleak + Ihys;
	Iu = Iuvleak;

	Uovh = Rges / Rb * Ucomp ...
			- Rt * Iu ...
			- (Rm + Rt + Ro * Rges / Rb) * Io;
		
	if (nargout < 2)
		Uov = [Uov; Uovh; Uuv; Uuvh];
	end

end % function LTC4417_getOVUVthresholds
