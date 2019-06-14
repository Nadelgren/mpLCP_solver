function [sol,fval,exitflag] = use_fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options,options2,options3)

% a = zeros(size(x0));
% a(1) = rand(1,1);
% a2(2) = rand(1,1)*a(1);
% x0 = a

[sol,fval,exitflag] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
if(exitflag >= 1)
    return
else
%     if(exitflag == -2)
%         [sol,fval,exitflag] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options3);
%     else
%         sol
%         exitflag
%         max_err = max(nonlcon(sol));
%         if(max_err < .5)
%             options2 = optimoptions('fmincon','Algorithm','sqp','Display', 'off','ConstraintTolerance',abs(max_err)/2.);
%         end
%         a = rand(1,1);
%         a2 = rand(1,1)*a;
%         x0 = [a,a2,0]
        [sol,fval,exitflag] = fmincon(fun,sol,A,b,Aeq,beq,lb,ub,nonlcon,options2);
%         sol
%         exitflag
%          max_err = max(nonlcon(sol));
%     end
    if( (exitflag >= 1))% || exitflag == -2))% && max_err > 0.5)
        return
    else
%         sol
%         exitflag
%         max_err = max(nonlcon(sol));
%         if(max_err < .5)
%             options3 = optimoptions('fmincon','Algorithm','sqp','Display', 'off','MaxIterations',4000,'MaxFunctionEvaluations',8000,'ConstraintTolerance',abs(max_err)/2.);
%         elseif(exitflag == 0)
%             options3 = optimoptions('fmincon','Algorithm','interior-point','Display', 'off','MaxIterations',8000,'MaxFunctionEvaluations',16000,'ConstraintTolerance',.00000001); 
%         end
%         a = rand(1,1);
%         a2 = rand(1,1)*a;
%         x0 = [a,a2,0]
        [sol,fval,exitflag] = fmincon(fun,sol,A,b,Aeq,beq,lb,ub,nonlcon,options3);
        if(exitflag == 0)
            [sol,fval,exitflag] = fmincon(fun,sol,A,b,Aeq,beq,lb,ub,nonlcon,options2);
        end
%         sol
%         exitflag
%         max_err = max(nonlcon(sol))
        return
    end
end
