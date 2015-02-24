/*
* Uso: User Interface para projeto Speech
* Data: 17/10/2014
* Por: Daniel de Castro Rodrigues 
* Para: MakroLab
*/


//Importa lib de conexão so BD
import de.bezier.data.sql.*;
//Importa lib para acesso às portas seriais
import processing.serial.*;
//Importa lib que permite  uso de audio
import ddf.minim.*;
//Importa lib para uso em FullScreen 
import fullscreen.*; 




final static String ICON  = "imgs/speech_icon.png";
final static String TITLE = "Interface Speech";


/* --------------------- ** AUDIO ** --------------------- */
//Cria objeto de audio minim
Minim minim;
//Cria objeto de imput
AudioInput input;
//Cria Players de audio
AudioPlayer sim;
AudioPlayer nao;
AudioPlayer fala;


/* --------- ** VARIAVEIS ACESSO AO BD MySQL ** --------- */
//Cria objeto MySQL pra conexão
MySQL conecta;
//Usuario MySQL
String user     = "root";
//Senha - Nese caso Xampp padrão sem senha
String pass     = "";
//Banco de dados
String database = "Db_Interface";
//Tabela
String table    = "Tb_Palavras";

//Array a ser montado com os valores da coluna Palavras
String[] lista = new String[500];
//Array a ser montado com os valores da coluna File
String[] file = new String[500];
//Array a ser montado com os valores da coluna Ordem
int[] od = new int[500];


/* --------------- ** VARIAVEIS GERAIS ** --------------- */
//Cria objeto PFont para nova fonte de titulo
PFont Titulo;
//Cria objeto PFont para nova fonte de texto
PFont TxtF;



int numFrames = 4;
int currentFrame = 0;
PImage Back;
PImage[] images = new PImage[5];
PImage soundIcon;



//Texto a ser exibido / palavra escolhida ou aguarde
String Fala="Aguarde";
//Exibe valor de entrada
int Press=0;
//Cor para setar cor do fundo
color bg;
//Buffer para captura da porta serial
String buffer = "";
//Valor capturado da porta serial
int val = 0;
//Cria objeto Serial com a porta a ser escutada
Serial port;
//Cria objeto para uso em Full Screen
FullScreen full;
// calibri bold
//ba0904
String sub = "" ;
String esc = "";

int z=0;
//String Teste="123Testando";




void changeAppIcon(PImage img) {
  final PGraphics pg = createGraphics(16, 16, JAVA2D);

  pg.beginDraw();
  pg.image(img,0,0,16,16);
  pg.endDraw();

  frame.setIconImage(pg.image);
}

void changeAppTitle(String title) {
  frame.setTitle(title);
}


//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
void setup()
{
  //Tamanho da janela setado como tamanho do monitor
  size(1360, 768);
  //
  changeAppIcon( loadImage(ICON) );
  changeAppTitle(TITLE);
  //
  Back = loadImage("imgs/Speech_inicio.png");

  //
  Titulo=createFont("Arial",90,true); 
  //
  TxtF=createFont("Arial",80,true);  
  //Seta objeto full como novo
  full = new FullScreen(this); 
  //Usa objeto full para aplicar o Full Screen
  full.enter();
  //Seta objeto minim como novo
  minim=new Minim(this);
  
  //Marca objeto port com a pota do arduino - neste caso COM5
  port = new Serial(this, "COM3", 9600);  
  //fill(255); 
  //println(Serial.list());
  //String arduinoPort = Serial.list()[1];

/* ---------------------- ** ACESSO AO BD MySQL ** ----------------------- */
  //Marca objeto conecta com acesso ao BD
  conecta = new MySQL( this, "localhost", database, user, pass );

  //Verifica se houve conexão corretmente
  if ( conecta.connect() )
  { 
    //Variavel i de contagem
    int i=0;
    //Seleciona os itens da tabela
    conecta.query( "SELECT * FROM "+table );
    //Enquanto huver nova linha na tabela
    while (conecta.next()){
      //Seleciona a coluna Palavra
      String palavra =conecta.getString("Palavra");
      //Preenche o array lista com nova palavra
      lista[i] = (palavra);
      //Seleciona a coluna File
      String a = conecta.getString("File");
      //Preenche o array file com os nomes dos arquivos
      file[i]=(a);
      //Seleciona a coluna Ordem
      int n = conecta.getInt("Ordem");
      //Preenche o array od com os valores da ordem de listagem
      od[i] = (n);
      
      //Print abaixo para verificar os valores capturados do BD
      print(od[i]+"  "+lista[i] + "   " + file[i]+" | ");
      //Soma contagem i      
      i++;
    }
  //Carrega arquivos de audio no player sim
  sim=minim.loadFile("sounds/"+file[0]);
  //Carrega arquivos de audio no player nao
  nao=minim.loadFile("sounds/"+file[1]); 
  //
  fala = minim.loadFile("sounds/"+file[2]);
  
  }else{//Se a conexão apresentou erro 18694
    // Exibe erro de acesso!
    println("Erro ao acessar o Banco de Dados!");
    println("1 - Verifique se o servidor está On-Line");
    println("2 - Verifique se o Banco de dados está nomeado corretamente");
    stop();
  }
  
  images[4] = loadImage("imgs/audio_icon/audio_icon.fw.png");
  images[3] = loadImage("imgs/audio_icon/audio_icon_2.fw.png");
  images[2] = loadImage("imgs/audio_icon/audio_icon_3.fw.png");
  images[1] = loadImage("imgs/audio_icon/audio_icon_4.fw.png");
  images[0] = loadImage("imgs/audio_icon/audio_icon_inativo0.png");
}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------//
void draw() {
  frameRate(8);
  //Cor de fundo
  bg = color(112,147,219);
  //Seta o bacground com a cor escolhida
  background(bg);
  //stroke(255);
  //fill(255);
  
  

/* ---------------------- ** OBJETOS QUE APARECEM NA TELA ** ----------------------- */
  //
  noTint();
  image(Back,0,0);
 

  fill(186,9,4);
  textFont(TxtF,150);
  //texto comum
  
  //Palavra "falada"
  text(Fala, 680, 484);
  textAlign(CENTER);


  image(images[0], 247, 583);
currentFrame = (currentFrame+1) % numFrames;  // Use % to cycle through frames
  if (sim.isPlaying() || nao.isPlaying() || fala.isPlaying()){
    image(images[(currentFrame) % numFrames], 247, 583);
    
  }

/* ------------------------------ ** PORTA SERIAL ** ------------------------------- */
  //Verifica se porta está acessivel e com arduino
  if (port.available() > 0){
    //Cria variavel inByte com valor lido da porta
    int inByte = port.read();
    //Verifica se a entrada de dados não é nula
    if(inByte != 10){
      //
     
      buffer = buffer + char(inByte);
    }else{ // a entrada de dados for valida
      //verifica tamanho do valor recebido    
      if(buffer.length() > 1){
        //Limpa a variavel buffer
        buffer = buffer.substring(0,buffer.length() -1);
        //Seta de buffer como inteiro em val
        val= int(buffer);
        //Muda o texto de Press para o valor de val
        Press=val;
             
        //conecta.query("INSERT INTO `Db_Interface`.`Registros` (`Id`, `Palavra`, `Data`) VALUES (NULL, '"+lista[2]+"', CURRENT_TIMESTAMP);");
        
        
        switch(val){
          case 111:
            
            sim.rewind();
            z=0;
            Fala=lista[z];          
            sim.play();
            
            if(nao.isPlaying()){
               nao.rewind();
            }
            break;
            
          case 222:
            z=1;
            nao.rewind();
            image(images[(currentFrame) % numFrames], 247, 583);
            Fala=lista[z]; 
            nao.play();
            if (sim.isPlaying()){
               sim.rewind();
            }
            break;
            
          case 333:
            Fala="Pensando";
            z=2;
            image(images[(currentFrame) % numFrames], 247, 583);
            esc=lista[z];
            fala = minim.loadFile("sounds/"+file[z]);
            fala.play();
            
            if (sim.isPlaying()){
                sim.rewind();
            }else if(nao.isPlaying()){
                nao.rewind();
            }
         
            break;
            
          case 444:
             Fala="Pensando.";
             z=3;
             esc=lista[z];
             fala=minim.loadFile("sounds/"+file[z]) ;
             image(images[(currentFrame) % numFrames], 247, 583);

             fala.play();
             
             break;
             
          case 555:
            Fala="Pensando..";
            z=4;
            esc=lista[z];
            fala=minim.loadFile("sounds/"+file[z]) ;
            image(images[(currentFrame) % numFrames], 247, 583);

            fala.play();
            
           
            break;
            
          case 666:
            
            z=5;
            esc=lista[z];
            fala=minim.loadFile("sounds/"+file[z]) ;
            image(images[(currentFrame) % numFrames], 247, 583);

            fala.play();
            
            break;
            
          case 999:
            
            Fala=esc;
            fala=minim.loadFile("sounds/"+file[z]) ;
            conecta.query("INSERT INTO `Db_Interface`.`Registros` (`Id`, `Palavra`, `Data`) VALUES (NULL,'"+Fala+"', CURRENT_TIMESTAMP);");
            
            print(Fala);
            image(images[(currentFrame) % numFrames], 247, 583);
            fala.play(); 
            break;
            
          default:
          
            nao.pause();
            sim.pause();
            if (sim.isPlaying()){
              sim.rewind();
            }else if(nao.isPlaying()){
              nao.rewind();
            }
            Fala="Aguarde";
            break;
          
        }
        buffer="0";
        
        port.clear();
      
      }
    }
  }
}

void stop() {
  sim.close();
  nao.close();
  //buffer.stop();
  minim.stop(); 
  super.stop();
}


//309
