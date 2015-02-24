/*
* Uso: User Interface para projeto Speech
* Data: 16/10/2014
* Por: Daniel de Castro Rodrigues 
* Com: Vitor Hugo Carvalho de Sá
* Para: MakroLab
*/


int Senval=0;
int Senpin=A0;
int OutPut=0;
int Break=0;

void setup()
{
  Serial.begin(9600);
}


void loop()
{
 Senval = analogRead(Senpin);
 
 if (Senval >= 20 && Senval < 150){
   OutPut = 111;
   

 }else if(Senval >= 150 && Senval < 280){ 
   OutPut = 222;
 

 }else if(Senval >= 280){
   
 
   OutPut = 222;
   
   for (int i = 0; i < 5 ; i++){
     
     if (Break >= 50){

       Serial.println(999);
       delay(2000);
       break; 
       
     }
     
     OutPut+=111;
     
     Serial.println(OutPut);
     
     delay(2000);
     Break=analogRead(Senpin);
     

     
   }
   Break=analogRead(Senpin);
   OutPut=0;
   
 }else{
   //Serial.println(Senval);
   OutPut=0;
 }
 Serial.println(OutPut);
 delay(2000);
}
//309
