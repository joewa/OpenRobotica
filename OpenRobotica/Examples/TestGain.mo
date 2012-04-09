within OpenRobotica.Examples;
model TestGain
  Modelica.Blocks.Math.Gain gain(k=2);
  Modelica.Blocks.Sources.Constant constsrc(k={3,4});
equation
  connect(constsrc.y, gain.u);
end TestGain;
