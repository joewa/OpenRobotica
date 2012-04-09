within OpenRobotica.Machines.Xcopter;
function DiscontCurrent
input Real pwm_cmd;
input Modelica.SIunits.Voltage vBatt "Battery voltage";
input Modelica.SIunits.Voltage bemfin "Back-EMF";

input Modelica.SIunits.Resistance Ra = 0.33 "warm armature resistance";
input Modelica.SIunits.Inductance La = 35e-6 "armature inductance";
input Modelica.SIunits.Frequency f_pwm = 16000 "PWM frequency";

output Modelica.SIunits.Current ia "Back-EMF";

  import Modelica.Math.log;
//extends BlParam;
// import Modelica.Math;

protected
  Modelica.SIunits.Voltage bemf;
  Modelica.SIunits.Duration t_pwm "PWM period";
  Modelica.SIunits.Duration t_on "on time";
  Modelica.SIunits.Duration t_off "off time";
  Modelica.SIunits.Duration t_gap "gap time";
  Modelica.SIunits.Current imax;
  Modelica.SIunits.Current k_on;
  Modelica.SIunits.Current k_off;
  Modelica.SIunits.Current ia_int "lueckender Strom";
  Modelica.SIunits.Current ia_cont "nichtlueckender Strom";
algorithm
  bemf:=-bemfin;
  t_pwm :=1/f_pwm;
  k_on:= 1/Ra * (vBatt - bemf);
  k_off:= -1/Ra * bemf;
  t_on := pwm_cmd*t_pwm;
  imax := k_on*(1 - exp(-1/(La/Ra)*t_on));   //ON
  if (abs(imax) < 1e-4) then // keine Spannung, Motor steht
    t_off:= 0;
    t_gap:= t_pwm;
    ia:= 0;
  else
    if (-k_off/(imax-k_off) > 0) then // Strom geht in endlicher Zeit auf 0 zurueck
      t_off:= -La/Ra * Modelica.Math.log(-k_off/(imax-k_off)); // -k_off/(k_on-k_off) muss > 0 !!!
    else
      t_off:=t_pwm;
    end if;
    t_gap:= t_pwm - (t_on + t_off);
    if (t_gap > 0) then       //Strom lueckt
      ia_int:= imax/2 * (1 - t_gap/t_pwm); //Ist Strom hinreichend 3-eckig?
      ia:= ia_int;
    else                      // Strom lueckt nicht
      ia_cont:= (pwm_cmd*vBatt - bemf) / Ra;
      ia :=ia_cont;
    end if;
  end if;
end DiscontCurrent;
