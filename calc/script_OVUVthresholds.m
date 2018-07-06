


%% Allgemein

Rhys = 127e3;
Ihys = 63e-3 / Rhys;


%% Netzteil

Uov = 14;
Uuv = 10;

Uhys = 0.1;

Rt = Uhys / Ihys;

Rt = 200e3;

x = [Uov - 1, -1; Uuv - 1, Uuv - 1] \ [Rt; Rt];

Rb = x(1);
Rm = x(2);

Rb = 15.8e3;
Rm = 6.34e3;


cparams = {Rt, Rm, Rb, 0, 0, Ihys, 1, 0, 0};
[Uov_sp, Uovh_sp, Uuv_sp, Uuvh_sp] = LTC4417_getOVUVthresholds(cparams{:});
Uov_sp
Uovh_sp
Uovhys = Uov_sp - Uovh_sp

Uuv_sp
Uuvh_sp
Uuvhys = Uuvh_sp - Uuv_sp


%% Netzteil mit groﬂer UV-Hysterese

Rt = 200e3;

Uov = 15;
Uuv = 9.5;
Uovhys = 0.25;
Uuvhys = 1;

x = [Uov - 1, -1; Uuv - 1, Uuv - 1] \ [Rt; Rt];

Rb = x(1);
Rm = x(2);

Rb = 15e3;
Rm = 8.45e3;


Ro = Rb * (Uovhys - Ihys * (Rt + Rm)) / (Ihys * (Rt + Rm + Rb));
Ru = (Rb + Rm) * (Uuvhys - Ihys * Rt) / (Ihys * (Rt + Rm + Rb));

Ro = 20.0e3;
Ru = 200e3;


cparams = {Rt, Rm, Rb, Ru, Ro, Ihys, 1, 0, 0};
[Uov_sp, Uovh_sp, Uuv_sp, Uuvh_sp] = LTC4417_getOVUVthresholds(cparams{:});
Uov_sp
Uovh_sp
Uovhys = Uov_sp - Uovh_sp

Uuv_sp
Uuvh_sp
Uuvhys = Uuvh_sp - Uuv_sp




%% Akkuwarnung

Uov = inf;
Uuv = 12;
Uhys = 0.1;

Rt = Uhys / Ihys;

Rt = 200e3;

Rm = Rt / (Uuv - 1);
Rb = 0;

Rm = 18.2e3;


cparams = {Rt, Rm, Rb, 0, 0, Ihys, 1, 0, 0};
[Uov_sp, Uovh_sp, Uuv_sp, Uuvh_sp] = LTC4417_getOVUVthresholds(cparams{:});
% Uov_sp
% Uovh_sp
% Uovhys = Uov_sp - Uovh_sp

Uuv_sp
Uuvh_sp
Uuvhys = Uuvh_sp - Uuv_sp



%% Akku

Rt = 200e3;

Uov = 15.5;
Uuv = 10.5;
Uovhys = 0.5;
Uuvhys = 1;

x = [Uov - 1, -1; Uuv - 1, Uuv - 1] \ [Rt; Rt];

Rb = x(1);
Rm = x(2);

Rb = 14.3e3;
Rm = 6.80e3;


Ro = Rb * (Uovhys - Ihys * (Rt + Rm)) / (Ihys * (Rt + Rm + Rb));
Ru = (Rb + Rm) * (Uuvhys - Ihys * Rt) / (Ihys * (Rt + Rm + Rb));

Ro = 51.0e3;
Ru = 174e3;


cparams = {Rt, Rm, Rb, Ru, Ro, Ihys, 1, 0, 0};
[Uov_sp, Uovh_sp, Uuv_sp, Uuvh_sp] = LTC4417_getOVUVthresholds(cparams{:});
Uov_sp
Uovh_sp
Uovhys = Uov_sp - Uovh_sp

Uuv_sp
Uuvh_sp
Uuvhys = Uuvh_sp - Uuv_sp






%% Unsicherheitsanalyse


% Rt, Rm, Rb, Ru, Ro, Ucomp, Ihys, Ucomp, Iovleak, Iuvleak

% Netzteil
%params = [200e3, 6.34e3, 15.8e3, 0, 0, 496e-9, 1, 0, 0];
params = [200e3, 8.45e3, 15.0e3, 200e3, 20.0e3, 496e-9, 1, 0, 0];

% Akkuwarnung
%params = [200e3, 18.2e3, 0, 0, 0, 496e-9, 1, 0, 0];

% Akku
%params = [200e3, 6.80e3, 14.3e3, 174e3, 51.0e3, 496e-9, 1, 0, 0];

cparams = num2cell(params);
nomRes = LTC4417_getOVUVthresholds(cparams{:});
%[Uov, Uovh, Uuv, Uuvh]


nP = length(params);

relErrRes = 0.01;
relErrIhys = 0.01;
relErrComp = 0.015;
absErrILeak = 20e-9;

vRelErrRes = [1 - relErrRes, 1, 1 + relErrRes];
vRelErrIhys = [1 - relErrIhys, 1, 1 + relErrIhys];
vRelErrComp = [1 - relErrComp, 1, 1 + relErrComp];
vAbsErrILeak = [-absErrILeak, 0, absErrILeak];

dparams = cell(nP, 1);

dparams{1} = num2cell(unique( vRelErrRes * params(1) ));
dparams{2} = num2cell(unique( vRelErrRes * params(2) ));
dparams{3} = num2cell(unique( vRelErrRes * params(3) ));
dparams{4} = num2cell(unique( vRelErrRes * params(4) ));
dparams{5} = num2cell(unique( vRelErrRes * params(5) ));
dparams{6} = num2cell(unique( vRelErrIhys * params(6) ));
dparams{7} = num2cell(unique( vRelErrComp * params(7) ));
dparams{8} = num2cell(unique( vAbsErrILeak + params(8) ));
dparams{9} = num2cell(unique( vAbsErrILeak + params(9) ));


vNElements = cellfun(@length, dparams);

mRes = zeros(prod(vNElements), 4);

vid = [];
k = 0;

pb = ProgressBar(prod(vNElements));

while (true)
	pb = updateinc(pb);
	
	k = k + 1;
	vid = getNextPermutation(vid, vNElements);
	
	if isempty(vid)
		break;
	end

	curparams = cellfun(@(a, b) a{b}, dparams, num2cell(vid), ...
												'UniformOutput', false);
	mRes(k, :) = LTC4417_getOVUVthresholds(curparams{:});	
end

delete(pb);



nS = size(mRes, 1);
x = ones(nS, 1);
x = [x; 2*x; 3*x; 4*x];

y = reshape(mRes, 4 * nS, 1);

subplot(1, 2, 1);
plot(x, y, 'x');
xlim([0.5, 4.5]);

hold('all');
plot([1; 2; 3; 4], nomRes, 'ro');
hold('off');



x = ones(nS, 1);
x = [x; 2*x];
y = [mRes(:,1) - mRes(:,2); mRes(:,4) - mRes(:,3)];

subplot(1, 2, 2);
plot(x, y, 'x');
xlim([0.5, 2.5]);

hold('all');
plot([1; 2], [nomRes(1) - nomRes(2); nomRes(4) - nomRes(3)], 'ro');
hold('off');

%%

subplot(1, 2, 1);
plot([1; 1], [min(mRes(:,1)), max(mRes(:,1))]);
hold('on');
plot([2; 2], [min(mRes(:,2)), max(mRes(:,2))]);
plot([3; 3], [min(mRes(:,3)), max(mRes(:,3))]);
plot([4; 4], [min(mRes(:,4)), max(mRes(:,4))]);
hold('off');
xlim([0.5, 4.5]);

hold('all');
plot([1; 2; 3; 4], nomRes, 'ro');
hold('off');



x = ones(nS, 1);
x = [x; 2*x];
y = [mRes(:,1) - mRes(:,2); mRes(:,4) - mRes(:,3)];

subplot(1, 2, 2);
plot([1; 1], [min(mRes(:,1) - mRes(:,2)), max(mRes(:,1) - mRes(:,2))]);
hold('on');
plot([2; 2], [min(mRes(:,4) - mRes(:,3)), max(mRes(:,4) - mRes(:,3))]);
xlim([0.5, 2.5]);

hold('all');
plot([1; 2], [nomRes(1) - nomRes(2); nomRes(4) - nomRes(3)], 'ro');
hold('off');

