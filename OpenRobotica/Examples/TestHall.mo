within OpenRobotica.Examples;
model TestHall "Test model for the hall sensors"

  Modelica.Mechanics.Rotational.Speed speed;
  Modelica.Mechanics.Rotational.Fixed fixed;
  Sensors.HallDigital123 hallDigital123(Ppz=2);
equation
   //connect(speed.bearing, fixed.flange_b);
   connect(speed.flange_b, hallDigital123.flange_a);
   speed.w_ref = 10;
end TestHall;
