import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  return runApp(
    MaterialApp(
      title: "X and O",
    color: Colors.black,
    debugShowCheckedModeBanner: false,
    home:Myapp()
    )
  );
} 

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Game();
  }
}

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  List<List<String>> grid=[[' ',' ',' '],[' ', ' ', ' '],[ ' ',' ', ' ']];
  int times=0;
  void reset(){
    times=0;
    game=true;
    int i,j;
    result='X Play';
    for(i=0;i<3;i++){
      for (j=0;j<3;j++){
        grid[i][j]=' ';
      }
    }
    setState(() {
      
    });
  }
  String result='X Play';
  void prin(String c){
    game=false;
    setState(() {
      result=c+' Won';
    });
  }
  void check(){
    int i,j;
    String c;
    for(i=0;i<3;i++){
      c=grid[i][0];
      for(j=1;j<3;j++){
        if (grid[i][j]!=c || grid[i][j]==' ') break;
        if (j==2) prin(c);
    }}
    for(i=0;i<3;i++){
      c=grid[0][i];
      for(j=1;j<3;j++){
        if (grid[j][i]!=c || grid[j][i]==' ') break;
        if (j==2) prin(c);
    }}
    c=grid[0][0];
    for(i=1;i<3;i++){
      if (grid[i][i]!=c || grid[i][i]==' ') break;
        if (i==2) prin(c);
    }
    c=grid[0][2];
    for(i=1;i<3;i++){
      if (grid[i][2-i]!=c || grid[i][2-i]==' ') break;
        if (i==2) prin(c);
    }
  }
  bool game=true;
  void change(int i, int j){
    String c=' ';
    if(times%2==0 && grid[i][j]==' ') {
      c='X';
      setState(() {
        result='O Play';
      });
    }
    else if(grid[i][j]==' '){
      c='O';
      setState(() {
        result='X Play';
      });
    }
    if (grid[i][j]==' ' && game){
    setState(() {
      grid[i][j]=c;
      times++;
    });
    }
    check();
    if(game && times==9){
      setState(() {
        result='Draw';
      });
    }
  }
  Color ofx=Colors.red;
  Color ofo=Colors.blue;
  Color getcol(String ok){
    if (ok=='X'){
      return ofx;
    }
    else{
      return ofo;
    }
  }
  Color bac=Colors.grey[800];
  Color bac0=Colors.grey[100];
  bool them=true;
  Widget but(int e,int f){
    return OutlineButton(highlightedBorderColor:bac0,borderSide: BorderSide(width:2,color: bac0),padding:EdgeInsets.all(20),onPressed: ()=>change(e,f), child: Text('${grid[e][f]}',style:TextStyle(color: Colors.red,fontSize:30)));
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: bac,
        drawer: Drawer(child:Container(color: bac0,child: 
        Column(
          children: <Widget>[
            SizedBox(height:50),
            Card(color:bac0,child:Row(children: <Widget>[
              Expanded(flex:1,child: Icon(Icons.format_color_fill,color: bac,size:20)),
              Expanded(flex:3,child: Text("Dark Theme",style: TextStyle(color:bac,fontSize: 24),)),
              Expanded(
                flex: 1,
                child: Switch(inactiveTrackColor:Colors.grey, value:them,onChanged: (bool)=>{
                  setState((){
                    them=!them;
                    Color temp=bac0;
                    bac0=bac;
                    bac=temp;
                  })
                },),
              )
          ],)),
          
          ]
        ),)),
        appBar: AppBar(backgroundColor:Colors.transparent,elevation:0),
        body:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text('$result',style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: bac0,       
            ),),
            SizedBox(height: 50,),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              but(0,0),
              but(0,1),
              but(0,2),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              but(1,0),
              but(1,1),
              but(1,2)
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
              but(2,0),            
              but(2,1),
              but(2,2),
            ]),
            SizedBox(height:50),
            FlatButton(onPressed: ()=>reset(),color:bac0 ,child: Text('Reset',style: TextStyle(fontSize:22,fontWeight: FontWeight.bold,color: bac),))
          ],),
      );
  }
}
