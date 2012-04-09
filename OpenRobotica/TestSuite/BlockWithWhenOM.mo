within OpenRobotica.TestSuite;
block BlockWithWhenOM "Test when branches inside blocks"
  //discrete Real nextWriteEventBuf(start=0);
protected
  discrete Real nextWriteEvent(start=0);
  discrete Real nextReadEvent(start=Modelica.Constants.inf);
  discrete Boolean writeEvent(start=false);
  discrete Boolean readEvent(start=false);
equation
          //equation
  writeEvent= time > nextWriteEvent;
  readEvent =time > nextReadEvent;
algorithm
  when { writeEvent, initial()} then
    nextReadEvent := time + 0.02;
  elsewhen (readEvent) then
    nextWriteEvent := nextWriteEvent + 0.1;
  end when;
end BlockWithWhenOM;
