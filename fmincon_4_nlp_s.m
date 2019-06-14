function [sol,fval,exitflag] = fmincon_4_nlp_s(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options,options2,options3)

[sol,fval,exitflag] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options);
sol2 = [];
fval2 = 0;
exitflag2 = 0;
if(exitflag >= 1)
    [sol2,fval2,exitflag2] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options2);
    if(exitflag2 >= 1 && fval2 < fval)
       sol = sol2;
       fval = fval2;
    end
    [sol2,fval2,exitflag2] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options3);
    if(exitflag2 >= 1 && fval2 < fval)
      sol = sol2;
      fval = fval2;
    end
end

return
