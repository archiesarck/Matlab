x = input('Is the function a polynomial?(y/n): ','s');
if x=='n'
    proc = input('Enter the code for the proccess:\n1.Bisection\n2.NR\n3.False Position\n4.Fixed Point\n5.Secant\n');
    if proc==1
        bisection;
    elseif proc==2
        newtonr;
    elseif proc==3
        fpos;
    elseif proc==4
        fpoint;
    elseif proc==5
        secant;
    else
        disp('Wrong input');
    end
elseif x=='y'
    proc = input('Enter the code for the proccess:\n1.Muller\n2.Bairstrow\n');
    if proc==1
        muller;
    elseif proc==2
        bairstrow;
    end
end