within OpenRobotica.TestSuite;
block BlockWithWhen "Test when branches inside blocks"
  //discrete Real nextWriteEventBuf(start=0);
protected
  discrete Real nextWriteEvent(start=0);
  discrete Real nextReadEvent(start=1000);
equation
   when (time >= nextWriteEvent) then
    nextReadEvent = time + 0.001;
  end when;

  when (time > nextReadEvent) then
    nextWriteEvent = nextWriteEvent+0.01; //Buf
  end when;
end BlockWithWhen;
