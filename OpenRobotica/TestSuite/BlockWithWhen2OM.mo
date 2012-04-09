within OpenRobotica.TestSuite;
block BlockWithWhen2OM "Test when branches inside blocks"
  function processWriteEvent
  //input String fifoName;
  //input Integer dummy;  // force execution order in equation sections
  input Modelica.SIunits.Time t;
  output Real nextReadEvent;
  algorithm
    nextReadEvent := t + 0.02;
  end processWriteEvent;

  function processReadEvent
  input Real lastWriteEvent;
  //input Integer dummy;  // force execution order in equation sections
  output Real nextWriteEvent;
  algorithm
    nextWriteEvent := lastWriteEvent + 0.1;
  end processReadEvent;

protected
  discrete Real nextWriteEvent(start=0);
  discrete Real nextReadEvent(start=Modelica.Constants.inf);
  Boolean writeEvent(start=false);
  Boolean readEvent(start=false);
equation
  writeEvent = pre(nextWriteEvent) <= time;
  readEvent = pre(nextReadEvent) <= time;
  when {initial()} then

  end when;
  when { writeEvent} then
    nextReadEvent =  processWriteEvent(time);
  end when;
  when { readEvent} then
    nextWriteEvent =  processReadEvent(nextWriteEvent);
  end when;
end BlockWithWhen2OM;
