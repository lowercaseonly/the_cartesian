int counter = 0;

void setup() {
  // put your setup code here, to run once:
  DDRD = 0b11111111;
  counter = 0;
}

void loop() {
  // put your main code here, to run repeatedly:

  delay(1);
  PORTD |= 0b00000001;
  delay(1);
  PORTD &= 0b11111110;
  counter++;

  if (counter%500==0)
    PORTD |= 0b00000010;
  if (counter%1000==0)
    PORTD &= 0b11111101;

}